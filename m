Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272857AbTG3Nti (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 09:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272871AbTG3Nti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 09:49:38 -0400
Received: from ifi.informatik.uni-stuttgart.de ([129.69.211.1]:10184 "EHLO
	ifi.informatik.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id S272857AbTG3Nth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 09:49:37 -0400
Date: Wed, 30 Jul 2003 15:47:09 +0200
From: "Marcelo E. Magallon" <mmagallo@debian.org>
To: linux-kernel@vgers.kernel.org
Subject: [PATCH] [2.4] AGPGART support for intel 7205/7505 chipsets
Message-ID: <20030730134709.GA9076@informatik.uni-stuttgart.de>
Mail-Followup-To: "Marcelo E. Magallon" <mmagallo@debian.org>,
	linux-kernel@vgers.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux techno 2.4.21-ck1
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 please Cc: mmagallo@debian.org, I'm not subscribed to the list.

 Attached is a small backport from 2.6 to 2.4 to add support for Intel's
 7205 and 7505 chipsets.  The patch has been tested and works using
 NVIDIA's binary-only drivers with a GeForce 4200 in AGP 8x mode.  We
 haven't been able to get a Radeon card to work yet.  The last version
 of the kernel that I've used for testing is 2.4.22-pre6-ac1.

 The machine where this has been tested has 4 GB of RAM installed and
 the kernel sets up, right after booting, 8 MTRR regions leaving none
 for the AGP aperture or the graphics card memory.  In that situation
 the NVIDIA driver fails to set up AGP properly and disables it
 altogether.  The last two regions look like this:

reg06: base=0x400000000 (16384MB), size=16384MB: write-back, count=1
reg07: base=0x800000000 (32768MB), size=32768MB: write-back, count=1

 by disabling them and then starting the X server everything works fine.

 Cheers,

 Marcelo
