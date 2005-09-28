Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbVI1QhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbVI1QhG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 12:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbVI1QhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 12:37:05 -0400
Received: from smtp2.Stanford.EDU ([171.67.16.125]:5837 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S1751409AbVI1QhE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 12:37:04 -0400
Subject: Re: 2.6.14-rc2-rt2
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, dwalker@mvista.com, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, emann@mrv.com,
       yang.yi@bmrtech.com
In-Reply-To: <20050928094805.GA30446@elte.hu>
References: <20050913100040.GA13103@elte.hu> <20050926070210.GA5157@elte.hu>
	 <1127840377.27319.11.camel@cmn3.stanford.edu>
	 <1127862619.4004.48.camel@dhcp153.mvista.com>
	 <1127876673.9430.2.camel@cmn3.stanford.edu>
	 <20050928094805.GA30446@elte.hu>
Content-Type: text/plain
Date: Wed, 28 Sep 2005 09:34:55 -0700
Message-Id: <1127925295.24916.4.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-28 at 11:48 +0200, Ingo Molnar wrote:
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> 
> > > Here's the fix.
> > 
> > Hey thanks! That fixes that, but the compile fails further along:
> > 
> >   CHK     include/linux/compile.h
> >   UPD     include/linux/compile.h
> > arch/i386/kernel/built-in.o(.text+0xf086): In function `do_powersaver':
> > longhaul.c: undefined reference to `safe_halt'
> > arch/i386/kernel/built-in.o(.text+0xf271): In function
> > `longhaul_setstate':
> > longhaul.c: undefined reference to `safe_halt'
> > make: *** [.tmp_vmlinux1] Error 1
> 
> could you try 2.6.14-rc2-rt6, does it build?

No, sorry...

fs/ntfs/aops.c: In function 'ntfs_end_buffer_async_read':
fs/ntfs/aops.c:108: error: 'BH_Uptodate_Lock' undeclared (first use in
this function)
fs/ntfs/aops.c:108: error: (Each undeclared identifier is reported only
once
fs/ntfs/aops.c:108: error: for each function it appears in.)
make[2]: *** [fs/ntfs/aops.o] Error 1

and (probably unrelated to rt):

drivers/isdn/hisax/config.c: In function 'HiSax_readstatus':
drivers/isdn/hisax/config.c:636: warning: ignoring return value of
'copy_to_user', declared with attribute warn_unused_result
drivers/isdn/hisax/config.c:647: warning: ignoring return value of
'copy_to_user', declared with attribute warn_unused_result
drivers/isdn/hisax/callc.c: In function 'HiSax_writebuf_skb':
drivers/isdn/hisax/callc.c:1781: warning: large integer implicitly
truncated to unsigned type
drivers/isdn/hisax/st5481_usb.c: In function 'st5481_in_mode':
drivers/isdn/hisax/st5481_usb.c:648: error: 'URB_ASYNC_UNLINK'
undeclared (first use in this function)
drivers/isdn/hisax/st5481_usb.c:648: error: (Each undeclared identifier
is reported only once
drivers/isdn/hisax/st5481_usb.c:648: error: for each function it appears
in.)
make[3]: *** [drivers/isdn/hisax/st5481_usb.o] Error 1

-- Fernando


