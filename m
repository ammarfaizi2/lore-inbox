Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935645AbWK3Laz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935645AbWK3Laz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 06:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759254AbWK3Laz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 06:30:55 -0500
Received: from mail.suse.de ([195.135.220.2]:11488 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1759253AbWK3Lay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 06:30:54 -0500
Date: Thu, 30 Nov 2006 12:30:52 +0100
From: Nick Piggin <npiggin@suse.de>
To: Andreas Schwab <schwab@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch 1/3] mm: pagecache write deadlocks zerolength fix
Message-ID: <20061130113052.GB12579@wotan.suse.de>
References: <20061130072058.GA18004@wotan.suse.de> <jeodqptf3o.fsf@sykes.suse.de> <20061130101933.GA12579@wotan.suse.de> <jeac29teeu.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jeac29teeu.fsf@sykes.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2006 at 11:30:33AM +0100, Andreas Schwab wrote:
> Nick Piggin <npiggin@suse.de> writes:
> 
> > On Thu, Nov 30, 2006 at 11:15:39AM +0100, Andreas Schwab wrote:
> >> Nick Piggin <npiggin@suse.de> writes:
> >> 
> >> > writev with a zero-length segment is a noop, and we shouldn't return EFAULT.
> >> 
> >> AFAICS the callers of these functions never pass a zero length.
> >
> > They can in the case of a zero length write.
> 
> How?  All (indirect) callers I could find explicitly handle the
> zero-length case.

Sorry, zero length iov to writev (just had to double-check
there ;).

