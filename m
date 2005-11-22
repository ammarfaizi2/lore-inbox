Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbVKVIAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbVKVIAq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 03:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbVKVIAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 03:00:46 -0500
Received: from gate.crashing.org ([63.228.1.57]:44238 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964802AbVKVIAp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 03:00:45 -0500
Subject: Re: [PATCH 3/5] mm: powerpc ptlock comments
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0511220705110.22267@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511212025220.19274@goblin.wat.veritas.com>
	 <Pine.LNX.4.61.0511212033330.19274@goblin.wat.veritas.com>
	 <17282.21410.203627.607569@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.61.0511220705110.22267@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Tue, 22 Nov 2005 18:57:51 +1100
Message-Id: <1132646272.26560.224.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-22 at 07:12 +0000, Hugh Dickins wrote:

> I'd appreciate something that updates the "because" part too, but don't
> know the answer.  That other patch will need to come from your end - Ben?

Hrm... same reason as __hash_page(), the code now locks the PTE using
the _PAGE_BUSY bit. The last store does the update and unlock and
doesn't need to be atomic. However, now that I look at it, it might need
an lwsync. Paul ?

Ben.


