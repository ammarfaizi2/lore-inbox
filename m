Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752476AbWKBCP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbWKBCP6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 21:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752527AbWKBCP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 21:15:57 -0500
Received: from junsun.net ([66.29.16.26]:24076 "EHLO junsun.net")
	by vger.kernel.org with ESMTP id S1752476AbWKBCP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 21:15:57 -0500
Date: Wed, 1 Nov 2006 18:15:47 -0800
From: Jun Sun <jsun@junsun.net>
To: linux-kernel@vger.kernel.org
Subject: Can Linux live without DMA zone?
Message-ID: <20061102021547.GA1240@srv.junsun.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am trying to reserve a block of memory (>16MB) starting from 0 and hide it 
from kernel.  A consequence is that DMA zone now has size 0.  That causes
many drivers to grief (OOMs).

I see two ways out:

1. Modify individual drivers and convince them not to alloc with GFP_DMA.
   I have been trying to do this but do not seem to see an end of it.  :)

2. Simply lie and increase MAX_DMA_ADDRESS to really big (like 1GB) so that
   the whole memory region belongs to DMA zone.

#2 sounds pretty hackish.  I am sure something bad will happen
sooner or later (like what?). But so far it appears to be working fine.

The fundamental question is: Has anybody tried to run Linux without 0 sized
DMA zone before?  Am I doing something that nobody has done before (which is
something really hard to believe these days with Linux :P)?

Cheers.

Jun
