Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264562AbUGMEuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264562AbUGMEuZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 00:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264530AbUGMEuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 00:50:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:47585 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264562AbUGMEtx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 00:49:53 -0400
Date: Mon, 12 Jul 2004 21:48:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rmaplock 1/6 PageAnon in mapping
Message-Id: <20040712214842.5c200de0.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0407122248060.4005-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0407122248060.4005-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> Replace the PG_anon page->flags bit by setting the lower bit of the
>  pointer in page->mapping when it's anon_vma: PAGE_MAPPING_ANON bit.

This is likely to cause conniptions in various quarters.  Is there no
alternative?

It might make things more palatable to hide the setting, clearing testing
amd masking of this bit behind some set of wrapper functions.  Maybe.
