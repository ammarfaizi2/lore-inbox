Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbVKHCPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbVKHCPK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbVKHCPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:15:09 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:60281 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1030267AbVKHCPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:15:08 -0500
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: kernel-janitors@lists.osdl.org, Pekka J Enberg <penberg@cs.Helsinki.FI>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] Cleanup kmem_cache_create()
X-Message-Flag: Warning: May contain useful information
References: <436FF51D.8080509@us.ibm.com> <436FF70D.6040604@us.ibm.com>
From: Roland Dreier <rolandd@cisco.com>
Date: Mon, 07 Nov 2005 18:14:33 -0800
In-Reply-To: <436FF70D.6040604@us.ibm.com> (Matthew Dobson's message of
 "Mon, 07 Nov 2005 16:53:33 -0800")
Message-ID: <52mzkfrily.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 08 Nov 2005 02:14:35.0436 (UTC) FILETIME=[29F07EC0:01C5E40A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > * Replace a constant (4096) with what it represents (PAGE_SIZE)

This seems dangerous.  I don't pretend to understand the slab code,
but the current code works on architectures with PAGE_SIZE != 4096.
Are you sure this change is correct?

 - R.
