Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266871AbUHOULb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266871AbUHOULb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 16:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266876AbUHOUL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 16:11:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18127 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266871AbUHOULV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 16:11:21 -0400
Date: Sun, 15 Aug 2004 13:09:19 -0700
From: "David S. Miller" <davem@redhat.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault fastpath: Increasing SMP scalability by introducing
 pte locks?
Message-Id: <20040815130919.44769735.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is the read lock in the VMA semaphore enough to let you do
the pgd/pmd walking without the page_table_lock?
I think it is, but just checking.
