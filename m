Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269658AbUHZW27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269658AbUHZW27 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 18:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269743AbUHZWZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 18:25:49 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:61195 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S269765AbUHZWWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 18:22:13 -0400
Date: Fri, 27 Aug 2004 00:18:56 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "O.Sezer" <sezeroz@ttnet.net.tr>
Cc: bunk@fs.tum.de, marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [2.4 patch][5/6] asm-i386/smpboot.h: fix gcc 3.4 compilation
Message-ID: <20040826221856.GC564@alpha.home.local>
References: <412E4A4F.2040706@ttnet.net.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412E4A4F.2040706@ttnet.net.tr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 11:38:39PM +0300, O.Sezer wrote:
> Didn't look at the code much but how about removing the
> label as the -ac tree does?
> 

I remember I once had to add an empty default case in a switch/case in one of
my programs to stop gcc from complaining. I think it is the same here and the
'default' does not harm anyway.

And please remember, as a rule of thumb, if it does not change semantics nor
the code produced, please try to avoid moving parts of the stable kernel.
There are many people who have to apply other patches on top of a vanilla
kernel and who don't like it very much when they get rejects just because
of a recent code "beautification".

Regards,
Willy

> diff -urN 28pre2/include/asm-i386/smpboot.h 28pre2_acx/include/asm-i386/smpboot.h
> --- 28pre2/include/asm-i386/smpboot.h	2004-08-08 02:26:06.000000000 +0300
> +++ 28pre2_acx/include/asm-i386/smpboot.h	2004-08-26 12:09:44.000000000 +0300
> @@ -129,7 +129,6 @@
>  			/*round robin the interrupts*/
>  			cpu = (cpu+1)%smp_num_cpus;
>  			return cpu_to_physical_apicid(cpu);
> -		default:
>  	}
>  	return cpu_online_map;
>  }

