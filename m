Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265600AbTF2H0d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 03:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265601AbTF2H0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 03:26:33 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:4627 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S265600AbTF2H0a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 03:26:30 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: 2.5.73-mm1 nbd: boot hang in add_disk at first call from nbd_init
Date: Sun, 29 Jun 2003 15:32:46 +0800
User-Agent: KMail/1.5.2
Cc: <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
References: <200306271943.13297.mflt1@micrologica.com.hk> <200306281346.53609.mflt1@micrologica.com.hk> <33004.4.4.25.4.1056820826.squirrel@www.osdl.org>
In-Reply-To: <33004.4.4.25.4.1056820826.squirrel@www.osdl.org>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200306291108.47843.mflt1@micrologica.com.hk>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 June 2003 01:20, Randy.Dunlap wrote:
> > On Saturday 28 June 2003 12:55, Michael Frank wrote:
> >> On Saturday 28 June 2003 10:41, Andrew Morton wrote:
> >> > Michael Frank <mflt1@micrologica.com.hk> wrote:
> >> > > Changes were recently made to the nbd.c in 2.5.73-mm1
> >> >
> >> > And tons more will be in -mm2, which I shall prepare right now. Please
> >>
> >> retest on that and if it still hangs, capture the output from pressing
> >> alt-sysrq-T.
> >>
> >> Legacy free, no serial port.
> >>
> >>
> >>
> >> Sorry, -mm2 hang at booting kernel on 2 machines.
> >
> > Oh Murphy! Bug: 250K log buffer causes a hang on boot.
> >
> > Sorry for the shock. I configured the log buffer bigger - 250K and it
> > hangs on boot.
> >
> > Default 14K log buffer all OK, the NBD hang is fixed too.
>
> Default value of 14 is a shift count (2 << 14), which gives a

No sh**,

> 16 KB buffer.
> Did you enter '250' for the shift value?

Yes, I meant 250K bytes. 

> Yes, that wouldn't boot.
> Maybe consult the help text??

I'll put it on a CD under my pillow tonight....

>
> > This was my only config change besides that driver which didn't compile
> > ;)
> >
> > I want a bigger log buffer in preparation for testing swsusp on 2.5. On
> > 2.4, the test io load prevent the big swsusp logs from making it to
> > disk...
>
> Andrew, do you want a min/max limit on the LOG_BUF_SHIFT value,
> now that Roman has added that feature for Kconfig?
>

Making this a shift count is a brilliant trap designed to humble buffalos 
who do not bother to read the documentation. To put a check there would 
just spoil the fun ;)

-- 
Powered by linux-2.5.73-mm2, compiled with gcc-2.95-3 - not fancy but rock solid

My current linux related activities:
- Test development and testing of swsusp
- Everyday usage of 2.5 kernel

More info on the 2.5 kernel: http://www.codemonkey.org.uk/post-halloween-2.5.txt


