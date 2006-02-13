Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751726AbWBMK0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbWBMK0n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 05:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751729AbWBMK0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 05:26:43 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:39997 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751726AbWBMK0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 05:26:42 -0500
Date: Mon, 13 Feb 2006 11:26:34 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org
Subject: calibrate_migration_costs takes ages on s390
Message-ID: <20060213102634.GA4677@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The boot sequence on s390 sometimes takes ages and we spend a very long time
(up to one or two minutes) in calibrate_migration_costs. The time spent there
differs from boot to boot. Also the calculated costs differ a lot. I've seen
differences by up to a factor of 15 (yes, factor not percent).
Also I doubt that making these measurements make much sense on a completely
virtualized architecture where you cannot tell how much cpu time you will
get anyway.
Is there any workaround or fix available so we can avoid seeing this?

Thanks,
Heiko
