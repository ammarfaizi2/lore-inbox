Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268312AbUHYS7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268312AbUHYS7V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 14:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268308AbUHYS7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 14:59:21 -0400
Received: from waste.org ([209.173.204.2]:64925 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S268286AbUHYS7G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 14:59:06 -0400
Date: Wed, 25 Aug 2004 13:58:54 -0500
From: Matt Mackall <mpm@selenic.com>
To: Paulo Marques <pmarques@grupopie.com>
Cc: linux-kernel@vger.kernel.org, bcasavan@sgi.com
Subject: Re: [PATCH] kallsyms data size reduction / lookup speedup
Message-ID: <20040825185854.GP31237@waste.org>
References: <1093406686.412c0fde79d4f@webmail.grupopie.com> <20040825173941.GJ5414@waste.org> <412CDE9D.3090609@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412CDE9D.3090609@grupopie.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 07:46:53PM +0100, Paulo Marques wrote:
> Matt Mackall wrote:
> >On Wed, Aug 25, 2004 at 05:04:46AM +0100, pmarques@grupopie.com wrote:
> >
> >>As always, comments, suggestions, flames will be greatly appreciated :)
> >
> >
> >Please post patches inline so they're easier to comment on.
> >Attachments are a nuisance.
> 
> Sorry about that. I've had problems in the past with my email client 
> word wrapping patches, so to be sure the patch goes untouched I sent it 
> this way.
> 
> Since I've changed email client since then, next time I'll try inlining 
> again.
> 
> >Am I correct that this is completely replacing stem compression with
> >your substring dictionary approach?
> 
> Yes, you are correct.
> 
> Right now I'm working on making the proc interface more eficient by 
> removing all the seq_file stuff, that was needed because of the O(n) 
> lookup time we had previously.

FYI, killing the seq_file stuff will likely prove unpopular. So you'll
want to do that in a separate patch. If it doesn't affect the way
you're handling compression, please repost your compression patch. I
have a few comments, but otherwise I think we should move forward with it.
 
--
Mathematics is the supreme nostalgia of our time.
