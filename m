Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWGRO0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWGRO0Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 10:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWGRO0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 10:26:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24538 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932231AbWGRO0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 10:26:15 -0400
Date: Tue, 18 Jul 2006 07:25:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: mbligh@mbligh.org, a.p.zijlstra@chello.nl, linux-mm@kvack.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: inactive-clean list
Message-Id: <20060718072545.7cfed5b2.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607180659310.30887@schroedinger.engr.sgi.com>
References: <1153167857.31891.78.camel@lappy>
	<Pine.LNX.4.64.0607172035140.28956@schroedinger.engr.sgi.com>
	<1153224998.2041.15.camel@lappy>
	<Pine.LNX.4.64.0607180557440.30245@schroedinger.engr.sgi.com>
	<44BCE86A.4030602@mbligh.org>
	<Pine.LNX.4.64.0607180659310.30887@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2006 07:03:12 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> What other types of non freeable pages could exist?

PageWriteback() pages (potentially all of memory)

Pinned pages (various transient conditions, mainly get_user_pages())

Some pages whose buffers are attached to an ext3 journal.

Possibly NFS unstable pages.
