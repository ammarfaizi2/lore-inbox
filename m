Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135743AbRDSWuJ>; Thu, 19 Apr 2001 18:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135746AbRDSWuA>; Thu, 19 Apr 2001 18:50:00 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:21003 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S135743AbRDSWtl>;
	Thu, 19 Apr 2001 18:49:41 -0400
Date: Thu, 19 Apr 2001 18:50:34 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: OK, let's try cleaning up another nit.  Is anyone paying attention?
Message-ID: <20010419185034.A8842@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dead CONFIG_BINFMT_JAVA symbol.

--- arch/cris/config.in	2001/04/18 14:18:58	1.1
+++ arch/cris/config.in	2001/04/18 14:19:11
@@ -18,9 +18,6 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
-if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
-  tristate 'Kernel support for JAVA binaries' CONFIG_BINFMT_JAVA
-fi
 
 bool 'Use kernel gdb debugger' CONFIG_KGDB
 
--- arch/cris/defconfig	2001/04/18 14:31:34	1.1
+++ arch/cris/defconfig	2001/04/18 14:31:39
@@ -14,7 +14,6 @@
 CONFIG_NET=y
 CONFIG_SYSVIPC=y
 CONFIG_BINFMT_ELF=y
-# CONFIG_BINFMT_JAVA is not set
 # CONFIG_KGDB is not set
 # CONFIG_ETRAX_WATCHDOG is not set
 CONFIG_USE_SERIAL_CONSOLE=y
--- arch/parisc/config.in	2001/04/18 14:18:08	1.1
+++ arch/parisc/config.in	2001/04/18 14:18:28
@@ -66,9 +66,6 @@
 tristate 'Kernel support for SOM binaries' CONFIG_BINFMT_SOM
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
-if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
-  tristate 'Kernel support for JAVA binaries (obsolete)' CONFIG_BINFMT_JAVA
-fi
 
 endmenu
 
--- arch/parisc/defconfig	2001/04/18 14:18:49	1.1
+++ arch/parisc/defconfig	2001/04/18 14:18:53
@@ -40,7 +40,6 @@
 CONFIG_BINFMT_SOM=y
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
-# CONFIG_BINFMT_JAVA is not set
 
 #
 # Parallel port support

End of diffs.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Such are a well regulated militia, composed of the freeholders,
citizen and husbandman, who take up arms to preserve their property,
as individuals, and their rights as freemen.
        -- "M.T. Cicero", in a newspaper letter of 1788 touching the "militia" 
            referred to in the Second Amendment to the Constitution.
