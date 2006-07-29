Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWG2UPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWG2UPb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 16:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWG2UPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 16:15:31 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:14608 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751351AbWG2UPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 16:15:30 -0400
Date: Sat, 29 Jul 2006 16:11:39 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org,
       nhorman@tuxdriver.com, torvalds@osdl.org, akpm@osdl.org,
       marcel@holtman.org, fpavlic@de.ibm.com, paulus@au.ibm.com,
       bcollins@debian.org, tony.luck@intel.com
Subject: [KJ] (re) audit return code handling for kernel_thread [0/3]
Message-ID: <20060729201139.GA8574@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all-
	I recently posted 11 patches to audit the handling of return codes for
calls made to kernel_thread.  I'd like to rescind those patches, in favor of the
following three, which take into account the feedback I've recieved on them.
Specifically these patches are redistributed to only be three patches rather
than 11, so that each patch fixes a class of problem that I found.  Also the
changes for delayed checks of return codes that don't consider negative returns
now properly check for >= 0 codes.  Finally added printks, all have the same
string format, to save space in the string table.

Thanks & Regards
Neil

