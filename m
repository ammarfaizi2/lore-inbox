Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266143AbUJWJ4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266143AbUJWJ4p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 05:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266189AbUJWJ4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 05:56:45 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:34315 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266143AbUJWJ4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 05:56:44 -0400
Date: Sat, 23 Oct 2004 10:56:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH} Trivial - fix drm_agp symbol export
Message-ID: <20041023095644.GC30137@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jon Smirl <jonsmirl@gmail.com>, lkml <linux-kernel@vger.kernel.org>
References: <9e473391041022214570eab48a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e473391041022214570eab48a@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2004 at 12:45:42AM -0400, Jon Smirl wrote:
> Exports the symbol for drm agp entry points. This allows the new drm
> linux-core module to get the symbol with symbol_get() instead of
> inter_module_get(). After the new drm code arrives inter_module_xx
> code in AGP can be deleted.

Sorry, wrong API.  At least export the individual functions and use them
directly (and without the symbol_get abnomination that's not any better
than inter_module_*).

