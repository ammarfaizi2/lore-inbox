Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbTFXOn5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 10:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbTFXOn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 10:43:57 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:13259 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S262169AbTFXOnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 10:43:55 -0400
Date: Tue, 24 Jun 2003 16:57:53 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: <acpi-devel@lists.sourceforge.net>, "lkml" <linux-kernel@vger.kernel.org>
Subject: Re: ACPI source releases updated (20030619)
Message-Id: <20030624165753.6ae5984c.us15@os.inf.tu-dresden.de>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A2FE@orsmsx401.jf.intel.com>
References: <F760B14C9561B941B89469F59BA3A84725A2FE@orsmsx401.jf.intel.com>
Organization: Fiasco Core Team
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Fiasco-Rulez: Yes
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary=")IexIpwWjBx4,=.1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--)IexIpwWjBx4,=.1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Jun 2003 11:30:49 -0700 Grover, Andrew (GA) wrote:

GA> New Linux 2.4 and 2.5 patches are now available from
GA> http://sf.net/projects/acpi. Big thanks to the asus-acpi team, as well
GA> as all the other people who have been tracking down bugs and submitting
GA> fixes lately.
GA> 19 June 2003.  Summary of changes for version 20030619:

Hi Andrew,

The new ACPI interpreter works much better and seems to mostly solve the
previous problems I had with ACPI on a Dual-Xeon machine with HT, see
http://bugme.osdl.org/show_bug.cgi?id=774

The excessive ACPI interrupts have ceased, but I still get exactly
100000 ACPI interrupts during bootup and then no more. Also the ACPI
interrupt seems to hit the e100 driver unexpectedly.

I've put up the dmesg output of 2.5.73 at the following URL:
http://hell.wh8.tu-dresden.de/dmesg-2.5.73.txt

Regards,
-Udo.

/proc/interrupts

           CPU0       CPU1       CPU2       CPU3       
  0:       5383          0     642910          0    IO-APIC-edge  timer
  2:          0          0          0          0          XT-PIC  cascade
  8:          1          0          0          0    IO-APIC-edge  rtc
  9:     100000          0          0          0   IO-APIC-level  acpi
 14:      11169          0          0          0    IO-APIC-edge  ide0
 16:          0          0          0          0   IO-APIC-level  uhci-hcd
 17:       2020          0          0          0   IO-APIC-level  eth0
NMI:          0          0          0          0 
LOC:     648031     648066     648066     648065 
ERR:          0
MIS:          0

--)IexIpwWjBx4,=.1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.1 (GNU/Linux)

iD8DBQE++GbxnhRzXSM7nSkRArw+AKCC2gbCrm3uskKwVe9hjlp+fMUhkwCfe/Sp
gs+F42QNB671oWabcjxFPew=
=Uhu6
-----END PGP SIGNATURE-----

--)IexIpwWjBx4,=.1--
