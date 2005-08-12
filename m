Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbVHLKnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbVHLKnw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 06:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbVHLKnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 06:43:52 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:21898 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1750957AbVHLKnv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 06:43:51 -0400
Message-ID: <42FC7D5E.8020604@namesys.com>
Date: Fri, 12 Aug 2005 14:43:42 +0400
From: "Vladimir V. Saveliev" <vs@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040804
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grant Coady <Grant.Coady@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Via-Rhine NIC, Via SATA or reiserfs broken, how to tell??
References: <54nnf1tv8722aq6med3mlr4mvg7nli0r09@4ax.com>
In-Reply-To: <54nnf1tv8722aq6med3mlr4mvg7nli0r09@4ax.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Grant Coady wrote:
> Greetings,
> 
> Situation is dataloss with no errors logged.
> 
> Test: unpack 2.6.12 tarball from NFS mount source, diff against 
> previous attempt:
> 
> $ diff -Nrup linux-2.6.12.old linux-2.6.12
> Binary files linux-2.6.12.old/include/asm-sparc/a.out.h and linux-2.6.12/include/asm-sparc/a.out.h differ
> diff -Nrup linux-2.6.12.old/include/asm-sparc/apc.h linux-2.6.12/include/asm-sparc/apc.h
> --- linux-2.6.12.old/include/asm-sparc/apc.h    2005-06-18 05:48:29.000000000 +1000
> +++ linux-2.6.12/include/asm-sparc/apc.h        2005-06-18 05:48:29.000000000 +1000
> @@ -31,7 +31,7 @@
>  #define APC_BPORT_REG  0x30
> 
>  #define APC_REGMASK            0x01
> -define APC_BPMASK              0x03
> +#define APC_BPMASK             0x03
> 
>  /*
>   * IDLE - CPU standby values (set to initiate standby)
> diff -Nrup linux-2.6.12.old/include/asm-sparc/svr4.h linux-2.6.12/include/asm-sparc/svr4.h
> --- linux-2.6.12.old/include/asm-sparc/svr4.h   2005-06-18 05:48:29.000000000 +1000
> +++ linux-2.6.12/include/asm-sparc/svr4.h       2005-06-18 05:48:29.000000000 +1000
> @@ -15,7 +15,7 @@ typedef struct {                /* signa
> 
>  /* Values for siginfo.code */
>  #define SVR4_SINOINFO 32767
> -/* Siginfo, sucker expects bunch of information on those paramEters */
> +/* Siginfo, sucker expects bunch of information on those parameters */
>  typedef union {
>         char total_size [128];
>         struct {
> 
> 
> Seems like three bit errors for source tree.  Other times I've noted 
> compile failures where unpacking source tree fresh would 'fix' error.
> I'd previously assumed that I accidentally killed source tree with 
> 'cp -al ...' copies but I've had a segfault on that operation, hence 
> I do not know if this be NIC or filesystem (reiserfs on via SATA).
> 
> 
> Today disabled onboard via-rhine and used Intel pro/100 + e100 driver, 
> several source trees unpacked identically, running 2.6.12.4 or 2.4.31-hf3
> 
> The fault occurs on 2.4 latest or 2.6 latest only on particular target 
> box, so problem is not the NFS server.
> 
> How to test and isolate this error is in NIC driver, SATA driver or 
> filesystem?  
> 

Could it be that tarbal on NFS server changed?
It is not very likely that error in kernel drivers fixed typos in source code.

> Thanks,
> Grant.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

