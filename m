Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267610AbUH2Cvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267610AbUH2Cvk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 22:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267618AbUH2Cvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 22:51:40 -0400
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:48559 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267610AbUH2Cvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 22:51:36 -0400
Message-ID: <413144B3.4080301@triplehelix.org>
Date: Sat, 28 Aug 2004 19:51:31 -0700
From: Joshua Kwan <joshk@triplehelix.org>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040819)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [gmulas@ca.astro.it: kernel-source-2.4.27: libata.o not compiled
 as module]
References: <20040829021638.GA29207@darjeeling.triplehelix.org> <41313FDA.6080009@pobox.com>
In-Reply-To: <41313FDA.6080009@pobox.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEA328E2062C6CAAFADA7B326"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEA328E2062C6CAAFADA7B326
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:
> Everything is working just fine, from looking at the output.

Just fine?

depmod: *** Unresolved symbols in
/usr/src/kernel-source-2.4.27/debian/tmp-image/lib/modules/2.4.27/kernel/drivers/scsi/sata_sx4.o
depmod:         ata_add_to_probe_list_Rsmp_c4708b60
depmod:         ata_port_probe_Rsmp_f8f01db6
depmod:         ata_std_bios_param_Rsmp_8021f007
depmod:         ata_check_status_mmio_Rsmp_2dc27824
depmod:         ata_port_start_Rsmp_4afd23de
depmod:         ata_scsi_error_Rsmp_4db27aa3
depmod:         ata_tf_load_mmio_Rsmp_5d4089a1
depmod:         ata_scsi_queuecmd_Rsmp_61a16164
depmod:         ata_bus_reset_Rsmp_48b3c601
depmod:         ata_port_disable_Rsmp_cf3f6248
depmod:         ata_qc_complete_Rsmp_27e6abc6
depmod:         ata_scsi_release_Rsmp_bc1c53b1
depmod:         ata_scsi_detect_Rsmp_79dc600b
depmod:         ata_exec_command_mmio_Rsmp_7b0a5b2d
depmod:         ata_tf_read_mmio_Rsmp_830b4f4e
depmod:         ata_pci_remove_one_Rsmp_6c0a4dd5
depmod:         ata_port_stop_Rsmp_301e7c1e

> CONFIG_SCSI_SATA_VITESSE is set to 'y', which means that libata is built 
> into the kernel rather than as a module, because 
> CONFIG_SCSI_SATA_VITESSE is built into the kernel, and libata is a 
> dependency.

But as my own compile tests showed, neither sata_vsc.c or libata-core.c 
/ libata-scsi.c were ever compiled into sata_vsc.o and libata.o (for use 
at kernel link time) during a 'make bzImage modules'.

> Because the dependency (libata.o) is built into the kernel, no kernel 
> module will be produced.

Makes sense. But it doesn't seem to work that way in practice.

Run a kbuild using that .config and you'll probably see the problem too..

-- 
Joshua Kwan

--------------enigEA328E2062C6CAAFADA7B326
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQTFEtqOILr94RG8mAQL46A//fAQOAJJGFIhyZkQBj8r0TIUs3a+BkD/A
GhmiprJnlYejVBCDCRLLuSnshJW2RNHUFhkxvlZJfkE1KfffpXDHnm71lre8n0uT
kRT+hMTbkqgO4F6IQkO7Odzyn7tAif8yW6iZIBBNgGahGQYPI29KmU2JpSRqKn7S
Wt3dVRDLdFI2WxweabETP8S7ptZhBb8+W1v17TSypjISz2L1GpbxPNLgzqjYZ3yb
DfzzXm3Vz6gzL9fSIWPf5fNOcmvk40/2dVmrbOUDUdkh9JIdhuUu0JIoEvO9KY6d
0saJdZad5vWQW48B+SzUJh+lrGKcBadtKx+T1pklL5F2BeoSfL1FU9gZ9GO1Atqi
MDgeSOWagyEWT3KV+uJXtcIt0r8qOmdcxuXBQHmEkF/7MWyNtX3O+s59wXA/w1xu
pyc0Vq9iXLyEuxEBw9t+3GgoYPoNWYcmMAZkQG78RkyTIjfe5zesJi2AKxv+41gJ
hhzfN0HoHjGXcS3NNTlxrAy4qJ4UnNsVxv6wYBNSz1ps2R/AtXxT6w94ZQKNLQ83
nKTcqe8yY6jtAHtCajeUcpB7WN1m6x9Gor/7eHwSFgqzTMgGYujs24QZD22nnA6X
A7H/RkgpSgJymgh+xkvmUSbSsHuyTWbrRss4qP35Pk3jaGozQuRENzL7Lll0ULrM
z52ThZ9n0U4=
=BOCQ
-----END PGP SIGNATURE-----

--------------enigEA328E2062C6CAAFADA7B326--
