Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264105AbTDOWQF (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 18:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264127AbTDOWQF 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 18:16:05 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:10467 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264105AbTDOWQE 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 18:16:04 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] 2.4.21-pre7: Summit family (EXA) ID strings
Date: Tue, 15 Apr 2003 15:27:39 -0700
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_32PER8SALB74UUYFRDGU"
Message-Id: <200304151527.39840.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_32PER8SALB74UUYFRDGU
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

All future IBM Summit boxes are supposed to have their Product ID strings=
=20
start with "EXA", including the forthcoming x445.


--- 2.4.21-pre7/include/asm-i386/smpboot.h.df=09Tue Apr 15 15:15:39 2003
+++ 2.4.21-pre7/include/asm-i386/smpboot.h=09Tue Apr 15 15:20:01 2003
@@ -21,7 +21,10 @@ static inline void detect_clustered_apic
 =09/*
 =09 * Can't recognize Summit xAPICs at present, so use the OEM ID.
 =09 */
-=09if (!strncmp(oem, "IBM ENSW", 8) && !strncmp(prod, "VIGIL SMP", 9)){
+=09if (!strncmp(oem, "IBM ENSW", 8) &&
+=09    (!strncmp(prod, "VIGIL SMP", 9) ||
+=09     !strncmp(prod, "EXA", 3) ||
+=09     !strncmp(prod, "RUTHLESS", 8))){
 =09=09clustered_apic_mode =3D CLUSTERED_APIC_XAPIC;
 =09=09apic_broadcast_id =3D APIC_BROADCAST_ID_XAPIC;
 =09=09int_dest_addr_mode =3D APIC_DEST_PHYSICAL;


--=20
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

--------------Boundary-00=_32PER8SALB74UUYFRDGU
Content-Type: text/x-diff;
  charset="us-ascii";
  name="x445_2003-04-15_2.4.21-pre7"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="x445_2003-04-15_2.4.21-pre7"

--- 2.4.21-pre7/include/asm-i386/smpboot.h.df	Tue Apr 15 15:15:39 2003
+++ 2.4.21-pre7/include/asm-i386/smpboot.h	Tue Apr 15 15:20:01 2003
@@ -21,7 +21,10 @@ static inline void detect_clustered_apic
 	/*
 	 * Can't recognize Summit xAPICs at present, so use the OEM ID.
 	 */
-	if (!strncmp(oem, "IBM ENSW", 8) && !strncmp(prod, "VIGIL SMP", 9)){
+	if (!strncmp(oem, "IBM ENSW", 8) &&
+	    (!strncmp(prod, "VIGIL SMP", 9) ||
+	     !strncmp(prod, "EXA", 3) ||
+	     !strncmp(prod, "RUTHLESS", 8))){
 		clustered_apic_mode = CLUSTERED_APIC_XAPIC;
 		apic_broadcast_id = APIC_BROADCAST_ID_XAPIC;
 		int_dest_addr_mode = APIC_DEST_PHYSICAL;

--------------Boundary-00=_32PER8SALB74UUYFRDGU--

