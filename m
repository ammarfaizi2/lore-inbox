Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751707AbWHSK16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbWHSK16 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 06:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbWHSK16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 06:27:58 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:4892 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751707AbWHSK15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 06:27:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sP68dI06UqvdI+BkQ3xW9MquxmT+JFpJ7XUPfCcyI2X3l353zYEGkAluCoPQHuFhyXT3FU/hgjz1SZWTivijGST4IEgLbEDCtdGwOpM+7nKKDIRkV3PpjKVa1HE8Zk4xocxE4ZeoFht/lCso5vvgvI8B7cuMWcH5Hz57TUAxAV4=
Message-ID: <b0943d9e0608190327h6ec3bb17wf32517af1fbf6d12@mail.gmail.com>
Date: Sat, 19 Aug 2006 11:27:57 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH 2.6.18-rc4 00/10] Kernel memory leak detector 0.9
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0608181549o3034398fob3763d3ce0869cfe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060812215857.17709.79502.stgit@localhost.localdomain>
	 <b0943d9e0608180627g61007207read993387bf0c0b4@mail.gmail.com>
	 <6bffcb0e0608180655j50332247m8ed393c37d570ee4@mail.gmail.com>
	 <6bffcb0e0608180715v27015481vb7c603c4be356a21@mail.gmail.com>
	 <b0943d9e0608180846s4ed560b7ld4e3081bdc754454@mail.gmail.com>
	 <6bffcb0e0608180942l12e342epd60dffbb5c5d4b3e@mail.gmail.com>
	 <b0943d9e0608180957w60d22261k61b272c9b76505bd@mail.gmail.com>
	 <6bffcb0e0608181438m3406de08q9a168d486127aef@mail.gmail.com>
	 <b0943d9e0608181447t5503b24eyfea6f3903c2ba27d@mail.gmail.com>
	 <6bffcb0e0608181549o3034398fob3763d3ce0869cfe@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> This is interesting. Is it too large?
> orphan pointer 0xfe09f000 (size 4194304):
>   c016cb9c: <__vmalloc_node>
>   c016cbb2: <__vmalloc>
>   c016cbc7: <vmalloc>
>   fdd3bbe1: <txInit>
>   fdd23b73: <init_jfs_fs>
>   c0149fea: <sys_init_module>

Looking at the code, I don't think it is too large. Anyway, it is just
a temporary false positive as it seems to only be present in some of
the files in your tarball.

> A large collection of false positives :)
> http://www.stardust.webpages.pl/files/o_bugs/kmemleak-0.9/ml_collection/ml1.tar

Thanks, but some of them look like real leaks :-) - delayacct_tsk_init
- I'll post a separate e-mail for this.

Have you seen any crashes or lockdep reports with the latest kmemleak patches?

-- 
Catalin
