Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbUKPOcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbUKPOcj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 09:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbUKPOaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 09:30:13 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:12384 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261974AbUKPO2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 09:28:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=E3fsta41L5vGvQT37l3Sdw9x8uoDCOCPsXw8KfOZrO7C9w17p0KffSeW/4ofBrsGDE7NYby7pAGWZGniwHf/i3c6flh6Cg7ew+AHhWfLBdtF4iKLPo0JCEnG3u0M5yG8Ar74t7pqD7cfeEjV7YbYPdX+iM5AdrpUGqfKtPDV6z4=
Message-ID: <aec7e5c304111606282acf7f6c@mail.gmail.com>
Date: Tue, 16 Nov 2004 15:28:42 +0100
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] documentation - ide params
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_278_3948993.1100615322419"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_278_3948993.1100615322419
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello again,

This patch removes ide parameters marked as obsolete in the source and
adds documentation for "ide=". I think I got it right, the important
part for me is "ide=nodma".

/ magnus

------=_Part_278_3948993.1100615322419
Content-Type: text/x-patch; name="linux-2.6.10-rc2-ide_params.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="linux-2.6.10-rc2-ide_params.patch"

--- linux-2.6.10-rc2/Documentation/kernel-parameters.txt=092004-11-14 18:35=
:07.000000000 +0100
+++ linux-2.6.10-rc2-ide_params/Documentation/kernel-parameters.txt=092004-=
11-16 15:21:59.014002616 +0100
@@ -504,10 +504,12 @@
 =09icn=3D=09=09[HW,ISDN]
 =09=09=09Format: <io>[,<membase>[,<icn_id>[,<icn_id2>]]]
=20
+=09ide=3D=09=09[HW] (E)IDE subsystem
+=09=09=09Format: ide=3Dnodma or ide=3Ddoubler or ide=3Dreverse
+=09=09=09See Documentation/ide.txt.
+
 =09ide?=3D=09=09[HW] (E)IDE subsystem
-=09=09=09Config (iomem/irq), tuning or debugging
-=09=09=09(serialize,reset,no{dma,tune,probe}) or chipset
-=09=09=09specific parameters.
+=09=09=09Format: ide?=3Dnoprobe or chipset specific parameters.
 =09=09=09See Documentation/ide.txt.
 =09
 =09idebus=3D=09=09[HW] (E)IDE subsystem - VLB/PCI bus speed

------=_Part_278_3948993.1100615322419--
