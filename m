Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbTDIMXK (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 08:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263286AbTDIMXK (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 08:23:10 -0400
Received: from tomts15.bellnexxia.net ([209.226.175.3]:46998 "EHLO
	tomts15-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S263204AbTDIMXJ (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 08:23:09 -0400
Date: Wed, 9 Apr 2003 08:30:34 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: what means duplicate "config" entries in Kconfig file?
Message-ID: <Pine.LNX.4.44.0304090826470.25330-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [i just tried to email the Kconfig maintainer, but sendmail
suggested that that mail might not have gotten through, so i'll
toss this out here.]

  in my quest to clean up even more kernel config menus,
i ran across the following oddity in arch/i386/Kconfig:

-----

config MCA
	bool "MCA support"
	depends on !(X86_VISWS || X86_VOYAGER)
	help
	  MicroChannel Architecture is found in some IBM PS/2 machines and
	  laptops.  It is a bus system similar to PCI or ISA. See
	  <file:Documentation/mca.txt> (and especially the web page given
	  there) before attempting to build an MCA bus kernel.

config MCA
	depends on X86_VOYAGER
	default y if X86_VOYAGER

source "drivers/mca/Kconfig"

-----

  i'm not sure what it means to have two config entries with 
identical symbols.  can someone clarify this?  i'm just confused
(which should not come as a surprise at this point).

rday

p.s.  and i'm open to where i should be emailing those patches
if this list is not the right place.

