Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266193AbUI0Sa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266193AbUI0Sa5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 14:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267170AbUI0Saz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 14:30:55 -0400
Received: from 64.221.211.203.ptr.us.xo.net ([64.221.211.203]:1937 "EHLO
	mail.pathscale.com") by vger.kernel.org with ESMTP id S266193AbUI0SaN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 14:30:13 -0400
Subject: Re: AMD64 and NFORCE3 250GB very slow and USB hungs
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Michael Thonke <tk-shockwave@web.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41569DE5.4080206@web.de>
References: <41569DE5.4080206@web.de>
Content-Type: text/plain
Date: Mon, 27 Sep 2004 11:30:12 -0700
Message-Id: <1096309812.26765.7.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-26 at 12:45 +0200, Michael Thonke wrote:

> I bought just a new AMD64 system with an NForce 3 based mainboard (MSI 
> K8N Neo2 Platinum).

There's a known problem with NForce2 and NForce3 chipsets that affects
at least IDE interrupt handling, the effect being that the system hangs
if there's "too much" disk activity.  I've verified that this occurs
with 2.6.8.1, but haven't tried more recent snapshots.

The symptom is that the system hangs hard during boot.

A tolerable workaround appears to be to drop the IDE UDMA level down to
3 using hdparm.  If you're using a Fedora Core distro and edit /etc/
sysconfig/harddisks to do this, it gets set up early enough during boot
that the system rarely hangs.

I haven't had time to look into this deeper, but I did file a bug
against it: http://bugzilla.kernel.org/show_bug.cgi?id=3398

It should probably be owned by Jens, since it seems to be IDE-specific,
but Andi has it for now.

	<b

