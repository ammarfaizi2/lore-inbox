Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbULTID1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbULTID1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 03:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbULTICH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 03:02:07 -0500
Received: from gate.crashing.org ([63.228.1.57]:9891 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261491AbULTHJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 02:09:10 -0500
Subject: /sys/block vs. /sys/class/block
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Patrick Mochel <mochel@digitalimplant.org>, Jens Axboe <axboe@suse.de>
Content-Type: text/plain
Date: Mon, 20 Dec 2004 08:08:52 +0100
Message-Id: <1103526532.5320.33.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to understand why we have /sys/block instead
of /sys/class/block, and so far, I haven't found a single good argument
justifying it... It just messes up the so far logical layout of sysfs
for no apparent reason.

I also didn't find where /sys/block is created, but that's maybe because
I didn't search too hard :) So I'm not coming up with a patch yet, but
unless somebody can convince me it should stay here, I'll do so soon.

If the reason not to fix it is backward compatibility, then that would
really be a shame we managed already to turn the brand new sysfs into a
mess with no hope of fixing it... If there is really a problem there,
maybe we could move it and keep a compat symlink for a few kernel
revs... ?

Ben.


