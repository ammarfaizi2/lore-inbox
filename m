Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVFLN3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVFLN3z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 09:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbVFLN3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 09:29:55 -0400
Received: from ns.suse.de ([195.135.220.2]:11726 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261190AbVFLN3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 09:29:50 -0400
Date: Sun, 12 Jun 2005 15:29:43 +0200
From: Andi Kleen <ak@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: marcelo.tosatti@cyclades.com, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.31 6/9] gcc4: fix x86_64 sys_iopl() bug
Message-ID: <20050612132943.GS23831@wotan.suse.de>
References: <200506121120.j5CBKZH1019741@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506121120.j5CBKZH1019741@harpo.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -113,9 +113,18 @@ quiet_ni_syscall:
>  	PTREGSCALL stub32_fork, sys32_fork
>  	PTREGSCALL stub32_clone, sys32_clone
>  	PTREGSCALL stub32_vfork, sys32_vfork
> -	PTREGSCALL stub32_iopl, sys_iopl
>  	PTREGSCALL stub32_rt_sigsuspend, sys_rt_sigsuspend
>  
> +	.macro PTREGSCALL3 label, func, arg

PTREGSCALL3? I'm sure that is not in 2.6. How about just changing
PTREGSCALL globally? 

iirc the other ptregs syscalls were safe, but I still changed them in 2.6
to use a pointer argument.


-Andi
