Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262733AbVGMTWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262733AbVGMTWY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 15:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbVGMTWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 15:22:21 -0400
Received: from port49.ds1-van.adsl.cybercity.dk ([212.242.141.114]:60777 "EHLO
	trider-g7.fabbione.net") by vger.kernel.org with ESMTP
	id S262703AbVGMTVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 15:21:08 -0400
Message-ID: <42D56993.2040102@fabbione.net>
Date: Wed, 13 Jul 2005 21:20:51 +0200
From: Fabio Massimo Di Nitto <fabbione@fabbione.net>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: davem@davemloft.net, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org
Subject: Re: [PATCH] modpost needs to cope with new glibc elf header on sparc
 (resend - my MTA did eat the previous one apparently)
References: <20050713062549.1ED325032@trider-g7.fabbione.net> <20050713170655.GA8197@mars.ravnborg.org>
In-Reply-To: <20050713170655.GA8197@mars.ravnborg.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
>>Hi everybody,
>>  recently a change in the glibc elf.h header has been introduced causing
>>modpost to spawn tons of warnings (like the one below) building the kernel on sparc:
>>
> 
> Applied.
> 

Thanks

> You need to reread SubmittingPatches:

I will..

> 
>>diff -urNad --exclude=CVS --exclude=.svn ./scripts/mod/modpost.c /usr/src/dpatchtemp/dpep-work.EcxGXN/linux-source-2.6.12-2.6.12/scripts/mod/modpost.c
>>--- ./scripts/mod/modpost.c	2005-06-17 21:48:29.000000000 +0200
>>+++ /usr/src/dpatchtemp/dpep-work.EcxGXN/linux-source-2.6.12-2.6.12/scripts/mod/modpost.c	2005-06-30 09:29:54.000000000 +0200
> 
> 
> This does not apply with patch -p1. I fixed it manually.

.. but it does here...

fabbione@gordian:/usr/src/wartydevel/kernel/breezy/linux-source-2.6.12-2.6.12$ patch -p1 <
debian/patches/scripts-mod-modpost_deal-with-new-glibc.dpatch
patching file scripts/mod/modpost.c
fabbione@gordian:/usr/src/wartydevel/kernel/breezy/linux-source-2.6.12-2.6.12$ patch -Rp1 <
debian/patches/scripts-mod-modpost_deal-with-new-glibc.dpatch
patching file scripts/mod/modpost.c
fabbione@gordian:/usr/src/wartydevel/kernel/breezy/linux-source-2.6.12-2.6.12$

Thanks a lot.
Fabio

-- 
no signature file found.
