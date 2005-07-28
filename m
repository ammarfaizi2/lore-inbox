Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVG1RMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVG1RMz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 13:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbVG1RMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 13:12:36 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:27822 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261726AbVG1RMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 13:12:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=muOgW4khrWyoSUjpI2c8NNMNZc+xV9SDsYeG+sviRaKVbibEGJAgEKOEdmYrP8nBgc+WIIjsh5x+5qTefI+O6D72ulPGqKlAcLnjisrpzH+wKPa+6ofMo3KfJoiJYqH+5X7eRbMSlT94KbwbmNOni0yeSkSQNxIu2LfQoWfPRJA=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: akpm@osdl.org
Subject: Re: [uml-devel] [PATCH 1/7] UML - -mm3 compile fix
Date: Thu, 28 Jul 2005 19:29:25 +0200
User-Agent: KMail/1.7.2
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <200507281626.j6SGQgsI009471@ccure.user-mode-linux.org>
In-Reply-To: <200507281626.j6SGQgsI009471@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507281929.26273.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 July 2005 18:26, Jeff Dike wrote:
> -mm3 adds an include of asm/vm86.h in include/asm-i386/ptrace.h.  Since UML
> includes the underlying arch's ptrace.h, it needs an asm/vm86.h in order
> to build.
Note for both Jeff and Akpm: this is also for the current Linus' git 
repository (just since today).

> Signed-off-by: Jeff Dike <jdike@addtoit.com>

> Index: linux-2.6.12-rc3-mm2/include/asm-um/vm86.h
> ===================================================================
> --- linux-2.6.12-rc3-mm2.orig/include/asm-um/vm86.h	2005-07-28
> 05:04:34.593890552 -0400 +++
> linux-2.6.12-rc3-mm2/include/asm-um/vm86.h	2005-07-28 11:13:32.000000000
> -0400 @@ -0,0 +1,6 @@
> +#ifndef __UM_VM86_H
> +#define __UM_VM86_H
> +
> +#include "asm/arch/vm86.h"
> +
> +#endif

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
