Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWGLXLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWGLXLV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 19:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWGLXLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 19:11:21 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:51074 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751414AbWGLXLU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 19:11:20 -0400
Date: Wed, 12 Jul 2006 18:11:18 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: John Keller <jpk@sgi.com>
cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 1/1] - sgiioc4: fixup use of mmio ops
In-Reply-To: <20060712175714.16943.10799.sendpatchset@attica.americas.sgi.com>
Message-ID: <20060712180643.N27752@pkunk.americas.sgi.com>
References: <20060712175714.16943.10799.sendpatchset@attica.americas.sgi.com>
Organization: Silicon Graphics, Inc.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2006, John Keller wrote:

> sgiioc4.c had been recently converted to using mmio ops.
> There are still a few issues to cleanup.

An issue I noticed the other day is that we really should be turning
on CONFIG_IDEPCI_SHARE_IRQ whenever CONFIG_BLK_DEV_SGIIOC4 is selected.
The IOC4 IDE part shares a PCI interrupt with the other IOC4 devices
(serial, external interrupts), so it is effectively always sharing an
IRQ.

I just haven't created the patch yet, and will be out of the office
until next Tuesday.  You might want to consider fixing this side-issue
as well as long as you're touching the IOC4 IDE code.

Brent

-- 
Brent Casavant                          All music is folk music.  I ain't
bcasavan@sgi.com                        never heard a horse sing a song.
Silicon Graphics, Inc.                    -- Louis Armstrong
