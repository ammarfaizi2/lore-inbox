Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965011AbVLFSlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbVLFSlh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 13:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbVLFSlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 13:41:37 -0500
Received: from silver.veritas.com ([143.127.12.111]:63660 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S965008AbVLFSlg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 13:41:36 -0500
Date: Tue, 6 Dec 2005 18:39:56 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] /dev/mem validate mmap requests
In-Reply-To: <200512051700.20269.bjorn.helgaas@hp.com>
Message-ID: <Pine.LNX.4.61.0512061832090.26899@goblin.wat.veritas.com>
References: <200512051700.20269.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 06 Dec 2005 18:39:52.0230 (UTC) FILETIME=[71DC6460:01C5FA94]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2005, Bjorn Helgaas wrote:
> Add a hook so architectures can validate /dev/mem mmap requests.

Not a comment on your patch at all, just an FYI in case you've missed
it, and in case it makes any difference to your ia64 needs.

A side-effect of 2.6.15-rc's PageReserved changes is that a user with
access to /dev/mem can now mmap any page of it, and see what's there
rather than zeroes, whether or not it has been marked PageReserved.

Hugh
