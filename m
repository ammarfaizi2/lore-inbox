Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317544AbSHKSVV>; Sun, 11 Aug 2002 14:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317638AbSHKSVV>; Sun, 11 Aug 2002 14:21:21 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:10484 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317544AbSHKSVV>; Sun, 11 Aug 2002 14:21:21 -0400
Subject: Re: Linux 2.4.20-pre1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: andersen@codepoet.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020811085717.GA17738@codepoet.org>
References: <Pine.LNX.4.44.0208051938380.6811-100000@freak.distro.conectiva> 
	<20020811085717.GA17738@codepoet.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 11 Aug 2002 20:46:19 +0100
Message-Id: <1029095179.16236.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-11 at 09:57, Erik Andersen wrote:
> On Mon Aug 05, 2002 at 07:40:56PM -0300, Marcelo Tosatti wrote:
> > 
> > So here goes -pre1, with a big -ac and x86-64 merges, plus other smaller
> > stuff.
> [------------snip------------]
> > <alan@irongate.swansea.linux.org.uk> (02/08/05 1.629)
> > 	[PATCH] PATCH: Add EFI partition support
> 
> Needs this to compile....
> 
> --- linux/include/asm-ia64/efi.h.orig	Sun Aug 11 01:41:10 2002
> +++ linux/include/asm-ia64/efi.h	Sun Aug 11 01:43:38 2002
> @@ -166,6 +166,9 @@
>   *  EFI Configuration Table and GUID definitions
>   */
>  
> +#define NULL_GUID    \
> +    ((efi_guid_t) { 0x00000000, 0x0000, 0x0000, { 0x00, 0x00, 0x0, 0x00, 0x00, 0x00, 0x00, 0x00 }})
> +

Not a good plan. EFI can be used on non ia64 so NULL_GUID belongs
somewhere else

