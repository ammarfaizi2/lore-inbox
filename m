Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262663AbVCWAlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbVCWAlQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 19:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbVCWAlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 19:41:15 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:47531 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262663AbVCWAlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 19:41:04 -0500
Date: Wed, 23 Mar 2005 00:40:01 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Luck, Tony" <tony.luck@intel.com>
cc: "David S. Miller" <davem@davemloft.net>,
       Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: RE: [PATCH 1/5] freepgt: free_pgtables use vma list
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F03211751@scsmsx401.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.61.0503230039260.10858@goblin.wat.veritas.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F03211751@scsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005, Luck, Tony wrote:
> 
> Alternatively you could modify the use of floor/ceiling as they
> are passed down from the top level to indicate the progressively
> greater address ranges that have been dealt with ... but I'm not
> completely convinced that gives you enough information.  You would
> need to do careful extension of the ceiling at each level to make
> sure that you reach out to the end of of each table at each level
> to account for gaps between vmas (which would result in no future
> calldown hitting this part of the table).

That pretty much describes how it does work (when it works!)

Hugh
