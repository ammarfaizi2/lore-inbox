Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268538AbUHYG25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268538AbUHYG25 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 02:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268539AbUHYG25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 02:28:57 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:50067 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S268538AbUHYG2y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 02:28:54 -0400
Message-ID: <412C315D.1000708@hovedpuden.dk>
Date: Wed, 25 Aug 2004 08:27:41 +0200
From: =?ISO-8859-1?Q?John_Damm_S=F8rensen?= <john@hovedpuden.dk>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: /dev/[*]st* does not work with EXBAYTE 8505 with 2.6 kernels
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-yoursite-MailScanner-Information: Please contact the ISP for more information
X-yoursite-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have just upgraded from RH9 Linux 2.4 to FC2 Linux 2.6 and now my
EXABYTE 8505 no longer works.

If I try to access it with mt (using any device like nst0) I get no such
device error message. Same thing with stinit.

The tape drive is found during boot, as this snippet from dmesg shows:
qla1280: QLA12160 found on PCI bus 1, dev 8
ACPI: PCI interrupt 0000:01:08.0[A] -> GSI 11 (level, low) -> IRQ 11
scsi(1): Reading NVRAM
qla1280_isr(): index 1 asynchronous BUS_RESET
qla1280_isr(): index 0 asynchronous BUS_RESET
scsi(1:0): Resetting SCSI BUS
scsi(1:1): Resetting SCSI BUS
scsi1 : QLogic QLA12160 PCI to SCSI Host Adapter
        Firmware version: 10.04.32, Driver version 3.24.3
   Vendor: EXABYTE   Model: EXB-85058SQANXR0  Rev: 0808
   Type:   Sequential-Access                  ANSI SCSI revision: 02
scsi(1:0:4:0): Sync: period 50, offset 14

cat of /proc/scsi/scsi also shows the tape device:
Attached devices:
Host: scsi0 Channel: 00 Id: 02 Lun: 00
   Vendor: COMPAQ   Model: ST34371W         Rev: 0682
   Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
   Vendor: SEAGATE  Model: ST39103LW        Rev: 0002
   Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 04 Lun: 00
   Vendor: EXABYTE  Model: EXB-85058SQANXR0 Rev: 0808
   Type:   Sequential-Access                ANSI SCSI revision: 02

lsmod seems to contain the necessary driver modules as well:

Module                  Size  Used by
st                     30429  0
qlogicfas408            6473  0
parport_pc             21249  1
lp                      9133  0
parport                35977  2 parport_pc,lp
md5                     3905  1
ipv6                  217349  16
autofs4                20677  0
sunrpc                141861  1
iptable_filter          2369  0
ip_tables              13889  1 iptable_filter
3c59x                  33385  0
dm_mod                 47317  0
button                  4825  0
battery                 7117  0
asus_acpi               9177  0
ac                      3533  0
ext3                   96937  4
jbd                    66521  1 ext3
qla1280                81997  0
sd_mod                 17473  5
scsi_mod              105360  3 st,qla1280,sd_mod

Any hints?
Please don't tell me that the 8505 is no longer supported.

Cheers
John



