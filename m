Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbVADTfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbVADTfP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 14:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVADTfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 14:35:13 -0500
Received: from mail242.megamailservers.com ([216.251.41.62]:49045 "EHLO
	mail242.megamailservers.com") by vger.kernel.org with ESMTP
	id S261804AbVADTCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 14:02:35 -0500
X-Authenticated-User: jiri.gaisler.com
Message-ID: <41DAE87B.8030405@gaisler.com>
Date: Tue, 04 Jan 2005 20:03:23 +0100
From: Jiri Gaisler <jiri@gaisler.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: sparclinux@vger.kernel.org
CC: linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: [0/7] LEON SPARC V8 processor support for linux-2.6.10
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a set of patches containing support for the open-source
LEON SPARC V8 processor. The processor was originally developed
for critical space applications by the European Space Agency (ESA),
and is now maintained and further developed by Gaisler Research.
LEON is also frequently being used in (ground-based) commercial
and research application, which lead to the development of the
of the linux-2.6 port.

The patches include support for both the original LEON2 core,
and the newer LEON3. The MMU in both cores is more or less
identical, implementing the V8 SRMMU specification with a
virtual cache. The linux-2.6.x port (as well as a uClinux port)
has been available for some time in a custom version of the
snapgear embedded linux distro. I believe it has matured enough
to be included in the mainstream kernel.

The LEON support is divided on 7 patches:

linux-2.6.10: Kernel patches:
----------------------------------

[1/7] diff2.6.10_include_asm_sparc.diff:  diff for include/asm-sparc
[2/7] diff2.6.10_arch_sparc.diff:         diff for arch/sparc
[3/7] diff2.6.10_drivers_sbus.diff:       diff for drivers/sbus

Leon3 serial+ethermac driver:
-------------------------------------

[4/7] diff2.6.10_driver_amba.diff         diff for drivers/amba
[5/7] diff2.6.10_arch_sparc_Kocnfig.diff  diff for arch/sparc/Kconfig

Leon2 serial+ethermac driver:
-------------------------------------

[6/7] diff2.6.10_driver_net.diff:         diff for drivers/net
[7/7] diff2.6.10_driver_serial.diff:      diff for drivers/serial

I am not sure that the pathes for serial and ethernet drivers
should be sent to the sparclinux list. If not, please advise on
where I should submit them.

More info on LEON is available at www.gaisler.com

Jiri Gaisler.
