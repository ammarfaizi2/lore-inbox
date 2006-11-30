Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934363AbWK3KTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934363AbWK3KTg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 05:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934366AbWK3KTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 05:19:36 -0500
Received: from ns2.suse.de ([195.135.220.15]:35019 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S934363AbWK3KTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 05:19:35 -0500
Date: Thu, 30 Nov 2006 11:19:34 +0100
From: Nick Piggin <npiggin@suse.de>
To: Andreas Schwab <schwab@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch 1/3] mm: pagecache write deadlocks zerolength fix
Message-ID: <20061130101933.GA12579@wotan.suse.de>
References: <20061130072058.GA18004@wotan.suse.de> <jeodqptf3o.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jeodqptf3o.fsf@sykes.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2006 at 11:15:39AM +0100, Andreas Schwab wrote:
> Nick Piggin <npiggin@suse.de> writes:
> 
> > writev with a zero-length segment is a noop, and we shouldn't return EFAULT.
> 
> AFAICS the callers of these functions never pass a zero length.

They can in the case of a zero length write. I had considered also
doing this check in the caller, but I don't think it is too harmful
to make the API a little more robust? But if you have another
preference?

Thanks,
Nick

