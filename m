Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbVCUTrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVCUTrr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 14:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVCUTrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 14:47:46 -0500
Received: from smtp-vbr5.xs4all.nl ([194.109.24.25]:13325 "EHLO
	smtp-vbr5.xs4all.nl") by vger.kernel.org with ESMTP id S261740AbVCUTra
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 14:47:30 -0500
Date: Mon, 21 Mar 2005 20:47:20 +0100
From: Erik van Konijnenburg <ekonijn@xs4all.nl>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] yaird 0.0.5, a mkinitrd based on hotplug concepts
Message-ID: <20050321204720.A10417@banaan.localdomain>
Mail-Followup-To: linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 0.0.5 of yaird is now available at:
	http://www.xs4all.nl/~ekonijn/yaird/yaird-0.0.5.tar.gz

Yaird is a proof of concept perl rewrite of mkinitrd.  It aims to
reliably identify the necessary modules by using the same algorithms
as hotplug, and comes with a template system to to tune the tool for
different distributions and experiment with different image layouts.
It requires a 2.6 kernel with hotplug.  There is a paper discussing it at:

	http://www.xs4all.nl/~ekonijn/yaird/yaird.html

Summary of user visible changes for version 0.0.5
     * adapt Debian template to use initramfs rather than initrd.
       The old initrd template is available as Debian-initrd.
     * allow template to see requested kernel version,
       and to copy a complete tree to the image.  This makes it
       possible to put /lib/modules/2.6.10-smp on the image and do hotplug.
     * add command line option --root=/dev/hdb, to simplify testing.
     * add run_init: executable to make the move to the real root
       device in initramfs context.
     * README: new section on (optional) use of klibc,
       new section on replacing mkinitrd during kernel install.
     * more reliable shared library detection: works with glibc and
       klibc; if other C libraries use shared libraries, an error
       message results.
     * Documentation: writeup on initramfs, notes on shared libraries.
     * change installation directory from /usr/local/share/yaird/
       to /usr/local/lib/yaird/, since there are executables included now.

On top of the todo list are now:
     * support modprobe.conf
     * support dm_crypt
     * support loopback devices as root
     * any patches you may wish to send :)

Regards,
Erik
