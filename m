Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266813AbTGGFhA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 01:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266818AbTGGFhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 01:37:00 -0400
Received: from AMarseille-201-1-2-189.w193-253.abo.wanadoo.fr ([193.253.217.189]:22312
	"EHLO gaston") by vger.kernel.org with ESMTP id S266813AbTGGFg6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 01:36:58 -0400
Subject: Re: [PATCH][2.4.22-pre3] fix PPC32 compile failure due to
	SPRN_HID2 being undefined
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@csd.uu.se>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200307062243.h66MheGM023893@harpo.it.uu.se>
References: <200307062243.h66MheGM023893@harpo.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1057557063.503.108.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 07 Jul 2003 07:51:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-07-07 at 00:43, Mikael Pettersson wrote:
> Compiling 2.4.22-pre3 for a 6xx-class PowerPC fails in cpu_setup_6xx.S:
> 
> ppc-unknown-linux-gcc -D__ASSEMBLY__ -D__KERNEL__ -I/tmp/linux-2.4.22-pre3/include -I/tmp/linux-2.4.22-pre3/arch/ppc   -c -o cpu_setup_6xx.o cpu_setup_6xx.S
> cpu_setup_6xx.S: Assembler messages:
> cpu_setup_6xx.S:325: Error: unsupported relocation against SPRN_HID2
> cpu_setup_6xx.S:416: Error: unsupported relocation against SPRN_HID2
> make[1]: *** [cpu_setup_6xx.o] Error 1
> make[1]: Leaving directory `/tmp/linux-2.4.22-pre3/arch/ppc/kernel'
> make: *** [_dir_arch/ppc/kernel] Error 2
> 
> SPRN_HID2 should be a #defined constant, but it isn't. The patch
> below from 2.4.21-ben2 (rediffed for 2.4.22-pre3) fixes the problem.

Yup, Marcelo, please apply.


