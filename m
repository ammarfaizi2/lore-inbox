Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVABQge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVABQge (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 11:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVABQge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 11:36:34 -0500
Received: from holomorphy.com ([207.189.100.168]:18068 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261273AbVABQgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 11:36:33 -0500
Date: Sun, 2 Jan 2005 08:36:15 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Robert_Hentosh@Dell.com,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH][1/2] adjust dirty threshold for lowmem-only mappings
Message-ID: <20050102163615.GJ29332@holomorphy.com>
References: <20041224160136.GG4459@dualathlon.random> <Pine.LNX.4.61.0412241118590.11520@chimarrao.boston.redhat.com> <20041224164024.GK4459@dualathlon.random> <Pine.LNX.4.61.0412241711180.11520@chimarrao.boston.redhat.com> <20041225020707.GQ13747@dualathlon.random> <Pine.LNX.4.61.0412251253090.18130@chimarrao.boston.redhat.com> <20041225190710.GZ771@holomorphy.com> <20041225200349.GA11116@dualathlon.random> <20041226030721.GA771@holomorphy.com> <20050102161008.GF5164@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050102161008.GF5164@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2004 at 07:07:21PM -0800, William Lee Irwin III wrote:
>> The problem as posed is that the dirty memory limits are global, but

On Sun, Jan 02, 2005 at 05:10:08PM +0100, Andrea Arcangeli wrote:
> What do you mean with global? Global is one thing, but taking highmem
> into account for calculating the limit is another thing. The
> nr_free_buffer_pages exists exactly to avoid taking highmem into account
> for the dirty memory limits. 2.6 must also ignore highmem in the dirty
> memory limits like 2.4 does. I'd be surprised if somebody broke this in
> 2.6. As far as I can tell, while writing to a blkdev it cannot make any
> difference if you've 4G or 1G of ram because of that (I mean on x86 of
> course).

It's not used for any of these purposes in 2.6.x.


-- wli
