Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281064AbRKVInY>; Thu, 22 Nov 2001 03:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281433AbRKVInO>; Thu, 22 Nov 2001 03:43:14 -0500
Received: from c1473286-a.stcla1.sfba.home.com ([24.176.137.160]:2065 "HELO
	ocean.lucon.org") by vger.kernel.org with SMTP id <S281395AbRKVInF>;
	Thu, 22 Nov 2001 03:43:05 -0500
Date: Thu, 22 Nov 2001 00:43:02 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: linux kernel <linux-kernel@vger.kernel.org>,
        "Torvalds; Linus" <torvalds@transmeta.com>
Subject: PATCH: Discard .exitcall.exit for alpha.
Message-ID: <20011122004302.A2393@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The upcoming binutils will flag relocations against discarded sections
as fatal errors. Here is a patch for the alpha linker script. 


H.J.
----
--- linux/arch/alpha/vmlinux.lds.in.discard	Thu Nov 22 00:30:16 2001
+++ linux/arch/alpha/vmlinux.lds.in	Thu Nov 22 00:30:47 2001
@@ -92,5 +92,5 @@ SECTIONS
   .debug_typenames 0 : { *(.debug_typenames) }
   .debug_varnames  0 : { *(.debug_varnames) }
 
-  /DISCARD/ : { *(.text.exit) *(.data.exit) }
+  /DISCARD/ : { *(.text.exit) *(.data.exit) *(.exitcall.exit) }
 }
