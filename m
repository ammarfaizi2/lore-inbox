Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVEFVYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVEFVYQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 17:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVEFVYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 17:24:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:7313 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261249AbVEFVW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 17:22:27 -0400
Date: Fri, 6 May 2005 14:22:27 -0700
From: Greg KH <gregkh@suse.de>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050506212227.GA24066@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After a very long delay, the 002 release of the hotplug-ng package
finally escaped from my box and can be found at:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-ng-002.tar.gz

The development tree has been converted over to a git archive, and can
be found at:
	rsync://rsync.kernel.org/pub/scm/linux/hotplug/hotplug-ng.git
and can be browsed online at:
	http://www.kernel.org/git/gitweb.cgi?p=linux%2Fhotplug%2Fhotplug-ng.git;a=log

Nothing major in this release, just lots of bugfixes from a bunch of
different people.  Thanks to all of you who sent me fixes for the same
argc bug, I have been sufficiently chastised for such a stupid thing...

Full changelog can be found below, or browsed online at the link above.

So, where to next?  After the 001 release announcement, the main thing
that has happened is that this project is pretty much obsolete
already...

Now, with the 2.6.12-rc3 kernel, and a patch for module-init-tools, the
USB hotplug program can be written with a simple one line shell script:
	modprobe $MODALIAS

So, with a few more kernel patches for the other subsystems (hint, I'll
gladly take them...) the other helper programs can too go away entirely.
That will leave us with only the main /sbin/hotplug multiplexor program
that any distro that uses udev is starting to abandon entirely.

Oh, and the upstream module-init-tools maintainer needs to accept that
patch one of these days...

If I've missed any patches for the code from anyone, my apologies, can
you please resend them against this latest tree?

thanks,

greg k-h

Summary of changes v001 to v002
============================================

Christian Borntraeger:
  o fix segfault when no parameters are used for agents
  o typo in make uninstall

Greg Kroah-Hartman:
  o Add manpage to the install/uninstall rules
  o delete klibc/klibc.spec, which is a generated file
  o fix 'make release' to work properly with git
  o update makefile to allow me to do a tarball interm release for someone
  o fix up argc test in module_form.c
  o make the release tarballs have writable files

Kay Sievers:
  o rename LOG to USE_LOG
  o cleanup logging.h and list.h
  o libsysfs: new version
  o remove old klibc_fixups
  o klibc: version 1.0.3

Pozsar Balazs:
  o Add ieee1394 support
  o fix width of pci ids

Tobias Klauser:
  o Manpage for hotplug-ng


