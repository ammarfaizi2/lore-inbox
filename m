Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422721AbWAMRan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422721AbWAMRan (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 12:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161567AbWAMRam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 12:30:42 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:18578 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161546AbWAMRam convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 12:30:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nVoFNUwMy7Tp0/81uJ+Btto2H0+msz0Erb0Jly94z8l9bTIhdMWjy90QgiBGqdau2u/0NlZ/qD4v7dS+dFjpmBUR3SOT7maRu1SBRjPPxpSjNial2i+bZ8NbmUDvMiBNWGqsA17FeNsguOShTvYrc1kf5+1F1DfCVXpS41ZSsbg=
Message-ID: <86802c440601130930k5abfda2m91294c43641283@mail.gmail.com>
Date: Fri, 13 Jan 2006 09:30:41 -0800
From: yhlu <yhlu.kernel@gmail.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: can not compile in the latest git
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0601121958570.2740@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <86802c440601111021m7cb40881m7206d9342534f844@mail.gmail.com>
	 <Pine.LNX.4.62.0601111213270.24355@schroedinger.engr.sgi.com>
	 <86802c440601121236s47d5737fo45105ce3ebc746a6@mail.gmail.com>
	 <Pine.LNX.4.62.0601121958570.2740@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It works but there are some typo

+static inline int isolate_lru_pages(struct page *p) { return -ENOSYS; }
+static inline int putback_lru_pages(struct list_head *) { return 0; }
+static inline int migrate_pages(struct list_head *l, struct list_head *t,
+       struct list_head *moved, struct list_head *failed) { return -ENOSYS; }
===>
+static inline int isolate_lru_page(struct page *p) { return -ENOSYS; }
+static inline int putback_lru_pages(struct list_head *l) { return 0; }
+static inline int migrate_pages(struct list_head *l, struct list_head *t,
+       struct list_head *moved, struct list_head *failed) { return -ENOSYS; }

So the CONFIG_MIGRATION depends on CONFIG_NUMA and CONFIG_SWAP?

YH
