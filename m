Return-Path: <linux-kernel-owner+w=401wt.eu-S1751178AbXAIOjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbXAIOjf (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 09:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbXAIOjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 09:39:35 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58630 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751178AbXAIOje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 09:39:34 -0500
Date: Tue, 9 Jan 2007 15:39:12 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Kawai, Hidehiro" <hidehiro.kawai.ez@hitachi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       gregkh@suse.de, james.bottomley@steeleye.com,
       Satoshi OSHIMA <soshima@redhat.com>,
       "Hideo AOKI@redhat" <haoki@redhat.com>,
       sugita <yumiko.sugita.yf@hitachi.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] binfmt_elf: core dump masking support
Message-ID: <20070109143912.GC19787@elf.ucw.cz>
References: <457FA840.5000107@hitachi.com> <20061213132358.ddcaaaf4.akpm@osdl.org> <20061220154056.GA4261@ucw.cz> <45A2EADF.3030807@hitachi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A2EADF.3030807@hitachi.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > When a new process is created, the process inherits the coremask
> > > setting from its parent. It is useful to set the coremask before
> > > the program runs. For example:
> > > 
> > >   $ echo 1 > /proc/self/coremask
> > >   $ ./some_program
> >
> > User can already ulimit -c 0 on himself, perhaps we want to use same
> > interface here? ulimit -cmask=(bitmask)?
> 
> Are you saying that 1) it is good to change ulimit (shell programs)
> so that shell programs will read/write /proc/self/coremask when
> the -cmask option is given to ulimit?
> Or, 2) it is good to change ulimit and get/setrlimit so that shell
> programs will invoke get/setrlimit with new parameter?

I'm trying to say 2).

> If the changes are acceptable to bash or other shell community, I think
> the first approach is nice.
> But the second approach is problematic because the bitmask doesn't
> conform to the usage of setrlimit.  You know, setrlimit controls amount
> of resources the system can use by the soft limit and hard limit.
> These limitations don't suit for the bitmask.

Well, you can have it as set of 0-1 "limits"...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
