Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266684AbUJRSGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266684AbUJRSGx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 14:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267254AbUJRSGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 14:06:52 -0400
Received: from vanessarodrigues.com ([192.139.46.150]:45030 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S266684AbUJRSGs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 14:06:48 -0400
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, akpm@osdl.org,
       tony.luck@intel.com
Subject: Re: [PATCH] General purpose zeroed page slab
From: "Martin K. Petersen" <mkp@wildopensource.com>
Organization: Wild Open Source, Inc.
References: <yq1oej5s0po.fsf@wilson.mkp.net>
	<20041014180427.GA7973@wotan.suse.de>
Date: Mon, 18 Oct 2004 14:06:45 -0400
In-Reply-To: <20041014180427.GA7973@wotan.suse.de> (Andi Kleen's message of
 "Thu, 14 Oct 2004 20:04:27 +0200")
Message-ID: <yq1ekjvrjd6.fsf@wilson.mkp.net>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andi" == Andi Kleen <ak@suse.de> writes:

[Sorry about dropping off of the planet for a couple of days.  Had to
deal with some water damage on the house :/]

Andi> The means every user has to memset it to zero before free.  Add
Andi> a comment for that at least.

Andi> Also that's pretty dumb. How about keeping track how much of the
Andi> page got non zeroed (e.g. by using a few free words in struct
Andi> page for a coarse grained dirty bitmap)

Andi> Then you could memset on free only the parts that got actually
Andi> changed, and never waste cache lines for anything else.

Ayup.  I'll ponder this a bit.  For now I think I'm going to leave the
page table cache stuff as is and make the general purpose slab a
separate project.  It'll be easy to switch the page tables over later.

-- 
Martin K. Petersen	Wild Open Source, Inc.
mkp@wildopensource.com	http://www.wildopensource.com/
