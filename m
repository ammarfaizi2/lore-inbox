Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbVCNXdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbVCNXdf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 18:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbVCNXdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 18:33:35 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:7040
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262123AbVCNXdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 18:33:21 -0500
Date: Mon, 14 Mar 2005 15:31:56 -0800
From: "David S. Miller" <davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, hugh@veritas.com
Subject: Re: bad pgd/pmd in latest BK on ia64
Message-Id: <20050314153156.159d4bb3.davem@davemloft.net>
In-Reply-To: <20050314151142.716903cb.davem@davemloft.net>
References: <B8E391BBE9FE384DAA4C5C003888BE6F031272AF@scsmsx401.amr.corp.intel.com>
	<20050314143442.2ab086c9.davem@davemloft.net>
	<20050314151142.716903cb.davem@davemloft.net>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005 15:11:42 -0800
"David S. Miller" <davem@davemloft.net> wrote:

> I therefore suspect the pgwalk patches.

I just noticed something else while reviewing this stuff.
The PTRS_PER_PMD macros aren't used anymore, so my hacks
to get 32-bit process VM operations optimized on sparc64
aren't even being used any more, ho hum... :-)  There are
better ways to do this.

(For the interested, see {REAL_}PTRS_PER_PMD in
 include/asm-sparc64/pgtable.h)

Come to think of it, this may be related somehow to whatever
is causing the problems.
