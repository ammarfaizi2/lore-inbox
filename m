Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269509AbTGXRLA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 13:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269510AbTGXRLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 13:11:00 -0400
Received: from dhcp065-024-128-253.columbus.rr.com ([65.24.128.253]:38528 "EHLO
	doug.hunley.homeip.net") by vger.kernel.org with ESMTP
	id S269509AbTGXRK6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 13:10:58 -0400
From: Douglas J Hunley <doug@hunley.homeip.net>
Organization: Linux StepByStep
To: linux-kernel@vger.kernel.org
Subject: 2.6.0: Badness in pci_find_subsys!!
Date: Thu, 24 Jul 2003 13:26:01 -0400
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307241326.04656.doug@hunley.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Just had my athlon box lock-up solid. needed SysRq to reboot the thing.. 
kernel info follows:
Jul 24 13:08:23 doug kernel: Badness in pci_find_subsys at 
drivers/pci/search.c:132
Jul 24 13:08:23 doug kernel: Call Trace:
Jul 24 13:08:23 doug kernel:  [<c02064a1>] pci_find_subsys+0x111/0x120
Jul 24 13:08:23 doug kernel:  [<c02064df>] pci_find_device+0x2f/0x40
Jul 24 13:08:23 doug kernel:  [<c0206368>] pci_find_slot+0x28/0x50
Jul 24 13:08:23 doug kernel:  [<f8a2ada4>] os_pci_init_handle+0x3a/0x67 
[nvidia]
Jul 24 13:08:23 doug kernel:  [<f8a3cedf>] __nvsym00015+0x1f/0x24 [nvidia]
Jul 24 13:08:23 doug kernel:  [<f8b3ea56>] __nvsym04619+0xf6/0x164 [nvidia]
Jul 24 13:08:23 doug kernel:  [<f8b3e82a>] __nvsym00717+0x21a/0x224 [nvidia]
Jul 24 13:08:23 doug kernel:  [<f8adc8b4>] __nvsym03735+0x60/0x88 [nvidia]
Jul 24 13:08:23 doug kernel:  [<f8adc465>] __nvsym00553+0x67d/0x944 [nvidia]
Jul 24 13:08:23 doug kernel:  [<c015ca2b>] do_sync_read+0x8b/0xc0
Jul 24 13:08:23 doug kernel:  [<c011d87a>] __wake_up_common+0x3a/0x60
Jul 24 13:08:23 doug kernel:  [<f8b0691a>] __nvsym00630+0x9a/0x17c [nvidia]
Jul 24 13:08:23 doug kernel:  [<f8a3f399>] __nvsym00746+0xd/0x1c [nvidia]
Jul 24 13:08:23 doug kernel:  [<f8a3ffe0>] rm_isr_bh+0xc/0x10 [nvidia]
Jul 24 13:08:23 doug kernel:  [<c01266a2>] tasklet_action+0x72/0xc0
Jul 24 13:08:23 doug kernel:  [<c01263d3>] do_softirq+0xd3/0xe0
Jul 24 13:08:23 doug kernel:  [<c010bd18>] do_IRQ+0x148/0x1a0
Jul 24 13:08:23 doug kernel:  [<c0109dd8>] common_interrupt+0x18/0x20
Jul 24 13:08:23 doug kernel:

- -- 
Douglas J Hunley (doug at hunley.homeip.net) - Linux User #174778
http://doug.hunley.homeip.net && http://www.linux-sxs.org

Ahhh...I see the screw-up fairy has visited us again...
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/IBap2MO5UukaubkRArpmAKCMwD4E3SQ0mUXWKwor4qby0unejwCeNAkk
X4sGiKj7rCD9n/7yYfrQy6Y=
=DzuB
-----END PGP SIGNATURE-----

