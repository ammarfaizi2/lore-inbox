Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbUDHB4o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 21:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUDHB4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 21:56:44 -0400
Received: from ozlabs.org ([203.10.76.45]:230 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261419AbUDHB4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 21:56:40 -0400
Date: Thu, 8 Apr 2004 11:53:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Zoltan.Menyhart@bull.net
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev@lists.linuxppc.org
Subject: Re: RFC: COW for hugepages
Message-ID: <20040408015327.GB20320@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Zoltan.Menyhart@bull.net, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
	linuxppc64-dev@lists.linuxppc.org
References: <20040407074239.GG18264@zax> <4073C33B.7B7808E7@nospam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4073C33B.7B7808E7@nospam.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 11:00:43AM +0200, Zoltan Menyhart wrote:
> David,
> 
> Why not just add a flag for a VMA telling if you want / do not want to
> copy it on "fork()" ? E.g.:
> 
> dup_mmap():
> 
> 	for (= current->mm->mmap ; mpnt ; mpnt = mpnt->vm_next) {
> 
> 		if (mpnt->vm_flags & VM_HUGETLB_DONT_COPY)
> 			<do nothing>
> 	}
> 

Um.. why would that be useful?

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
