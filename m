Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130150AbQLUKjV>; Thu, 21 Dec 2000 05:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130315AbQLUKjL>; Thu, 21 Dec 2000 05:39:11 -0500
Received: from fe000.worldonline.dk ([212.54.64.194]:14354 "HELO
	fe000.worldonline.dk") by vger.kernel.org with SMTP
	id <S130150AbQLUKix>; Thu, 21 Dec 2000 05:38:53 -0500
Date: Thu, 21 Dec 2000 11:07:09 +0000 (/etc/localtime)
From: "Jesper Juhl <juhl@eisenstein.dk>" <jju@eisenstein.dk>
Reply-To: Jesper Juhl <juhl@eisenstein.dk>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Strange warnings about .modinfo when compiling 2.2.18 on Alpha
In-Reply-To: <5806.977381800@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.30.0012211104580.6659-100000@juhl.eisenstein.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Dec 2000, Keith Owens wrote:

> The way .modinfo is created is a kludge to prevent the .modinfo section
> being loaded as part of the module.  The initial reference to .modinfo
> creates it as non-allocated, later references try to allocate data in
> the section.  Older versions of gcc silently ignored the mismatch,
> newer ones warn about the mismatch.
>
> modutils >= 2.3.19 makes sure that .modinfo is not loaded so the kernel
> kludge is no longer required.  Alan Cox (quite rightly) will not force
> 2.2 users to upgrade modutils, but if you jump to modutils 2.3.23 and
> apply this patch against kernel 2.2.18 then the warnings will disappear.


Thank you very much for your reply. I'll try upgrading modutils and apply
the patch.


Best regards,
Jesper Juhl
juhl@eisenstein.dk

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
