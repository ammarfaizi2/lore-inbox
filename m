Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293326AbSCJV7H>; Sun, 10 Mar 2002 16:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293327AbSCJV66>; Sun, 10 Mar 2002 16:58:58 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:40347 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S293326AbSCJV6q>; Sun, 10 Mar 2002 16:58:46 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Mikael Pettersson <mikpe@csd.uu.se>
Date: Mon, 11 Mar 2002 08:58:21 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15499.55037.853665.616275@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.6 missing EXPORT_SYMBOL for NFSD module
In-Reply-To: message from Mikael Pettersson on Sunday March 10
In-Reply-To: <200203101644.RAA02312@harpo.it.uu.se>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday March 10, mikpe@csd.uu.se wrote:
> NFSD doesn't work as a module in recent 2.5 kernels since
> svc_reserve() isn't exported. The trivial patch below fixes this.
> 
> /Mikael
> 
> --- linux-2.5.6/net/sunrpc/sunrpc_syms.c.~1~	Wed Feb 20 03:11:04 2002
> +++ linux-2.5.6/net/sunrpc/sunrpc_syms.c	Sun Mar 10 14:32:04 2002
> @@ -77,6 +77,7 @@
>  EXPORT_SYMBOL(svc_recv);
>  EXPORT_SYMBOL(svc_wake_up);
>  EXPORT_SYMBOL(svc_makesock);
> +EXPORT_SYMBOL(svc_reserve);
>  
>  /* RPC statistics */
>  #ifdef CONFIG_PROC_FS

Gosh, is 2.5.6 out already!  I thought I'd have a bit more time to
unbreak things....

Thanks,
NeilBrown
