Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263324AbUCXMsn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 07:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbUCXMsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 07:48:42 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:24197 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263324AbUCXMsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 07:48:41 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]
Date: Wed, 24 Mar 2004 07:48:20 -0500
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, Jonathan Sambrook <swsusp@hmmn.org>,
       Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au> <200403232352.58066.dtor_core@ameritech.net> <20040324102233.GC512@elf.ucw.cz>
In-Reply-To: <20040324102233.GC512@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403240748.31837.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 March 2004 05:22 am, Pavel Machek wrote:
> On ?t 23-03-04 23:52:58, Dmitry Torokhov wrote:
> > On Tuesday 23 March 2004 06:32 pm, Pavel Machek wrote:
> > > Well, I'd hate
> > > 
> > > Nov 10 00:37:51 amd kernel: Buffer I/O error on device sr0, logical block 842340
> > > Nov 10 00:37:53 amd kernel: end_request: I/O error, dev sr0, sector 6738472
> > > 
> > > to be obscured by progress bar.
> > 
> > OK, so you have an error condition on your CD. Does it prevent suspend from
> > completing? If not then I probably would not care about it till later when
> > I see it in syslog... I remember that the one thing that Pat
> > complained
> 
> Except when it is not in syslog, because it was after atomic copy or
> before atomic copy back. swsusp is pretty unique in this respect.
>

And I would consider an error that happens after atomic copy critical. If
this happens all attempts to draw progress bar, etc. should be stopped and
suspend should probably abort as well.

What happens if swsusp1 gets such an error during atomic phase? Will it
continue or abort? If it continues I would imagine user not noticing the
message it it flashes the split second before the box powers off. 

-- 
Dmitry
