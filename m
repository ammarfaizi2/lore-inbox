Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268189AbUIWRvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268189AbUIWRvw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 13:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268107AbUIWRtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 13:49:14 -0400
Received: from mail1.kontent.de ([81.88.34.36]:54218 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S266352AbUIWRrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 13:47:23 -0400
From: Oliver Neukum <oliver@neukum.org>
To: linux-kernel@vger.kernel.org
Subject: security issue in firmware system
Date: Thu, 23 Sep 2004 19:47:08 +0200
User-Agent: KMail/1.6.2
Cc: Manuel Estrada Sainz <ranty@debian.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409231947.08754.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

IMHO writing firmware into a device should need CAP_SYS_RAWIO,
as it affects the meaning of all following operations on that device.

	Regards
		Oliver

Signed-Off-By: Oliver Neukum <oliver@neukum.name>

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1948, 2004-09-23 17:40:42+02:00, oliver@oenone.homelinux.org
  - require CAP_SYS_RAWIO to change firmware


 firmware_class.c |    2 ++
 1 files changed, 2 insertions(+)


diff -Nru a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
--- a/drivers/base/firmware_class.c	Thu Sep 23 18:57:32 2004
+++ b/drivers/base/firmware_class.c	Thu Sep 23 18:57:32 2004
@@ -235,6 +235,8 @@
 	struct firmware *fw;
 	ssize_t retval;
 
+	if (!capable(CAP_SYS_RAWIO))
+		return -EPERM;
 	down(&fw_lock);
 	fw = fw_priv->fw;
 	if (test_bit(FW_STATUS_DONE, &fw_priv->status)) {

===================================================================


This BitKeeper patch contains the following changesets:
1.1948
## Wrapped with gzip_uu ##


M'XL( 'P 4T$  \V4;6O;,!2%/T>_0J-?6DIL75E^'1G)LK*5;30D*V.4$A3Y
M-C9UK%9RFA7\XR=GM%U@9-W88)8QZ,5'.N<^Z(">6S193U?E'1IR0-]IV[@N
MUKI&K] KK,IZ_=739NDFIUJ[2;\;]G55E=S_9!"MO]'FFD?$K9C(1A742=FL
M!U[P.-+<WV#6FYZ\/?\PFA(R&-!Q(>LESK"A@P%IM+F356Z'LBDJ77N-D;5=
M82,]I5?MX]*6,\9="R$.6!BU$#$1MPIR "D <\9%$@EB="7K?&@P+V33*5P\
MZ%_N:@F6<@ A@A!:@"!,R!L*'J0BH4SX+/5Y0"'.!,L$/V8\8XQ^#VKXLX#H
M,= ^(Z_IWW4S)HKVJ<';=6F0CD>3^>S+;#X=?3X]<SM1M96C5Z59;:1!\IX"
M=[;(Y"EATO_-AQ F&7E%W;F;^V&.BU+6G<.+I<'E99N;+@/K+Z1%_V'CN:JD
MM9[J7 4L@A2B@ =A"V'BOD+E'/-@D2PP5!C)?3G^6K^K6P A%Y"ZNK$8MD3M
M_:VC[-_9(84JAI5MO!Q_8.TY/ECB^$N"N&5Q%+(M?YSMT,=%!NESZ./_!WW;
M>IS1OMEL7T?39']I_@#/4Q[$E)->>44/7RAY(Q<5'NX<[NB(]'H&F[6I:?]D
><C+]^/+I?E(%JFN[7@T4\#2*$T&^ 9"HV\((!0  
