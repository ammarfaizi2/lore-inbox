Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbVCOSsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVCOSsP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 13:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbVCOSoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 13:44:18 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:46524
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261757AbVCOSmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 13:42:23 -0500
Date: Tue, 15 Mar 2005 10:40:35 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Martin Hicks <mort@sgi.com>
Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: bad pgd/pmd in latest BK on ia64
Message-Id: <20050315104035.40549ea8.davem@davemloft.net>
In-Reply-To: <20050315132458.GB19113@localhost>
References: <B8E391BBE9FE384DAA4C5C003888BE6F031272AF@scsmsx401.amr.corp.intel.com>
	<20050314143442.2ab086c9.davem@davemloft.net>
	<20050315132458.GB19113@localhost>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2005 08:24:58 -0500
Martin Hicks <mort@sgi.com> wrote:

> It's also busted on ia64 in 2.6.11-mm3 if that narrows thing down.

Not necessary, we found the problem and the fix is in Linus's
tree.  The clear_page_range() had to be restored to using
pgd_index() looping at the top level.
