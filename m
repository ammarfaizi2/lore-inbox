Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUJHSru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUJHSru (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 14:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbUJHSpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 14:45:24 -0400
Received: from village.ehouse.ru ([193.111.92.18]:20494 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S261426AbUJHSgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 14:36:36 -0400
From: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
To: "Mukker, Atul" <Atulm@lsil.com>
Subject: Re: Megaraid random loss of luns
Date: Fri, 8 Oct 2004 22:36:30 +0400
User-Agent: KMail/1.7
Cc: comsatcat@earthlink.net, linux-kernel@vger.kernel.org
References: <0E3FA95632D6D047BA649F95DAB60E57033BCADD@exa-atlanta>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57033BCADD@exa-atlanta>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_u4tZBeIZCbjgDv8"
Message-Id: <200410082236.30485.rathamahata@ehouse.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_u4tZBeIZCbjgDv8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 08 October 2004 20:30, Mukker, Atul wrote:
> You can try to add the PCI ids for your controllers in megaraid_mbox.c
> pci_device_id table. That _should_ work

That solve unrecognized controller issue. Thank you!
And here is a patch, please consider applying.


-- 
Sergey S. Kostyliov <rathamahata@ehouse.ru>
Jabber ID: rathamahata@jabber.org

--Boundary-00=_u4tZBeIZCbjgDv8
Content-Type: text/plain;
  charset="iso-8859-1";
  name="ami_megaraid_series_475_pci_id.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="ami_megaraid_series_475_pci_id.patch"

===== drivers/scsi/megaraid/megaraid_mbox.c 1.4 vs edited =====
--- 1.4/drivers/scsi/megaraid/megaraid_mbox.c	2004-08-31 22:52:04 +04:00
+++ edited/drivers/scsi/megaraid/megaraid_mbox.c	2004-10-08 21:54:44 +04:00
@@ -295,6 +295,12 @@
 		PCI_SUBSYS_ID_PERC3_SC,
 	},
 	{
+		PCI_VENDOR_ID_AMI,
+		PCI_DEVICE_ID_AMI_MEGARAID3,
+		PCI_VENDOR_ID_AMI,
+		PCI_SUBSYS_ID_PERC3_SC,
+	},
+	{
 		PCI_VENDOR_ID_LSI_LOGIC,
 		PCI_DEVICE_ID_MEGARAID_SCSI_320_0,
 		PCI_VENDOR_ID_LSI_LOGIC,

--Boundary-00=_u4tZBeIZCbjgDv8--
