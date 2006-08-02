Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWHBDha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWHBDha (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 23:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWHBDha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 23:37:30 -0400
Received: from cantor.suse.de ([195.135.220.2]:46573 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751104AbWHBDha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 23:37:30 -0400
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: frequent slab corruption (since a long time)
References: <20060802021617.GH22589@redhat.com>
From: Andi Kleen <ak@suse.de>
Date: 02 Aug 2006 05:37:28 +0200
In-Reply-To: <20060802021617.GH22589@redhat.com>
Message-ID: <p73fygfzu2v.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> writes:

> Every so often, I see a slab corruption bug reported against
> the Fedora kernels (going back as far as 2.6.11), and it's
> still plagueing us.
> 
> It seems to have turned up in a number of different scenarios,
> which makes it all the more complicated, but the footprint is
> always the same. We write ffffffff00000000 to freed memory.

DEBUG_PAGEALLOC + a small slab patch to force the 2k slab to be
only a single object per page (so that a kfree() immediately
triggers an unmap) would catch it I guess.

-Andi
