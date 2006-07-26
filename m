Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030367AbWGZMFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbWGZMFg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 08:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbWGZMFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 08:05:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:56474 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030291AbWGZMFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 08:05:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=kAOebkEmsCcKfcm0dlJt7NF4fv6st3tXZRDKaLOPfDsXQM5RReE1i9qMej+7cVV9oALWoYucaApHjoTYtxTytpf4VBLqoDsLj8ekxtAr3gByqcWekqVEeJGxICHV2kIwJK3N5rMl59sXJO2Bb2QSz30T/qqeNQX16Tx3/bT/IKY=
Message-ID: <84144f020607260505s17daa5c8j6e5095eb956828ee@mail.gmail.com>
Date: Wed, 26 Jul 2006 15:05:33 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Christoph Lameter" <clameter@sgi.com>
Subject: Re: [patch] slab: always follow arch requested alignments
Cc: "Heiko Carstens" <heiko.carstens@de.ibm.com>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0607260451250.4021@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060722110601.GA9572@osiris.boeblingen.de.ibm.com>
	 <Pine.LNX.4.64.0607220748160.13737@schroedinger.engr.sgi.com>
	 <20060722162607.GA10550@osiris.ibm.com>
	 <84144f020607260422t668c4d8dldfcdedfe3713b73e@mail.gmail.com>
	 <Pine.LNX.4.64.0607260426450.3744@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.58.0607261430520.17986@sbz-30.cs.Helsinki.FI>
	 <Pine.LNX.4.64.0607260433410.3855@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.58.0607261443150.17986@sbz-30.cs.Helsinki.FI>
	 <Pine.LNX.4.58.0607261448520.17986@sbz-30.cs.Helsinki.FI>
	 <Pine.LNX.4.64.0607260451250.4021@schroedinger.engr.sgi.com>
X-Google-Sender-Auth: b7663cc17db1a584
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/06, Christoph Lameter <clameter@sgi.com> wrote:
> Your patch only deals with ARCH_SLAB_MINALIGN. kmem_cache_create() never
> uses ARCH_KMALLOC_MINALIGN only kmem_cache_init() does by passing it to
> kmem_cache_create.  ARCH_KMALLOC_MINALIGN will still be ignored.

Yes, in which case the caller mandated align will be, well,
ARCH_KMALLOC_MINALIGN. The patch changes kmem_cache_create to respect
caller mandated alignment too.

                                        Pekka
