Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVABQxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVABQxW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 11:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVABQxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 11:53:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23726 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261275AbVABQxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 11:53:19 -0500
Date: Sun, 2 Jan 2005 11:53:09 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Robert_Hentosh@Dell.com,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH][1/2] adjust dirty threshold for lowmem-only mappings
In-Reply-To: <20050102161008.GF5164@dualathlon.random>
Message-ID: <Pine.LNX.4.61.0501021152280.23180@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0412231420260.5468@chimarrao.boston.redhat.com>
 <20041224160136.GG4459@dualathlon.random> <Pine.LNX.4.61.0412241118590.11520@chimarrao.boston.redhat.com>
 <20041224164024.GK4459@dualathlon.random> <Pine.LNX.4.61.0412241711180.11520@chimarrao.boston.redhat.com>
 <20041225020707.GQ13747@dualathlon.random>
 <Pine.LNX.4.61.0412251253090.18130@chimarrao.boston.redhat.com>
 <20041225190710.GZ771@holomorphy.com> <20041225200349.GA11116@dualathlon.random>
 <20041226030721.GA771@holomorphy.com> <20050102161008.GF5164@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jan 2005, Andrea Arcangeli wrote:

> nr_free_buffer_pages exists exactly to avoid taking highmem into account
> for the dirty memory limits. 2.6 must also ignore highmem in the dirty
> memory limits like 2.4 does. I'd be surprised if somebody broke this in
> 2.6.

2.6 does not ignore highmem when calculating the dirty memory
limits, which is causing problems.  That's why I sent in the
patch in the first place ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
