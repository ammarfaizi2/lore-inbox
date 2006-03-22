Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWCVLcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWCVLcg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 06:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWCVLcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 06:32:36 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54047 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750769AbWCVLcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 06:32:35 -0500
Date: Wed, 22 Mar 2006 12:32:35 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com
Subject: Re: dm: bio split bvec fix
Message-ID: <20060322113235.GC4285@suse.de>
References: <20060320192155.GU4724@agk.surrey.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320192155.GU4724@agk.surrey.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20 2006, Alasdair G Kergon wrote:
> The code that handles bios that span table target boundaries by breaking
> them up into smaller bios will not split an individual struct bio_vec
> into more than two pieces.  Sometimes more than that are required.
> 
> This patch adds a loop to break the second piece up into as many
> pieces as are necessary.

Why isn't this just handled in the merge callback? Can a single page bio
span > 2 targets?

-- 
Jens Axboe

