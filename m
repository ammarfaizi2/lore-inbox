Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264521AbUD2NoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264521AbUD2NoJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 09:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264527AbUD2NoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 09:44:09 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:17383 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264521AbUD2NoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 09:44:06 -0400
Subject: Re: [PATCH] rmap 18 i_mmap_nonlinear
From: James Bottomley <James.Bottomley@steeleye.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, Rik van Riel <riel@redhat.com>,
       Andrew Morton <akpm@osdl.org>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0404290621470.3719-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0404290621470.3719-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 29 Apr 2004 08:43:35 -0500
Message-Id: <1083246218.1804.1.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-29 at 01:10, Hugh Dickins wrote:
> That's right, arm and parisc do handle them differently: currently
> arm ignores i_mmap (and I think rmk was wondering a few months ago
> whether that's actually correct, given that MAP_SHARED mappings
> which can never become writable go in there - and that surprise is
> itself a very good reason for combining them), and parisc... ah,
> what it does in Linus' tree at present is about the same for both,
> but there are some changes on the way.

Actually, as I said before, parisc is reworking the cache flushing stuff
in our tree.  As things currently stand we've altered our map allocation
so that we now treat i_mmap no differently from i_mmap_shared, so we'd
be fine with merging them.

James


