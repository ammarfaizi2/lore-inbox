Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285668AbRLTASI>; Wed, 19 Dec 2001 19:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285669AbRLTAR6>; Wed, 19 Dec 2001 19:17:58 -0500
Received: from rcpt-expgw.biglobe.ne.jp ([210.147.6.216]:20369 "EHLO
	rcpt-expgw.biglobe.ne.jp") by vger.kernel.org with ESMTP
	id <S285668AbRLTARm>; Wed, 19 Dec 2001 19:17:42 -0500
X-Biglobe-Sender: <k-suganuma@mvj.biglobe.ne.jp>
Date: Wed, 19 Dec 2001 16:17:00 -0800
From: Kimio Suganuma <k-suganuma@mvj.biglobe.ne.jp>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [ANNOUNCE] HotPlug CPU patch against 2.5.0
Cc: <linux-kernel@vger.kernel.org>, <large-discuss@lists.sourceforge.net>,
        Heiko Carstens <Heiko.Carstens@de.ibm.com>,
        Jason McMullan <jmcmullan@linuxcare.com>,
        Anton Blanchard <antonb@au1.ibm.com>,
        Greg Kroah-Hartman <ghartman@us.ibm.com>, <rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.33L2.0112181748040.20824-100000@dragon.pdx.osdl.net>
In-Reply-To: <20011213132557.5B3E.K-SUGANUMA@mvj.biglobe.ne.jp> <Pine.LNX.4.33L2.0112181748040.20824-100000@dragon.pdx.osdl.net>
Message-Id: <20011219160402.3D14.K-SUGANUMA@mvj.biglobe.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.00.05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As you mentioned, CPU online caused panic when MTRR was on
on my system. I've only tested with no MTRR configuration. :-(
I'll investigate the problem but I'm not sure I can find
a resolution. (I know nothing about MTRR... )
Does anybody have an idea for the problem?

Thanks,
Kimi

On Tue, 18 Dec 2001 18:29:30 -0800 (PST)
"Randy.Dunlap" <rddunlap@osdl.org> wrote:

> Hi,
> 
> I applied this patch to Linux 2.5.0 and tried to use it on
> a 2-way x86 system with dual Intel Pentium III's (1 GHz).
> Results:
>   echo 0 > /proc/sys/kernel/cpu/1/online
> seems to work: "top" stops reporting about the second CPU.
> 
> However,
>   echo 1 > /proc/sys/kernel/cpu/1/online
> results in an Oops in set_mtrr_var_range_testing().
> 
> (same oops that I had encountered when I ported the 2.4.5
> patch to 2.4.13)
> 
> Does this work for you?  I can connect a serial console to
> it and provide you with a complete oops report if you want
> that, and I'm available to help work on it.
> 
> In linux/arch/i386/kernel/mtrr.c, the functions
>   set_mtrr_var_range_testing() and
>   set_mtrr_fixed_testing()
> need to have the "__init" removed from them, but this
> doesn't fix the oops problem.
> 
> Thanks,
> -- 
> ~Randy

-- 
Kimio Suganuma <k-suganuma@mvj.biglobe.ne.jp>

