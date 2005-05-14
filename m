Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262712AbVENKCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbVENKCS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 06:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVENKBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 06:01:38 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:7348 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262712AbVENJeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 05:34:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=lsxS1r94rDqohLV/6rP/x0fnkLI3fWuMfoUJbm/WnvxKJet06XuxIVjsPA/W1W3xP8hZpiUjlLw+QklBV88GLLk5tYIO0GTtOeWfOyHdiHAl8/3YUDABRiCgCD2DiNY8gvHB20RLerkcPNoFS/BfJ2V3uk25lvoxGEad9VzsvmU=
Message-ID: <2538186705051402346e9a6a85@mail.gmail.com>
Date: Sat, 14 May 2005 05:34:14 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12-rc4 12/12] include: (dynamic sysfs callbacks) update device attribute callbacks
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1455_22384685.1116063254826"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1455_22384685.1116063254826
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

---

------=_Part_1455_22384685.1116063254826
Content-Type: text/plain; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-include.diff.diffstat.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-include.diff.diffstat.txt"

 ocp.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)



------=_Part_1455_22384685.1116063254826
Content-Type: text/x-patch; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-include.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-include.diff"

diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/include/asm-ppc/ocp.h linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/include/asm-ppc/ocp.h
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/include/asm-ppc/ocp.h	2005-05-11 00:28:15.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/include/asm-ppc/ocp.h	2005-05-11 00:35:02.000000000 -0400
@@ -189,7 +189,7 @@ extern void ocp_for_each_device(void(*ca
 /* Sysfs support */
 #define OCP_SYSFS_ADDTL(type, format, name, field)			\
 static ssize_t								\
-show_##name##_##field(struct device *dev, char *buf)			\
+show_##name##_##field(struct device *dev, char *buf, void *private)			\
 {									\
 	struct ocp_device *odev = to_ocp_dev(dev);			\
 	type *add = odev->def->additions;				\

------=_Part_1455_22384685.1116063254826--
