Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161009AbWIETyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161009AbWIETyv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 15:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbWIETyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 15:54:51 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:1230 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1030235AbWIETyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 15:54:50 -0400
From: =?utf-8?q?=C4=B0smail_D=C3=B6nmez?= <ismail@pardus.org.tr>
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK/UEKAE?=
To: linux-atm-general@lists.sourceforge.net
Subject: [PATCH] Move linux/device.h include in linux/atmdev.h to #ifdef __KERNEL__ section
Date: Tue, 5 Sep 2006 22:55:09 +0300
User-Agent: KMail/1.9.4
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_eYd/Ec7qAhl/A47"
Message-Id: <200609052255.10004.ismail@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_eYd/Ec7qAhl/A47
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

linux/device.h header is not included in the David Woodhouse's kernel-heade=
rs=20
git tree which is used for userspace kernel headers. Which results in compi=
le=20
errors when building iproute2. Attached patch moves linux/device.h include=
=20
under the #ifdef __KERNEL__ section. Compile tested on x86. Patch is agains=
t=20
Linus' 2.6 git tree.

Signed-off-by: =C4=B0smail D=C3=B6nmez <ismail@pardus.org.tr>


Regards,
ismail

=2D-=20
=E3=82=A2=E3=83=8B=E3=83=A1=E3=81=AF=E6=9C=AC=E5=BD=93=E3=81=AB=E3=81=99=E3=
=81=94=E3=81=84=E3=81=99=E3=81=8E=E3=82=8B=E3=82=88 !

--Boundary-00=_eYd/Ec7qAhl/A47
Content-Type: text/x-diff;
  charset="utf-8";
  name="device-header.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="device-header.patch"

diff --git a/include/linux/atmdev.h b/include/linux/atmdev.h
index 41788a3..2096e5c 100644
--- a/include/linux/atmdev.h
+++ b/include/linux/atmdev.h
@@ -7,7 +7,6 @@ #ifndef LINUX_ATMDEV_H
 #define LINUX_ATMDEV_H
 
 
-#include <linux/device.h>
 #include <linux/atmapi.h>
 #include <linux/atm.h>
 #include <linux/atmioc.h>
@@ -210,6 +209,7 @@ #define ATM_VF2TXT_MAP \
 
 #ifdef __KERNEL__
 
+#include <linux/device.h>
 #include <linux/wait.h> /* wait_queue_head_t */
 #include <linux/time.h> /* struct timeval */
 #include <linux/net.h>

--Boundary-00=_eYd/Ec7qAhl/A47--
