Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVABQK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVABQK4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 11:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVABQK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 11:10:56 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:21707 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261262AbVABQKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 11:10:55 -0500
Date: Sun, 2 Jan 2005 17:10:08 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Robert_Hentosh@Dell.com,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH][1/2] adjust dirty threshold for lowmem-only mappings
Message-ID: <20050102161008.GF5164@dualathlon.random>
References: <Pine.LNX.4.61.0412231420260.5468@chimarrao.boston.redhat.com> <20041224160136.GG4459@dualathlon.random> <Pine.LNX.4.61.0412241118590.11520@chimarrao.boston.redhat.com> <20041224164024.GK4459@dualathlon.random> <Pine.LNX.4.61.0412241711180.11520@chimarrao.boston.redhat.com> <20041225020707.GQ13747@dualathlon.random> <Pine.LNX.4.61.0412251253090.18130@chimarrao.boston.redhat.com> <20041225190710.GZ771@holomorphy.com> <20041225200349.GA11116@dualathlon.random> <20041226030721.GA771@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041226030721.GA771@holomorphy.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2004 at 07:07:21PM -0800, William Lee Irwin III wrote:
> The problem as posed is that the dirty memory limits are global, but

What do you mean with global? Global is one thing, but taking highmem
into account for calculating the limit is another thing. The
nr_free_buffer_pages exists exactly to avoid taking highmem into account
for the dirty memory limits. 2.6 must also ignore highmem in the dirty
memory limits like 2.4 does. I'd be surprised if somebody broke this in
2.6. As far as I can tell, while writing to a blkdev it cannot make any
difference if you've 4G or 1G of ram because of that (I mean on x86 of
course).
