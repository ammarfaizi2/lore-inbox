Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbUCEO1e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 09:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbUCEO1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 09:27:34 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:33195 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262608AbUCEO10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 09:27:26 -0500
Date: Fri, 5 Mar 2004 15:27:25 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: linux-kernel@vger.kernel.org
Cc: David Mosberger <davidm@napali.hpl.hp.com>, "H. J. Lu" <hjl@lucon.org>,
       "Luck, Tony" <tony.luck@intel.com>
Subject: binutils 2.15.90.0.1 break ia64 kernel crosscompiling
Message-ID: <20040305142725.GA20926@MAIL.13thfloor.at>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	David Mosberger <davidm@napali.hpl.hp.com>,
	"H. J. Lu" <hjl@lucon.org>, "Luck, Tony" <tony.luck@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Folks!

upgraded my Cross Compiling Toolchain[1] to binutils 2.15.90.0.1, 
recompiled gcc 3.3.3 (just to make sure), and now linux 2.6.3
doesn't compile for ia64 anymore ...

here is th funny part of the complete error log[2]

------------------------------------------------------------------
  {standard input}: Assembler messages:
  {standard input}:1268: Internal error!
  Assertion failure in md_assemble at config/tc-ia64.c line 10013.
  Please report this bug.
------------------------------------------------------------------

so we are now down from 6 to 5 of 20 archs which compile 2.6.3
with default config, will soon try with 2.6.4-rc*

                    linux-2.6.3                 linux-2.4.25
                    config  build       config  dep     kernel  modules
                    
alpha/alpha:        OK      OK          OK      OK      OK      OK
arm/arm:            FAILED  FAILED      OK      OK      FAILED  FAILED
cris/cris:          FAILED  FAILED      OK      FAILED  FAILED  FAILED
hppa/parisc:        OK      FAILED      OK      OK      FAILED  FAILED
hppa64/parisc:      OK      FAILED      OK      OK      FAILED  FAILED
i386/i386:          OK      OK          OK      OK      OK      OK
ia64/ia64:          OK      FAILED      OK      OK      FAILED  FAILED
m68k/m68k:          OK      FAILED      OK      OK      OK      OK
mips/mips:          OK      FAILED      OK      OK      FAILED  FAILED
mips64/mips:        OK      FAILED      OK      OK      FAILED  FAILED
ppc/ppc:            OK      FAILED      OK      OK      OK      OK
ppc64/ppc64:        OK      OK          OK      FAILED  FAILED  OK
s390/s390:          OK      FAILED      OK      OK      FAILED  FAILED
s390x/s390:         OK      FAILED      OK      OK      OK      OK
sh/sh:              OK      FAILED      OK      FAILED  FAILED
sh64/sh:            OK      FAILED      OK      OK      FAILED  FAILED
sparc/sparc:        OK      FAILED      OK      OK      FAILED  FAILED
sparc64/sparc64:    OK      OK          OK      OK      OK      OK
v850/v850:          FAILED  FAILED      FAILED  FAILED  FAILED  FAILED
x86_64/x86_64:      OK      OK          OK      OK      OK      OK


best,
Herbert

[1] http://vserver.13thfloor.at/Stuff/Cross/
[2] http://vserver.13thfloor.at/Stuff/Cross/LOGS-2.6.3-gcc3.3.3-binutils2.15.90.0.1/ia64-build.err

