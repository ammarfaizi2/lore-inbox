Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUFKFqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUFKFqS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 01:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUFKFqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 01:46:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46555 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261802AbUFKFqQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 01:46:16 -0400
Date: Thu, 10 Jun 2004 22:40:45 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: clameter@sgi.com, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Unaligned accesses in net/ipv4/netfilter/arp_tables.c:184
Message-Id: <20040610224045.612b0ffe.davem@redhat.com>
In-Reply-To: <20040611054111.GV24042@schnapps.adilger.int>
References: <Pine.LNX.4.58.0406091106210.21291@schroedinger.engr.sgi.com>
	<20040610220445.2116457b.davem@redhat.com>
	<20040611054111.GV24042@schnapps.adilger.int>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2004 23:41:11 -0600
Andreas Dilger <adilger@clusterfs.com> wrote:

> - 	for (i = 0, ret = 0; i < IFNAMSIZ/sizeof(unsigned long); i++) {
> + 	for (i = 0, ret = 0; i < IFNAMSIZ; i++) {
> 
> Shouldn't your change include the above?

Yes, I'm retarted, thanks for catching that.
