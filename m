Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264280AbTLBTfc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 14:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264327AbTLBTfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 14:35:32 -0500
Received: from scrye.com ([216.17.180.1]:28889 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S264280AbTLBTfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 14:35:24 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Tue, 2 Dec 2003 12:35:17 -0700
From: Kevin Fenzi <kevin@tummy.com>
To: linux-kernel@vger.kernel.org, linux-aacraid-devel@dell.com
Subject: aacraid and large memory problem (2.6.0-test11)
X-Mailer: VM 7.17 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Message-Id: <20031202193520.74481F7CC8@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Greetings, 

Booting 2.6.0-test11 on a machine with 8GB memory and using the
aacraid driver results in a hang on boot. Passing mem=2048M causes it
to boot normally. 4GB also hangs. 2.6.0-test8 booted normally on this
same hardware. 

8GB memory, dual xeon 3.06mhz with hyperthreading, RedHat 9 on it
currently. 

Happy to provide details on setup/software, etc. 

Perhaps this patch in 2.6.0-test9 is the culprit?
http://www.linuxhq.com/kernel/v2.6/0-test9/drivers/scsi/aacraid/comminit.c

On normal boot: 

SCSI subsystem initialized
Red Hat/Adaptec aacraid driver (1.1.2 Nov 26 2003)
AAC0: kernel 4.0.4 build 6008
AAC0: monitor 4.0.4 build 6008
AAC0: bios 4.0.0 build 6008
AAC0: serial b7e06ffafaf001
AAC0: 64 Bit PAE enabled
scsi0 : aacraid
  Vendor: ADAPTEC   Model: Adaptec RAID5     Rev: V1.0
  Type:   Direct-Access                      ANSI SCSI revision: 02

On the hangs: 

SCSI subsystem initialized
Loading sd_mod.ko module
Loading aacraid.ko module
Red Hat/Adaptec aacraid driver (1.1.2 Nov 26 2003)
aacraid:        NMI ISR: NMI_BUS_INTERFACE_UNIT_ERROR
aacraid: <...repeats 7 more times>
aacraid: NormPrioCommand was received with Fib StructType = 0xff
<hangs>

Thanks for any ideas. 

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD4DBQE/zOl43imCezTjY0ERAsH1AKCQ/xzLEEysLF+ewdEKXr5AGWplrgCWOs8f
rXbYWCZSyPGSGrKQEq6z6w==
=xAVH
-----END PGP SIGNATURE-----
