Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264034AbUFKPR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264034AbUFKPR6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 11:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264048AbUFKPR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 11:17:58 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:52608 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264034AbUFKPRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 11:17:50 -0400
Date: Fri, 11 Jun 2004 08:17:40 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Takao Indoh <indou.takao@soft.fujitsu.com>, arjanv@redhat.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4]Diskdump Update
Message-ID: <78040000.1086967058@[10.10.2.4]>
In-Reply-To: <ABC44FB9B74DDCindou.takao@soft.fujitsu.com>
References: <1086954645.2731.23.camel@laptop.fenrus.com> <ABC44FB9B74DDCindou.takao@soft.fujitsu.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, I fix it.
> 
> -		page = mem_map + nr;
> +		page = pfn_to_page(nr);

That's correct now ...

> I also need fix this.
> 
> -	for (nr = 0; nr < max_mapnr; nr++) {
> +	for (nr = 0; nr < max_pfn; nr++) {

... but that's not (at least AFAICS from this snippet). You need to iterate 
over pgdats, and then over the lmem_map inside each pgdat.

M.

