Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751897AbWAOK52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbWAOK52 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 05:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbWAOK52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 05:57:28 -0500
Received: from gold.veritas.com ([143.127.12.110]:48162 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751897AbWAOK51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 05:57:27 -0500
Date: Sun, 15 Jan 2006 10:58:02 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Christoph Lameter <clameter@engr.sgi.com>
cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: Race in new page migration code?
In-Reply-To: <Pine.LNX.4.62.0601141040400.11601@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.61.0601151053420.4500@goblin.wat.veritas.com>
References: <20060114155517.GA30543@wotan.suse.de>
 <Pine.LNX.4.62.0601140955340.11378@schroedinger.engr.sgi.com>
 <20060114181949.GA27382@wotan.suse.de> <Pine.LNX.4.62.0601141040400.11601@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 15 Jan 2006 10:57:27.0636 (UTC) FILETIME=[79515140:01C619C2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jan 2006, Christoph Lameter wrote:
> 
> Also remove the WARN_ON since its now even possible that other actions of 
> the VM move the pages into the LRU lists while we scan for pages to
> migrate.

Good.  And whether it's your or Nick's patch that goes in, please also
remove that PageReserved test which you recently put in check_pte_range.

Hugh
