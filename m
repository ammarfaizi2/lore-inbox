Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVBWR0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVBWR0I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 12:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbVBWR0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 12:26:06 -0500
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31]:38919 "EHLO
	smtp-vbr11.xs4all.nl") by vger.kernel.org with ESMTP
	id S261508AbVBWRY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 12:24:57 -0500
Date: Wed, 23 Feb 2005 18:24:52 +0100
From: Erik van Konijnenburg <ekonijn@xs4all.nl>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] yaird 0.0.4, a mkinitrd based on hotplug concepts
Message-ID: <20050223182452.A4913@banaan.localdomain>
Mail-Followup-To: linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 0.0.4 of yaird is now available at:
	http://www.xs4all.nl/~ekonijn/yaird/yaird-0.0.4.tar.gz

Yaird is a perl rewrite of mkinitrd.  It aims to reliably identify the
necessary modules by using the same algorithms as hotplug, and comes
with a template system to to tune the tool for different distributions
and experiment with different image layouts.  It requires a 2.6 kernel
with hotplug.  There is a paper discussing it at:
	http://www.xs4all.nl/~ekonijn/yaird/yaird.html

There are rough edges in practically every feature, and numerous
features still need to be added: this is suitable for testing, but not
for production use.

Thanks to all who gave feedback, sent patches and were brave enough
to test this stuff.  Below are highlights from the change log and 
todo list.

Summary of user visible changes for version 0.0.4:
     * Process kernel command line options: init=, ro, rw.
     * Boot into single user mode supported
     * Support modules outside /lib/modules
     * Support modules with extension other than .ko
     * Warn about duplicates in modules.dep
     * Generated image now waits for device to become visible in /sys,
       and gives error message if it doesn't
     * Support 2.6.10 sysfs layout: SCSI now has a
       new subdirectory 'target'.
       (Thanks to Harald Dunkel for testing)
     * Warn about unrecognised paths in /sys
     * Empty lines in /etc/fstab are valid.
       (Patch Goffredo Baroncelli)

On top of the todo list are now:
     * add command line option (--root=/dev/hdb) to simplify testing.
     * add tree copying to the templates, to allow all of firmware
       to be copied to the image.  Or all of /lib/modules, if you want
       to have hotplug on the image.
     * get klibc run_init working.
       Test by switching the Debian template to initramfs.
       This should make Debian and Fedora templates more
       similar, it is also groundwork for possible
       hotplug-ng support.
     * any patches you may wish to send :)

Regards,
Erik
