Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280958AbRKKFxp>; Sun, 11 Nov 2001 00:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280969AbRKKFx0>; Sun, 11 Nov 2001 00:53:26 -0500
Received: from w140.z064220150.sjc-ca.dsl.cnc.net ([64.220.150.140]:2820 "EHLO
	trinity3.trinnet.net") by vger.kernel.org with ESMTP
	id <S280958AbRKKFxV>; Sun, 11 Nov 2001 00:53:21 -0500
Message-Id: <4.3.2.7.0.20011110194536.02cc6600@trinity3.trinnet.net>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sat, 10 Nov 2001 20:38:58 -0800
To: Keith Owens <kaos@ocs.com.au>, David Ranch <dranch@juniper.net>
From: David Ranch <dranch@trinnet.net>
Subject: Re: 2.2.20 - Possible module symbol bug 
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <14358.1005373725@ocs3.intra.ocs.com.au>
In-Reply-To: <Your message of "Fri, 09 Nov 2001 12:48:34 -0800." <3BEC4122.4C4DFB32@juniper.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Keith,

It's been a LONG time since I've heard from you.  I hope
all is well.

--
mv .config ..
make mrproper
mv ../.config .
make oldconfig
make dep clean bzImage modules
install, boot
--

I did start off with a clean config though I didn't do
a "mrproper".  I re-tested on the MD7.0 box and
"mrproper" solved my issue.  I haven't had to do this
step since the old 2.0.2x days and I feel somewhat
embarrassed by this.

Thanks again for setting me strait though. I am
curious for an explanation from the powers at be to
why this hit me now though I've been compiling kernels
without "mrproper" for years.  Am I just lucky?  ;-)

--David



At 05:28 PM 11/10/01 +1100, Keith Owens wrote:
 >On Fri, 09 Nov 2001 12:48:34 -0800,
 >David Ranch <dranch@juniper.net> wrote:
 >>I think I've found a bug in 2.2.20.  Specifically,
 >>if I compile up a 2.2.20 kernel on a Mandrake 7.0 box
 >>(glibc 2.1.3 - modutil 2.1.121) and run "depmod -a", all
 >>IPMASQ modules, loop, and ide-scsi modules fail dependencies.
 >
 >Broken kernel Makefiles, http://www.tux.org/lkml/#s8-8
.----------------------------------------------------------------------------.
|  David A. Ranch - Linux/Networking/PC hardware         dranch@trinnet.net  |
!----                                                                    ----!
`----- For more detailed info, see http://www.ecst.csuchico.edu/~dranch -----'

