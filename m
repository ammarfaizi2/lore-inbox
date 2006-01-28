Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965032AbWA1SwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbWA1SwQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 13:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbWA1SwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 13:52:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41949 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964824AbWA1SwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 13:52:15 -0500
Date: Sat, 28 Jan 2006 10:51:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: dipankar@in.ibm.com
Cc: paulmck@us.ibm.com, dada1@cosmosbay.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       nickpiggin@yahoo.com.au, hch@infradead.org
Subject: Re: [patch 2/2] fix file counting
Message-Id: <20060128105108.1724e1cc.akpm@osdl.org>
In-Reply-To: <20060128184245.GE5633@in.ibm.com>
References: <20060126184010.GD4166@in.ibm.com>
	<20060126184127.GE4166@in.ibm.com>
	<20060126184233.GF4166@in.ibm.com>
	<43D92DD6.6090607@cosmosbay.com>
	<20060127145412.7d23e004.akpm@osdl.org>
	<20060127231420.GA10075@us.ibm.com>
	<20060127152857.32066a69.akpm@osdl.org>
	<20060128184245.GE5633@in.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma <dipankar@in.ibm.com> wrote:
>
>  > (And it forgot to initialise the atomic_t)
> 
>  I declared it static. Isn't that sufficient ?

ATOMIC_INIT(0);

>  > (And has a couple of suspicious-looking module exports.  We don't support
>  > CONFIG_PROC_FS=m).
> 
>  Where ?

+EXPORT_SYMBOL(get_nr_files);
+EXPORT_SYMBOL(get_max_files);

Why are these needed?
