Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbUD1XpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbUD1XpT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 19:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUD1XpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 19:45:18 -0400
Received: from holomorphy.com ([207.189.100.168]:23168 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262007AbUD1XpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 19:45:13 -0400
Date: Wed, 28 Apr 2004 16:44:48 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@redhat.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rmap 18 i_mmap_nonlinear
Message-ID: <20040428234448.GB737@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@redhat.com>, Hugh Dickins <hugh@veritas.com>,
	Andrew Morton <akpm@osdl.org>,
	Rajesh Venkatasubramanian <vrajesh@umich.edu>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0404280103350.2444-100000@localhost.localdomain> <Pine.LNX.4.44.0404281909310.19633-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404281909310.19633-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 07:11:18PM -0400, Rik van Riel wrote:
> ... do we still need both i_mmap and i_mmap_shared?
> Is there a place left where we're using both trees in
> a different way, or are we just walking both trees
> anyway in all places where they're referenced ?

I believe the flush_dcache_page() implementations touching
->i_mmap_shared care about this distinction.


-- wli
