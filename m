Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317481AbSFDLyS>; Tue, 4 Jun 2002 07:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317486AbSFDLyR>; Tue, 4 Jun 2002 07:54:17 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:10728 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S317481AbSFDLyQ>; Tue, 4 Jun 2002 07:54:16 -0400
Message-ID: <20020604115412.15774.qmail@linuxmail.org>
Content-Type: multipart/mixed; boundary="----------=_1023191652-14254-0"
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Anthony Spinillo" <tspinillo@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Tue, 04 Jun 2002 19:54:12 +0800
Subject: Test Result #2 INTEL 845G Chipset IDE
X-Originating-Ip: 192.159.104.202
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format...

------------=_1023191652-14254-0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

I tried another small patch that was sent to me
yesterday by JeffN. I applied it on top of 
the recent 2.4.19-pre10. The hunk did not 
match up, so I just entered the line
with 0x24cb in it, into pci-pc.c. I also added
ide0=ata66 ide1=ata66 into my lilo.conf.

DMA worked. Xine played a DVD with no jerkiness.

As stated yesterday, Andre's patch also worked on
2.4.19-pre9ac3. I will eyeball Andre's patch after
work and see if I can get it to work with -pre10.

Thanks for the help!

Tony
patch is attached and also listed below (forgive the line wraps)

--- linux/arch/i386/kernel/pci-pc.c~	Thu May 16 20:37:30 2002
+++ linux/arch/i386/kernel/pci-pc.c	Sat May 25 16:44:58 2002
@@ -1145,6 +1145,7 @@
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5513,		pci_fixup_ide_trash },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SERVERWORKS,	PCI_DEVICE_ID_SERVERWORKS_CSB5IDE,	pci_fixup_ide_trash },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_11,	pci_fixup_ide_trash },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	0x24cb,	pci_fixup_ide_trash },
 	{ PCI_FIXUP_HEADER,	PCI_ANY_ID,		PCI_ANY_ID,			pci_fixup_ide_bases },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5597,		pci_fixup_latency },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5598,		pci_fixup_latency },

-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze

------------=_1023191652-14254-0
Content-Type: application/octet-stream; name="845e.patch"
Content-Disposition: attachment; filename="845e.patch"
Content-Transfer-Encoding: base64

LS0tIGxpbnV4L2FyY2gvaTM4Ni9rZXJuZWwvcGNpLXBjLmN+CVRodSBNYXkg
MTYgMjA6Mzc6MzAgMjAwMg0KKysrIGxpbnV4L2FyY2gvaTM4Ni9rZXJuZWwv
cGNpLXBjLmMJU2F0IE1heSAyNSAxNjo0NDo1OCAyMDAyDQpAQCAtMTE0NSw2
ICsxMTQ1LDcgQEANCiAJeyBQQ0lfRklYVVBfSEVBREVSLAlQQ0lfVkVORE9S
X0lEX1NJLAlQQ0lfREVWSUNFX0lEX1NJXzU1MTMsCQlwY2lfZml4dXBfaWRl
X3RyYXNoIH0sDQogCXsgUENJX0ZJWFVQX0hFQURFUiwJUENJX1ZFTkRPUl9J
RF9TRVJWRVJXT1JLUywJUENJX0RFVklDRV9JRF9TRVJWRVJXT1JLU19DU0I1
SURFLAlwY2lfZml4dXBfaWRlX3RyYXNoIH0sDQogCXsgUENJX0ZJWFVQX0hF
QURFUiwJUENJX1ZFTkRPUl9JRF9JTlRFTCwJUENJX0RFVklDRV9JRF9JTlRF
TF84MjgwMUNBXzExLAlwY2lfZml4dXBfaWRlX3RyYXNoIH0sDQorCXsgUENJ
X0ZJWFVQX0hFQURFUiwJUENJX1ZFTkRPUl9JRF9JTlRFTCwJMHgyNGNiLAlw
Y2lfZml4dXBfaWRlX3RyYXNoIH0sDQogCXsgUENJX0ZJWFVQX0hFQURFUiwJ
UENJX0FOWV9JRCwJCVBDSV9BTllfSUQsCQkJcGNpX2ZpeHVwX2lkZV9iYXNl
cyB9LA0KIAl7IFBDSV9GSVhVUF9IRUFERVIsCVBDSV9WRU5ET1JfSURfU0ks
CVBDSV9ERVZJQ0VfSURfU0lfNTU5NywJCXBjaV9maXh1cF9sYXRlbmN5IH0s
DQogCXsgUENJX0ZJWFVQX0hFQURFUiwJUENJX1ZFTkRPUl9JRF9TSSwJUENJ
X0RFVklDRV9JRF9TSV81NTk4LAkJcGNpX2ZpeHVwX2xhdGVuY3kgfSwNCg==

------------=_1023191652-14254-0--
