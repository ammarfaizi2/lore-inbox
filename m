Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266201AbTGDWt5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 18:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266202AbTGDWt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 18:49:57 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:25104 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S266201AbTGDWt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 18:49:56 -0400
To: torvalds@osdl.org
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2.5] [0/6] EISA support updates
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Sat, 05 Jul 2003 01:01:22 +0200
Message-ID: <wrpk7axvqv1.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Andrew,

The following serie of 6 patches updates the EISA support to its
latest version.

Summary :

- Now reserves I/O ranges according to EISA specs (four 256 bytes
regions instead of a single 4KB region).

- By default, do not try to probe the bus if the mainboard does not
seems to support EISA (allow this behaviour to be changed through a
command-line option).

- Use parent bridge device dma_mask as default for each discovered
device.

- Allow devices to be enabled or disabled from the kernel command line
(usefull for non-x86 platforms where the firmware simply disable
devices it doesn't know about...).

- Probe the right number of EISA slots on PA-RISC. No more, no less.

The whole thing have been tested on x86, Alpha and PA-RISC.

Please apply.

       M.
-- 
Places change, faces change. Life is so very strange.
