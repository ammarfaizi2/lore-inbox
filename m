Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270327AbTGMSK6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 14:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270328AbTGMSK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 14:10:58 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:58898 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S270327AbTGMSK4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 14:10:56 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Pavel Machek <pavel@suse.cz>, Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [Swsusp-devel] Re: Thoughts wanted on merging Software Suspend enhancements
Date: Mon, 14 Jul 2003 02:17:29 +0800
User-Agent: KMail/1.5.2
Cc: swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1057963547.3207.22.camel@laptop-linux> <1058021722.1687.16.camel@laptop-linux> <20030712153719.GA206@elf.ucw.cz>
In-Reply-To: <20030712153719.GA206@elf.ucw.cz>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200307140207.47711.mflt1@micrologica.com.hk>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 July 2003 23:37, Pavel Machek wrote:
> > > > - user can abort at any time during suspend (oh, I forgot, I wanted
> > > > to...) by just pressing Escape
> > >
> > > That seems like missfeature. We don't want joe random user that is at
> > > the console to prevent suspend by just pressing Escape. Maybe magic
> > > key to do that would be acceptable...

Dumb question applicable to 9x% of computers: how do you secure the suspend 
switch and OFF switch, not to mention the power plug or the battery?

As to security many portables have a bios password and no other passwords 
thereafter for the user account. The abort feature events could be enabled 
via swsusp proc entry mainly for (desktop) security. Also, then you ought 
to think about securing suspend events (don't swsusp the webserver please)!

In practice, when suspending, in many cases one would like to abort. Suspend 
should be abortable by ESC and post 1.0: the lid switch and/or suspend switch. 
If you think about it it makes sense to abort suspend instead of having 
to wait 15-40 seconds and reenter the bios password and wait another 10-30 
seconds. (assuming 2.4 speeds)

The way I would use S3/S4 is reboot only for a new kernel, and really use the 
machine portably much more. S3 would be used for short suspends and S4 for 
longer suspends.

In short, this is an _important_ feature _as_ much as S3 and S4.

Regards
Michael

-- 
Powered by linux-2.5.75-mm1. Compiled with gcc-2.95-3 - mature and rock solid

My current linux related activities:
- 2.5 yenta_socket testing
- Test development and testing of swsusp for 2.4/2.5 and ACPI S3 of 2.5 kernel 
- Everyday usage of 2.5 kernel

More info on 2.5 kernel: http://www.codemonkey.org.uk/post-halloween-2.5.txt
More info on swsusp: http://sourceforge.net/projects/swsusp/

