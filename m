Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264904AbUGCFMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264904AbUGCFMn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 01:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264913AbUGCFMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 01:12:43 -0400
Received: from ozlabs.org ([203.10.76.45]:36057 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264904AbUGCFMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 01:12:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16614.16478.9599.463185@cargo.ozlabs.ibm.com>
Date: Sat, 3 Jul 2004 15:13:02 +1000
From: Paul Mackerras <paulus@samba.org>
To: linas@austin.ibm.com
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 PPC64 EEH unbalanced dev_get/put calls
In-Reply-To: <20040702134539.W21634@forte.austin.ibm.com>
References: <20040702134539.W21634@forte.austin.ibm.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas,

> This patch fixes some unbalanaced usage of pci_dev_get()/pci_dev_put() calls
> in the eeh code.  The old code had too many calls to dev_put, which could
> cause memory structs to be freed prematurely, possibly leading to bad
> bad pointer derefs in certain cases.

When I apply this I end up with one pci_dev_get() call in
__pci_addr_cache_insert_device and no pci_dev_put() calls.  That can't
be right, surely?  If it is it needs a big fat comment explaining why.

> Cross-ref LTC bug 9283

Confused - that's the bug about not using ibm,fw-phb-id.

Paul.
