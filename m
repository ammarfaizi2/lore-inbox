Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbTJZNGt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 08:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263115AbTJZNGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 08:06:49 -0500
Received: from cavan.codon.org.uk ([213.162.118.85]:14525 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S263101AbTJZNGs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 08:06:48 -0500
Date: Sun, 26 Oct 2003 13:06:46 +0000
From: Matthew Garrett <mjg59-lk@srcf.ucam.org>
To: linux-kernel@vger.kernel.org
Subject: PMDisk and ACPI
Message-ID: <20031026130646.GA18215@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two issues:

1) My laptop claims to support S4Bios, but it doesn't actually seem to
work. As far as I can tell, the current /sys/power/state code doesn't
actually deal with this situation - if S4Bios is detected, the list of
available states seems to be set to PM_DISK_FIRMWARE. Echoing platform
to /sys/power/disk appears to do nothing. Removing this check lets me
use pmdisk.

2) When doing a suspend to disk, the console changes and spends some
time sitting around before starting to free memory. At this point, I get
some ACPI errors saying "Unable to acquire interpreter mutex".

-- 
Matthew Garrett | mjg59-lk@srcf.ucam.org
