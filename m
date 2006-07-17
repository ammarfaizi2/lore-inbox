Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWGQHIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWGQHIo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 03:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWGQHIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 03:08:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:15463 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932299AbWGQHIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 03:08:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Tr3+Nrw8Qdl0cTQJXCqUES1qg7x3eYScBkZeQaonKLQxhOD66uy9LGaF3Pq1DebZk3eI9trpBDjAkwWecuSadfrX3gEgSjypuW1Z1mhs+W2tpdlIR73GuapVCoZK44csyRWggKgoSQBy/AbrOc2rz8W2Mur88CEnTOM2qUWR3zI=
Message-ID: <fbe022af0607170008w5efb489fjd3df63f1795805c2@mail.gmail.com>
Date: Mon, 17 Jul 2006 00:08:41 -0700
From: "Vikas Kedia" <kedia.vikas@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: kernel panic at load average of 24 is it acceptable ?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I gave the following command:
$stress --cpu 12 --io 10 --vm 10 --vm-bytes 128M --timeout 100000s --verbose

and then my top shows:
top - 01:23:10 up 3:13, 3 users, load average: 24.29, 24.32, 24.50

and then the system gave a kernel panic.

Here are some of the entries in the log files:
dmesg
[ 0.000000] ACPI: Unable to locate RSDP
[ 0.000000] Virtual Wire compatibility mode.
[ 0.000000] OEM ID: TYAN <6>Product ID: S2881 <6>APIC at: 0xFEE00000
[ 0.000000] Processor #0 15:5 APIC version 16
[ 0.000000] I/O APIC #1 Version 17 at 0xFEC00000.
[ 0.000000] I/O APIC #2 Version 17 at 0xFEBFF000.
[ 0.000000] I/O APIC #3 Version 17 at 0xFEBFE000.
[ 33.869489] Using IO-APIC 1
[ 33.869495] Using IO-APIC 2
[ 33.869497] Using IO-APIC 3
[ 34.120904] ACPI: Subsystem revision 20051216
[ 34.120906] ACPI: Interpreter disabled.
[ 34.123482] PCI: MSI quirk detected. pci_msi_quirk set.
[ 34.123486] PCI: MSI quirk detected. pci_msi_quirk set.



/var/log/messages
Jul 16 17:02:36 srv1 kernel: [ 2435.535458] Machine check events logged
Jul 16 17:07:36 srv1 kernel: [ 2735.003362] Machine check events logged
Jul 16 17:12:36 srv1 kernel: [ 3034.461297] Machine check events logged
Jul 16 17:17:36 srv1 kernel: [ 3333.929201] Machine check events logged
Jul 16 17:22:36 srv1 kernel: [ 3633.397107] Machine check events logged
Jul 16 17:27:36 srv1 kernel: [ 3932.875013] Machine check events logged
Jul 16 17:32:36 srv1 kernel: [ 4232.352889] Machine check events logged
Jul 16 17:37:36 srv1 kernel: [ 4531.820809] Machine check events logged
Jul 16 17:42:36 srv1 kernel: [ 4831.288708] Machine check events logged
Jul 16 17:47:36 srv1 kernel: [ 5130.756612] Machine check events logged
Jul 16 17:52:36 srv1 kernel: [ 5430.224522] Machine check events logged
Jul 16 17:57:36 srv1 kernel: [ 5729.692441] Machine check events logged
Jul 16 19:10:05 srv1 kernel: [ 34.995486] PCI: MSI quirk detected.
pci_msi_quirk set.
Jul 16 19:10:05 srv1 kernel: [ 34.995489] PCI: MSI quirk detected.
pci_msi_quirk set.

The screen shot of the console (through the KVM) is available here:
http://www.visitlab.com/styles/basic/images/ubuntu-error1.JPG
http://www.visitlab.com/styles/basic/images/ubuntu-error2.JPG

The memtest ran fine for 8 hours:
http://www.visitlab.com/styles/basic/images/memtest.JPG

My questions are:
1. Kernel panic at load average of 24 is it acceptable ?
2. If not how do I go about debugging this kernel panic ?

Regards,

v
