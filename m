Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262403AbVCSEGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbVCSEGQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 23:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbVCSEGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 23:06:16 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:58316
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262401AbVCSEGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 23:06:10 -0500
Date: Fri, 18 Mar 2005 20:05:55 -0800
From: "David S. Miller" <davem@davemloft.net>
To: "Seth, Rohit" <rohit.seth@intel.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       davidm@hpl.hp.com
Subject: Re: [patch] arch hook for notifying changes in PTE protections bits
Message-Id: <20050318200555.2d1980f6.davem@davemloft.net>
In-Reply-To: <20050318162943.A3157@unix-os.sc.intel.com>
References: <20050318162943.A3157@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is way overkill I think.

Take a look at set_pte_at().  You get the "mm", the
virtual address, the pte pointer, and the new pte value.

What else could you possibly need to track stuff like this
and react appropriately? :-)

It is even an argument for batched TLB processing on ia64.
It simplifies a lot of cache flushing issues and you can
control the flushing on a per-translation basis however
you like.
