Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968517AbWLERoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968517AbWLERoc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 12:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968520AbWLERoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 12:44:32 -0500
Received: from smtp.osdl.org ([65.172.181.25]:56262 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968517AbWLERob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 12:44:31 -0500
Date: Tue, 5 Dec 2006 09:44:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Zach Brown'" <zach.brown@oracle.com>,
       Chris Mason <chris.mason@oracle.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] optimize o_direct on block device - v2
Message-Id: <20061205094410.cfca53fe.akpm@osdl.org>
In-Reply-To: <20061205110230.GA13490@infradead.org>
References: <000001c71829$a3378900$ba88030a@amr.corp.intel.com>
	<20061205110230.GA13490@infradead.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2006 11:02:30 +0000
Christoph Hellwig <hch@infradead.org> wrote:

> > +	long res;
> > +
> > +	if ((bio->bi_rw & 1) == READ)
> 
> I just wanted to complain about not using a proper helper for this,
> but apparently we don't have one yet..

There's bio_data_dir().
