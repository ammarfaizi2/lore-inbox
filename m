Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132395AbRDFUbr>; Fri, 6 Apr 2001 16:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132399AbRDFUbh>; Fri, 6 Apr 2001 16:31:37 -0400
Received: from front2.grolier.fr ([194.158.96.52]:28402 "EHLO
	front2.grolier.fr") by vger.kernel.org with ESMTP
	id <S132395AbRDFUbb> convert rfc822-to-8bit; Fri, 6 Apr 2001 16:31:31 -0400
Date: Fri, 6 Apr 2001 19:20:09 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
To: Stefano Coluccini <s.coluccini@caen.it>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: RE: st corruption with 2.4.3-pre4
In-Reply-To: <Pine.LNX.4.10.10104061609330.996-100000@linux.local>
Message-ID: <Pine.LNX.4.10.10104061914210.8640-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Apr 2001, Gérard Roudier wrote:

> Here is a patch that removes the offending PPC PCI hacky area from the
> driver (sym53c8xx_defs.h):
> 
> --- sym53c8xx_defs.h	Fri Apr  6 16:23:48 2001
> +++ sym53c8xx_defs.h.orig	Sun Mar  4 13:54:11 2001
> @@ -175,6 +175,9 @@
>  #define	SCSI_NCR_IOMAPPED
>  #elif defined(__alpha__)
>  #define	SCSI_NCR_IOMAPPED
> +#elif defined(__powerpc__)
> +#define	SCSI_NCR_IOMAPPED
> +#define SCSI_NCR_PCI_MEM_NOT_SUPPORTED
>  #elif defined(__sparc__)
>  #undef SCSI_NCR_IOMAPPED
>  #endif
> -------------------- Cut Here ------------------

The patch is obviously reversed. You just have to remove the 3 lines that
apply to powerpc using you preferred editor.
Btw, using the one you dislike the most will also fit. :-)

  Gérard.

