Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTJIOGU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 10:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbTJIOGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 10:06:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:45473 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262196AbTJIOGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 10:06:16 -0400
Date: Thu, 9 Oct 2003 07:05:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, arun.sharma@intel.com, torvalds@osdl.org
Subject: Re: 2.6.0-test7 BLK_DEV_FD dependence on ISA breakage
Message-Id: <20031009070505.00470202.akpm@osdl.org>
In-Reply-To: <16261.25288.125075.508225@gargle.gargle.HOWL>
References: <Pine.LNX.4.44.0310081235280.4017-100000@home.osdl.org>
	<16261.25288.125075.508225@gargle.gargle.HOWL>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> wrote:
>
> This patch
> 
> --- a/drivers/block/Kconfig	Wed Oct  8 12:24:56 2003
> +++ b/drivers/block/Kconfig	Wed Oct  8 12:24:56 2003
> @@ -6,7 +6,7 @@
>  
>  config BLK_DEV_FD
>  	tristate "Normal floppy disk support"
> -	depends on !X86_PC9800 && !ARCH_S390
> +	depends on ISA || M68 || SPARC64
>  	---help---
>  	  If you want to use the floppy disk drive(s) of your PC under Linux,
>  	  say Y. Information about this driver, especially important for IBM
> 
> is broken. 

Yeah, and there's been a metric mile of blab about it but I don't think
we've actually settled on a correct+complete solution.

Perhaps we should just back it out and watch more closely next time someone
tries to fix it?


