Return-Path: <linux-kernel-owner+w=401wt.eu-S1754426AbWLRTLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426AbWLRTLT (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 14:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754338AbWLRTLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 14:11:19 -0500
Received: from amsfep20-int.chello.nl ([62.179.120.15]:36353 "EHLO
	amsfep20-int.chello.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753768AbWLRTLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 14:11:18 -0500
Subject: Re: 2.6.19 file content corruption on ext3
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: andrei.popa@i-neo.ro
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
In-Reply-To: <1166468651.6983.6.camel@localhost>
References: <1166314399.7018.6.camel@localhost>
	 <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost>
	 <20061217154026.219b294f.akpm@osdl.org> <1166460945.10372.84.camel@twins>
	 <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
	 <1166466272.10372.96.camel@twins>
	 <Pine.LNX.4.64.0612181030330.3479@woody.osdl.org>
	 <1166468651.6983.6.camel@localhost>
Content-Type: text/plain
Date: Mon, 18 Dec 2006 20:10:19 +0100
Message-Id: <1166469019.10372.99.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-18 at 21:04 +0200, Andrei Popa wrote:

> diff --git a/mm/rmap.c b/mm/rmap.c
> index d8a842a..3f9061e 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -448,7 +448,7 @@ static int page_mkclean_one(struct page 
>  		goto unlock;
>  
>  	entry = ptep_get_and_clear(mm, address, pte);
> -	entry = pte_mkclean(entry);
> +	/*entry = pte_mkclean(entry);*/
>  	entry = pte_wrprotect(entry);
>  	ptep_establish(vma, address, pte, entry);
>  	lazy_mmu_prot_update(entry);

please drop this chunk, this will always make the problem go away.


