Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWGVMG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWGVMG3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 08:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWGVMG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 08:06:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:49718 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751223AbWGVMG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 08:06:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=QoUXNu5Q5ub7tOXA5OswLG2nuQ7B4iTOgszLt55odhUhCyXPM9j+y4NpEd7qDftjXRLwaArtUBm6hT+CkbG0ayGoiD0+qYFrXdWkMmZgKYebQL5xEfwLegBRGayf2Zhauz74xjLfsoYHP/msccXKaLrp6B6VhcRwTGJ5OxLqHHA=
Message-ID: <84144f020607220506l56e0cae6lfb3ec8e23694b966@mail.gmail.com>
Date: Sat, 22 Jul 2006 15:06:27 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Heiko Carstens" <heiko.carstens@de.ibm.com>
Subject: Re: [patch] slab: always follow arch requested alignments
Cc: "Andrew Morton" <akpm@osdl.org>, "Christoph Lameter" <clameter@sgi.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060722110601.GA9572@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060722110601.GA9572@osiris.boeblingen.de.ibm.com>
X-Google-Sender-Auth: 5ef54c7d36e74220
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/06, Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> In kmem_cache_create(): always check if BYTES_PER_WORD is less than
> ARCH_SLAB_MINALIGN and disable debug options that would set the
> alignment to BYTES_PER_WORD.
> This will make sure that all slab caches will have at least an
> ARCH_SLAB_MINALIGN alignment.
>
> In addition make sure that a caller mandated align which is greater
> than BYTES_PER_WORD also disables the same debug options.
> This makes sure that ARCH_KMALLOC_MINALIGN also has an effect if
> CONFIG_DEBUG_SLAB is set.

Ok, but why?

                                                          Pekka
