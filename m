Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966210AbWLDT4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966210AbWLDT4J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 14:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965885AbWLDT4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 14:56:08 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:38741 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S966119AbWLDT4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 14:56:05 -0500
Date: Mon, 4 Dec 2006 11:55:50 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Eric Dumazet <dada1@cosmosbay.com>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SLAB : use a multiply instead of a divide in obj_to_index()
In-Reply-To: <20061204114954.165107b6.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612041154160.32337@schroedinger.engr.sgi.com>
References: <4564C28B.30604@redhat.com> <200612041741.51846.dada1@cosmosbay.com>
 <Pine.LNX.4.64.0612040852250.31485@schroedinger.engr.sgi.com>
 <200612041918.29682.dada1@cosmosbay.com> <20061204114954.165107b6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is similar stuff to asm-generic/div64.h right? The divide overhead 
depends on the platform? Maybe it would better to place it in 
asm-generic/div.h and then have platform specific functions?

