Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283259AbRLMD3h>; Wed, 12 Dec 2001 22:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283245AbRLMD31>; Wed, 12 Dec 2001 22:29:27 -0500
Received: from rj.SGI.COM ([204.94.215.100]:43190 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S283244AbRLMD3W>;
	Wed, 12 Dec 2001 22:29:22 -0500
Date: Wed, 12 Dec 2001 19:29:09 -0800
From: Jesse Barnes <jbarnes@sgi.com>
To: "Eric S. Raymond" <esr@thyrsus.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>, davidm@hpl.hp.com,
        linux-ia64@linuxia64.org
Subject: Re: We're down to just 32 missing Configure.help symbols
Message-ID: <20011212192909.A701465@sgi.com>
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>, davidm@hpl.hp.com,
	linux-ia64@linuxia64.org
In-Reply-To: <20011212213307.A31039@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011212213307.A31039@thyrsus.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2001 at 09:33:07PM -0500, Eric S. Raymond wrote:
> We're down to just 32 missing Configure.help entries, thanks to excellent
> cooperation from the ARM developers and a siege of rooting through kernel 
> sources by yours truly.  That's a big improvement from 96 last week.

Here's a patch for a couple of the missing IA64 entries, hope it's
helpful.

Jesse


diff -Naur --exclude=*~ --exclude=TAGS linux-2.4.16/Documentation/Configure.help linux-2.4.16-confighelp/Documentation/Configure.help
--- linux-2.4.16/Documentation/Configure.help	Thu Nov 22 10:52:44 2001
+++ linux-2.4.16-confighelp/Documentation/Configure.help	Wed Dec 12 19:24:14 2001
@@ -15635,6 +15635,23 @@
 
   If unsure, say N.
 
+Support for SGI L1 system controllers
+CONFIG_SERIAL_SGI_L1_PROTOCOL
+  Saying Y here will build support for SGI L1 system controllers.
+
+  The L1 system controller is used as a console device as well as
+  for various system management tasks (e.g. power on/off, reset,
+  fan control, etc.).  You'll want to say Y here unless you have
+  special needs.
+
+Enable llsc cache coherency test
+CONFIG_IA64_SGI_AUTOTEST
+  Build a kernel used for hardware validation. If you include the
+  keyword "autotest" on the boot command line, the kernel does NOT boot.
+  Instead, it starts all cpus and runs cache coherency tests instead.
+
+  If unsure, say N.
+
 Support for PowerMac serial ports
 CONFIG_MAC_SERIAL
   If you have Macintosh style serial ports (8 pin mini-DIN), say Y
