Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263004AbUCXExO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 23:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUCXExO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 23:53:14 -0500
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:27059 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263004AbUCXExM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 23:53:12 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]
Date: Tue, 23 Mar 2004 23:52:58 -0500
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, Jonathan Sambrook <swsusp@hmmn.org>,
       Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au> <200403231743.01642.dtor_core@ameritech.net> <20040323233228.GK364@elf.ucw.cz>
In-Reply-To: <20040323233228.GK364@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403232352.58066.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 March 2004 06:32 pm, Pavel Machek wrote:
> Hi!
> 
> > > Also, in your model, where do messages printk()-ed from drivers during
> > > suspend/resume end up? Corrupting screen? Lost from sight and only
> > > accessible from dmesg? I believe driver messages *are* important, and
> > > do not see how they could coexist with eye-candy.
> > > 
> > Well, unless these are error messages that prevent machine from suspending/
> > resuming they are really just another form of eye-candy, nothing more,
> > nothing less.
> 
> Well, I'd hate
> 
> Nov 10 00:37:51 amd kernel: Buffer I/O error on device sr0, logical block 842340
> Nov 10 00:37:53 amd kernel: end_request: I/O error, dev sr0, sector 6738472
> 
> to be obscured by progress bar.
> 
> 									Pavel

OK, so you have an error condition on your CD. Does it prevent suspend from
completing? If not then I probably would not care about it till later when
I see it in syslog... I remember that the one thing that Pat complained
most often is your love for "panic"ing instead of trying to recover. In that
case you understandably want as many preceding messages as possible left
intact on the screen to diagnose the problem. If error recovery is ever done
then some eye-candy probably won't hurt.

Also, if we leave swsusp and suspending alone for a second, I could have
'top' running on console overwriting the very same messages. Should we ban
top?

If error reporting is so important for a box it probably:
- has many more means to notify operator;
- has all eye-candy turned off;
- is not getting suspended anyway.
IOW it's most likely a server running 24/7.

-- 
Dmitry
