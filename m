Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932712AbVLHXWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932712AbVLHXWx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 18:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932713AbVLHXWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 18:22:53 -0500
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:51471 "EHLO
	smtp-vbr1.xs4all.nl") by vger.kernel.org with ESMTP id S932712AbVLHXWw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 18:22:52 -0500
Date: Fri, 9 Dec 2005 00:22:35 +0100
From: Erik van Konijnenburg <ekonijn@xs4all.nl>
To: yaird-devel@lists.alioth.debian.org
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] yaird 0.0.12, a mkinitrd based on hotplug concepts
Message-ID: <20051209002235.A16206@banaan.localdomain>
Reply-To: yaird-devel@lists.alioth.debian.org
Mail-Followup-To: yaird-devel@lists.alioth.debian.org,
	linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 0.0.12 of yaird is now available at:
	http://yaird.alioth.debian.org

Yaird is a proof of concept perl rewrite of mkinitrd.  It aims to
reliably identify the necessary modules by using the same algorithms
as hotplug, and comes with a template system to to tune the tool for
different distributions and experiment with different image layouts.
It requires a 2.6 kernel with hotplug.  There is a paper discussing it at
the above location.

Hmm, now that hotplug is being replaced with udev, it's time to come up
with a new blurb ...

Anyway, since the tool now has it's own project page and mailing list
at alioth, I plan to announce future releases only on yaird-devel,
no longer on linux-hotplug-devel or linux-kernel.

Summary of user visible changes:
     * Support EVMS
     * Support new hardware: DAC960, Apple MESH, Compaq SmartArray,
       IBM zSeries.
     * Configuration files are now in /usr/local/etc/yaird
       or /etc/yaird, no longer in /usr/local/lib/yaird/conf.
     * Avoid ide-generic if at all possible, because it's slower than
       other IDE drivers.
     * The initrd example template is no longer installed.
       While it is nice that supporting initrd is possible
       in principle, there are no benefits in practice over
       using initramfs, and keeping it in working order is a pain.
     * Module 'fbcon' is now loaded by default; this should allow
       using a framebuffer console.
     * Adapt for mdadm > 1.9.0 output format.
     * Adapt for input driver from 2.6.15 kernel.
     * New 'OPTIONAL MODULE' keyword for configuration file.
     * Bugfixes:
       - blacklist was sometimes ignored.
       - missing line number from template file in some error messages.
       - some variants of fstab format were not recognised:
         LABEL=/, fstype 'auto', fstype 'ext3,vfat', missing fields

Regards,
Erik

