Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbUKPOwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbUKPOwf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 09:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbUKPOwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 09:52:35 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:23221 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261994AbUKPOwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 09:52:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=gGLfpgZ2OBM1hLka4NaBTgzyc5bpu2nNNDr3+H+dFN7BIh5XtjP3iMSh5CMiGPBAd5jUCaisSHtI2r69oFWjn97710Zn4kN2R0tI8HfSI782l3dnN5mww9w/ZdupiBLTAg4tPsU7se6DS23eIfn1iDGuAtdyUaRnywyi+rZv3zk=
Message-ID: <aec7e5c3041116065211fe01c2@mail.gmail.com>
Date: Tue, 16 Nov 2004 15:52:32 +0100
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ide=nodma printout fix
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_323_16392777.1100616752290"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_323_16392777.1100616752290
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This simple patch changes the output from this:
..
ide_setup: ide=nodmaIDE: Prevented DMA
..
to this:
..
ide_setup: ide=nodma : Prevented DMA
..

/ magnus

------=_Part_323_16392777.1100616752290
Content-Type: text/x-patch; name="linux-2.6.10-rc2-ide_nodma.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="linux-2.6.10-rc2-ide_nodma.patch"

--- linux-2.6.10-rc2/drivers/ide/ide.c=092004-11-14 18:34:12.000000000 +010=
0
+++ linux-2.6.10-rc2-ide_nodma/drivers/ide/ide.c=092004-11-16 15:31:35.2963=
94376 +0100
@@ -1846,7 +1846,7 @@
 #endif /* CONFIG_BLK_DEV_IDEDOUBLER */
=20
 =09if (!strcmp(s, "ide=3Dnodma")) {
-=09=09printk("IDE: Prevented DMA\n");
+=09=09printk(" : Prevented DMA\n");
 =09=09noautodma =3D 1;
 =09=09return 1;
 =09}

------=_Part_323_16392777.1100616752290--
