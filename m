Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937019AbWLDP3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937019AbWLDP3W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 10:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937018AbWLDP3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 10:29:21 -0500
Received: from il.qumranet.com ([62.219.232.206]:44566 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937020AbWLDP3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 10:29:20 -0500
Message-ID: <45743ECD.9050105@qumranet.com>
Date: Mon, 04 Dec 2006 17:29:17 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: "Renato S. Yamane" <renatoyamane@mandic.com.br>
CC: kvm-devel@lists.sourceforge.net, akpm@osdl.org, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: mmu: honor global bit on huge pages
References: <20061204145735.89391A0016@il.qumranet.com> <45743E0C.6090705@mandic.com.br>
In-Reply-To: <45743E0C.6090705@mandic.com.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Renato S. Yamane wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Em 04-12-2006 12:57, Avi Kivity escreveu:
>   
>> The kvm mmu attempts to cache global translations, however it misses on
>> global huge page translation (which is what most global pages are).
>>
>> By caching global huge page translations, boot time of fc5 i386 on i386
>> is reduced from ~35 seconds to ~24 seconds.
>>     
>
> I try use this patch in Kernel 2.6.19-git5, but I receive an error message:
>
> /linux-2.6.19# patch -p1 < /home/yamane/Desktop/kernel/kvm.patch
> can't find file to patch at input line 3
> Perhaps you used the wrong -p or --strip option?
> The text leading up to this was:
> - --------------------------
> |--- linux-2.6.orig/drivers/kvm/paging_tmpl.h
> |+++ linux-2.6/drivers/kvm/paging_tmpl.h
> - --------------------------
> File to patch:
>
> Whats wrong? :-(
>   

This patch is for kvm, which lives in the -mm kernel.  Apply the latest 
-mm patch first.


-- 
error compiling committee.c: too many arguments to function

