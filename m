Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264198AbTFYIsa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 04:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264219AbTFYIsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 04:48:30 -0400
Received: from ns.tasking.nl ([195.193.207.2]:30476 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S264198AbTFYIs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 04:48:29 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.5.73 - build fails for aic7xxx
Organization: Altium SOFTWARE B.V.
X-Face: "A(HPX!owGRCdtOX\NKs=ac*&x%/sYJMc;M<L&"^kH9ogp5;"w#UVc0yt3K{@n#.E+=k>qd bqZYYQvB9_xdS1l+B2\z;:p71RNxrja;ir>Dj?6%GzFA!o>gOL&G}8X;icnhqP|=TU,O@JVM%5LL:X ,G&IkRk9n%h7hZFUltu%RB=ctrdfu?[vSRV%Wzcn;#o>[K0C6_'q*~^+toc))w-Qb8*,afMHVCrNG6
X-Attribution: KB
Reply-To: kees.bakker@altium.nl (Kees Bakker)
From: kees.bakker@altium.nl (Kees Bakker)
Date: 25 Jun 2003 11:01:02 +0200
Message-ID: <si65mupm41.fsf@koli.tasking.nl>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.96
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get a strange build error in aic7xxx. I don't see a compile error, but my
make stops with an error.

Starting from scratch with a 'make oldconfig'.

...
  Adaptec AIC7xxx Fast -> U160 support (New Driver) (SCSI_AIC7XXX) [M/n/y/?] m
    Maximum number of TCQ commands per device (AIC7XXX_CMDS_PER_DEVICE) [253] 253
    Initial bus reset delay in milli-seconds (AIC7XXX_RESET_DELAY_MS) [15000] 15000
    Probe for EISA and VL AIC7XXX Adapters (AIC7XXX_PROBE_EISA_VL) [N/y/?] n
    Build Adapter Firmware with Kernel Build (AIC7XXX_BUILD_FIRMWARE) [N/y/?] n
    Compile in Debugging Code (AIC7XXX_DEBUG_ENABLE) [Y/n/?] y
    Debug code enable mask (2047 for all debugging) (AIC7XXX_DEBUG_MASK) [0] 0
    Decode registers during diagnostics (AIC7XXX_REG_PRETTY_PRINT) [Y/n/?] y
  Adaptec AIC7xxx support (old driver) (SCSI_AIC7XXX_OLD) [N/m/y/?] n

...
  SHIPPED drivers/scsi/aic7xxx/aic7xxx_seq.h
  SHIPPED drivers/scsi/aic7xxx/aic7xxx_reg.h
  CC [M]  drivers/scsi/aic7xxx/aic7xxx_core.o
In file included from drivers/scsi/aic7xxx/aic7xxx_osm.h:89,
                 from drivers/scsi/aic7xxx/aic7xxx_core.c:46:
drivers/scsi/hosts.h: In function `scsi_find_device':
drivers/scsi/hosts.h:64: warning: comparison between signed and unsigned
drivers/scsi/hosts.h:65: warning: comparison between signed and unsigned
drivers/scsi/hosts.h:65: warning: comparison between signed and unsigned
drivers/scsi/aic7xxx/aic7xxx_core.c: In function `ahc_handle_brkadrint':
drivers/scsi/aic7xxx/aic7xxx_core.c:384: warning: comparison between signed and unsigned
drivers/scsi/aic7xxx/aic7xxx_core.c: In function `ahc_print_scb':
drivers/scsi/aic7xxx/aic7xxx_core.c:1524: warning: comparison between signed and unsigned
drivers/scsi/aic7xxx/aic7xxx_core.c:1532: warning: comparison between signed and unsigned
drivers/scsi/aic7xxx/aic7xxx_core.c: In function `ahc_handle_devreset':
drivers/scsi/aic7xxx/aic7xxx_core.c:3759: warning: comparison between signed and unsigned
drivers/scsi/aic7xxx/aic7xxx_core.c: In function `ahc_init':
drivers/scsi/aic7xxx/aic7xxx_core.c:4957: warning: comparison between signed and unsigned
drivers/scsi/aic7xxx/aic7xxx_core.c: In function `ahc_match_scb':
drivers/scsi/aic7xxx/aic7xxx_core.c:5226: warning: comparison between signed and unsigned
drivers/scsi/aic7xxx/aic7xxx_core.c:5228: warning: comparison between signed and unsigned
drivers/scsi/aic7xxx/aic7xxx_core.c: In function `ahc_search_untagged_queues':
drivers/scsi/aic7xxx/aic7xxx_core.c:5554: warning: comparison between signed and unsigned
drivers/scsi/aic7xxx/aic7xxx_core.c: In function `ahc_abort_scbs':
drivers/scsi/aic7xxx/aic7xxx_core.c:5823: warning: comparison between signed and unsigned
drivers/scsi/aic7xxx/aic7xxx_core.c:5830: warning: comparison between signed and unsigned
drivers/scsi/aic7xxx/aic7xxx_core.c: In function `ahc_loadseq':
drivers/scsi/aic7xxx/aic7xxx_core.c:6363: warning: comparison between signed and unsigned
drivers/scsi/aic7xxx/aic7xxx_core.c:6379: warning: comparison between signed and unsigned
drivers/scsi/aic7xxx/aic7xxx_core.c: In function `ahc_print_register':
drivers/scsi/aic7xxx/aic7xxx_core.c:6603: warning: comparison between signed and unsigned
drivers/scsi/aic7xxx/aic7xxx_core.c:6617: warning: comparison between signed and unsigned
drivers/scsi/aic7xxx/aic7xxx_inline.h: At top level:
drivers/scsi/aic7xxx/aic7xxx_core.c:76: warning: `num_chip_names' defined but not used
make[3]: *** [drivers/scsi/aic7xxx/aic7xxx_core.o] Error 1
make[2]: *** [drivers/scsi/aic7xxx] Error 2
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

I'm fairly sure it is not the last CC that causes the make to stop. If I
run gcc by hand it completes with exit 0. However, if I run make again, it
does the CC again. Huh? What can it be?

How can I see the whole gcc command?
--

