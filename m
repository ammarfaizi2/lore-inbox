Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269925AbRHEGSQ>; Sun, 5 Aug 2001 02:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269926AbRHEGSG>; Sun, 5 Aug 2001 02:18:06 -0400
Received: from [144.137.82.79] ([144.137.82.79]:9230 "EHLO localhost")
	by vger.kernel.org with ESMTP id <S269925AbRHEGSA>;
	Sun, 5 Aug 2001 02:18:00 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] /proc/ksyms change for IA64 
In-Reply-To: Your message of "Thu, 02 Aug 2001 13:22:40 +1000."
             <22165.996722560@kao2.melbourne.sgi.com> 
Date: Sun, 05 Aug 2001 15:44:45 +1000
Message-Id: <E15TGiV-0008WI-00@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <22165.996722560@kao2.melbourne.sgi.com> you write:
> The IA64 use of descriptors for function pointers has bitten ksymoops.
> For those not familiar with IA64, &func points to a descriptor
> containing { &code, &data_context }.  System.map contains the address
> of the code, /proc/ksyms contains the address of the descriptor.
> insmod needs the descriptor address, ksymoops and debuggers need the
> code address, /proc/ksyms needs to contain both addresses, with one of
> them prefixed by a special character.

Eewwww....

	How about just adding /proc/ksyms-ia64 with the code pointers
which contains the ia64 code addresses required by ksymoops and
debuggers.  These are, after all, less vital than insmod.

Cheers,
Rusty.
--
Premature optmztion is rt of all evl. --DK
