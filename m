Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVALMgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVALMgg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 07:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVALMgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 07:36:36 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:4065 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261167AbVALMge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 07:36:34 -0500
Date: Wed, 12 Jan 2005 06:35:24 -0600
From: Robin Holt <holt@sgi.com>
To: Ray Bryant <raybry@sgi.com>
Cc: Steve Longerbeam <stevel@mvista.com>, Andi Kleen <ak@muc.de>,
       Hirokazu Takahashi <taka@valinux.co.jp>,
       Dave Hansen <haveblue@us.ibm.com>,
       Marcello Tosatti <marcelo.tosatti@cyclades.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, andrew morton <akpm@osdl.org>
Subject: Re: page migration patchset
Message-ID: <20050112123524.GA12843@lnx-holt.americas.sgi.com>
References: <41DB35B8.1090803@sgi.com> <m1wtusd3y0.fsf@muc.de> <41DB5CE9.6090505@sgi.com> <41DC34EF.7010507@mvista.com> <41E3F2DA.5030900@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E3F2DA.5030900@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 09:38:02AM -0600, Ray Bryant wrote:
> Pages that are found to be swapped out would be handled as follows:
> Add the original node id to either the swap pte or the swp_entry_t.
> Swap in will be modified to allocate the page on the same node it
> came from.  Then, as part of migrate_process_pages, all that would
> be done for swapped out pages would be to change the "original node"
> field to point at the new node.
> 
> However, I could probably do both steps (2) and (3) as part of the
> migrate_process_pages() call.

I don't think we need to worry about the swap case.  Let's keep the
changes small and build when we see problems.  The normal swap
out/in mechanism should handle nearly all the page migration issues
you are concerned with.

Just my 2 cents,
Robin
