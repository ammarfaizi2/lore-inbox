Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbVLVP7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbVLVP7W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 10:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbVLVP7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 10:59:21 -0500
Received: from uproxy.gmail.com ([66.249.92.193]:37185 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932351AbVLVP7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 10:59:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=CG8w27UEzAd/C/1zUbWPOMScwFkLUzQtfPhAmzKkgQBj6FTD5MmoWngXGsu2iNv7B2uvDq2ia0NMybcn47jTehmy0JJEmyoPbgDWTm7TCtUMOLUYDatyFbSnTUyN5PQhA/GRws7X7/FsHojvjcvRwelXzMnOKTmcQiQUxwoBxyY=
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
Reply-To: pantelis.antoniou@gmail.com
To: linuxppc-embedded@ozlabs.org
Subject: Re: [RFC] genalloc != generic DEVICE memory allocator
Date: Thu, 22 Dec 2005 18:09:52 +0200
User-Agent: KMail/1.8
Cc: Andrey Volkov <avolkov@varma-el.com>,
       Pantelis Antoniou <panto@intracom.gr>, Andrew Morton <akpm@osdl.org>,
       jes@trained-monkey.org, linux-kernel@vger.kernel.org
References: <43A98F90.9010001@varma-el.com> <43AAB508.7000007@intracom.gr> <43AAC9E8.2060105@varma-el.com>
In-Reply-To: <43AAC9E8.2060105@varma-el.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512221809.53360.pantelis.antoniou@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>

[snip]

> I'm sure lib/ will be appropriate place. and something like
> "DON'T TRY REINVENT WHEEL, TRY FIX EXISTS" in documentation/ :).
> 
> Now couple word about rheap: I understand why you are use static
> alignment in allocator, but its very specialized for CPM. IMO, align
> must be a param of xx_alloc. For ex: device may demand alignment by
> 8 bytes, which ok until... you are try map this memory to the user
> space (don't shoot at me, remember about framebuffer & co).
>

It is trivial to align to a given alignment in a call. Please search
the archives since this was needed for CPM2 and I've committed a patch.

As for mapping user space, since rheap only deals with addresses and never
touches the memory it's supposed to control, you can do pretty much everything.

I still don't understand what are you trying to do however.

Mind explaining?
 
> -- 
> Regards
> Andrey Volkov
>

Regards

Pantelis
