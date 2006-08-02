Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWHBEWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWHBEWJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 00:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWHBEWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 00:22:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7601 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751136AbWHBEWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 00:22:07 -0400
Date: Wed, 2 Aug 2006 00:22:00 -0400
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: frequent slab corruption (since a long time)
Message-ID: <20060802042200.GA30216@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org
References: <20060802021617.GH22589@redhat.com> <p73fygfzu2v.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73fygfzu2v.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 05:37:28AM +0200, Andi Kleen wrote:
 > Dave Jones <davej@redhat.com> writes:
 > 
 > > Every so often, I see a slab corruption bug reported against
 > > the Fedora kernels (going back as far as 2.6.11), and it's
 > > still plagueing us.
 > > 
 > > It seems to have turned up in a number of different scenarios,
 > > which makes it all the more complicated, but the footprint is
 > > always the same. We write ffffffff00000000 to freed memory.
 > 
 > DEBUG_PAGEALLOC + a small slab patch to force the 2k slab to be
 > only a single object per page (so that a kfree() immediately
 > triggers an unmap) would catch it I guess.

Problem with that approach is that DEBUG_PAGEALLOC makes things
so damned slow that it's pretty much unusable, and this bug
doesn't seem to want to repeat itself to order, so I doubt
many people would put up with the slowdown long enough to chase it down.

		Dave

-- 
http://www.codemonkey.org.uk
