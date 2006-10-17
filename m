Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423029AbWJQLFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423029AbWJQLFT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 07:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422899AbWJQLFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 07:05:18 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:60807 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1422697AbWJQLFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 07:05:17 -0400
Date: Tue, 17 Oct 2006 13:05:51 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Duncan Sands <duncan.sands@math.u-psud.fr>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Patch 0/4] Driver core: Some probing changes, v2
Message-ID: <20061017130551.24f2f35c@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following patches (updated from yesterday) attempt to fix some
issues in the current device probing code:

[1/4] Don't stop probing on ->probe errors.
[2/4] Change function call order in device_bind_driver().
[3/4] Per-subsystem multithreaded probing.
[4/4] Don't fail attaching the device if it cannot be bound.

Patches 1 and 3 incorporate some comments I received (thanks to the
reviewers). Patch 4 comes out of the discussion and tries to handle
devices with and without dev->driver set more consistently.
