Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313628AbSFJMkh>; Mon, 10 Jun 2002 08:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313743AbSFJMkF>; Mon, 10 Jun 2002 08:40:05 -0400
Received: from [195.63.194.11] ([195.63.194.11]:19463 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314082AbSFJMj0>; Mon, 10 Jun 2002 08:39:26 -0400
Message-ID: <3D04903C.3040101@evision-ventures.com>
Date: Mon, 10 Jun 2002 13:40:44 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.21 kill warnings 10/19
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------030804050706040208030502"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030804050706040208030502
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This time for iriap_event.

--------------030804050706040208030502
Content-Type: text/plain;
 name="warn-2.5.21-10.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="warn-2.5.21-10.diff"

diff -urN linux-2.5.21/net/irda/iriap_event.c linux/net/irda/iriap_event.=
c
--- linux-2.5.21/net/irda/iriap_event.c	2002-06-09 07:28:42.000000000 +02=
00
+++ linux/net/irda/iriap_event.c	2002-06-09 20:55:55.000000000 +0200
@@ -1,5 +1,5 @@
 /*********************************************************************
- *               =20
+ *
  * Filename:      iriap_event.c
  * Version:       0.1
  * Description:   IAP Finite State Machine
@@ -8,17 +8,17 @@
  * Created at:    Thu Aug 21 00:02:07 1997
  * Modified at:   Wed Mar  1 11:28:34 2000
  * Modified by:   Dag Brattli <dagb@cs.uit.no>
- *=20
- *     Copyright (c) 1997, 1999-2000 Dag Brattli <dagb@cs.uit.no>,=20
+ *
+ *     Copyright (c) 1997, 1999-2000 Dag Brattli <dagb@cs.uit.no>,
  *     All Rights Reserved.
- *    =20
- *     This program is free software; you can redistribute it and/or=20
- *     modify it under the terms of the GNU General Public License as=20
- *     published by the Free Software Foundation; either version 2 of=20
+ *
+ *     This program is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of
  *     the License, or (at your option) any later version.
  *
  *     Neither Dag Brattli nor University of Troms=F8 admit liability no=
r
- *     provide warranty for any of this software. This material is=20
+ *     provide warranty for any of this software. This material is
  *     provided "AS-IS" and at no charge.
  *
  ********************************************************************/
@@ -28,48 +28,48 @@
 #include <net/irda/iriap.h>
 #include <net/irda/iriap_event.h>
=20
-static void state_s_disconnect   (struct iriap_cb *self, IRIAP_EVENT eve=
nt,=20
+static void state_s_disconnect   (struct iriap_cb *self, IRIAP_EVENT eve=
nt,
 				  struct sk_buff *skb);
-static void state_s_connecting   (struct iriap_cb *self, IRIAP_EVENT eve=
nt,=20
+static void state_s_connecting   (struct iriap_cb *self, IRIAP_EVENT eve=
nt,
 				  struct sk_buff *skb);
-static void state_s_call         (struct iriap_cb *self, IRIAP_EVENT eve=
nt,=20
+static void state_s_call         (struct iriap_cb *self, IRIAP_EVENT eve=
nt,
 				  struct sk_buff *skb);
=20
-static void state_s_make_call    (struct iriap_cb *self, IRIAP_EVENT eve=
nt,=20
+static void state_s_make_call    (struct iriap_cb *self, IRIAP_EVENT eve=
nt,
 				  struct sk_buff *skb);
-static void state_s_calling      (struct iriap_cb *self, IRIAP_EVENT eve=
nt,=20
+static void state_s_calling      (struct iriap_cb *self, IRIAP_EVENT eve=
nt,
 				  struct sk_buff *skb);
-static void state_s_outstanding  (struct iriap_cb *self, IRIAP_EVENT eve=
nt,=20
+static void state_s_outstanding  (struct iriap_cb *self, IRIAP_EVENT eve=
nt,
 				  struct sk_buff *skb);
-static void state_s_replying     (struct iriap_cb *self, IRIAP_EVENT eve=
nt,=20
+static void state_s_replying     (struct iriap_cb *self, IRIAP_EVENT eve=
nt,
 				  struct sk_buff *skb);
-static void state_s_wait_for_call(struct iriap_cb *self, IRIAP_EVENT eve=
nt,=20
+static void state_s_wait_for_call(struct iriap_cb *self, IRIAP_EVENT eve=
nt,
 				  struct sk_buff *skb);
-static void state_s_wait_active  (struct iriap_cb *self, IRIAP_EVENT eve=
nt,=20
+static void state_s_wait_active  (struct iriap_cb *self, IRIAP_EVENT eve=
nt,
 				  struct sk_buff *skb);
=20
-static void state_r_disconnect   (struct iriap_cb *self, IRIAP_EVENT eve=
nt,=20
+static void state_r_disconnect   (struct iriap_cb *self, IRIAP_EVENT eve=
nt,
 				  struct sk_buff *skb);
-static void state_r_call         (struct iriap_cb *self, IRIAP_EVENT eve=
nt,=20
+static void state_r_call         (struct iriap_cb *self, IRIAP_EVENT eve=
nt,
 				  struct sk_buff *skb);
-static void state_r_waiting      (struct iriap_cb *self, IRIAP_EVENT eve=
nt,=20
+static void state_r_waiting      (struct iriap_cb *self, IRIAP_EVENT eve=
nt,
 				  struct sk_buff *skb);
-static void state_r_wait_active  (struct iriap_cb *self, IRIAP_EVENT eve=
nt,=20
+static void state_r_wait_active  (struct iriap_cb *self, IRIAP_EVENT eve=
nt,
 				  struct sk_buff *skb);
-static void state_r_receiving    (struct iriap_cb *self, IRIAP_EVENT eve=
nt,=20
+static void state_r_receiving    (struct iriap_cb *self, IRIAP_EVENT eve=
nt,
 				  struct sk_buff *skb);
-static void state_r_execute      (struct iriap_cb *self, IRIAP_EVENT eve=
nt,=20
+static void state_r_execute      (struct iriap_cb *self, IRIAP_EVENT eve=
nt,
 				  struct sk_buff *skb);
-static void state_r_returning    (struct iriap_cb *self, IRIAP_EVENT eve=
nt,=20
+static void state_r_returning    (struct iriap_cb *self, IRIAP_EVENT eve=
nt,
 				  struct sk_buff *skb);
=20
-static void (*iriap_state[])(struct iriap_cb *self, IRIAP_EVENT event,=20
-			     struct sk_buff *skb) =3D {=20
+static void (*iriap_state[])(struct iriap_cb *self, IRIAP_EVENT event,
+			     struct sk_buff *skb) =3D {
 	/* Client FSM */
 	state_s_disconnect,
 	state_s_connecting,
 	state_s_call,
-=09
+
 	/* S-Call FSM */
 	state_s_make_call,
 	state_s_calling,
@@ -90,7 +90,7 @@
 	state_r_returning,
 };
=20
-void iriap_next_client_state(struct iriap_cb *self, IRIAP_STATE state)=20
+void iriap_next_client_state(struct iriap_cb *self, IRIAP_STATE state)
 {
 	ASSERT(self !=3D NULL, return;);
 	ASSERT(self->magic =3D=3D IAS_MAGIC, return;);
@@ -98,7 +98,7 @@
 	self->client_state =3D state;
 }
=20
-void iriap_next_call_state(struct iriap_cb *self, IRIAP_STATE state)=20
+void iriap_next_call_state(struct iriap_cb *self, IRIAP_STATE state)
 {
 	ASSERT(self !=3D NULL, return;);
 	ASSERT(self->magic =3D=3D IAS_MAGIC, return;);
@@ -118,12 +118,12 @@
 {
 	ASSERT(self !=3D NULL, return;);
 	ASSERT(self->magic =3D=3D IAS_MAGIC, return;);
-=09
+
 	self->r_connect_state =3D state;
 }
=20
-void iriap_do_client_event(struct iriap_cb *self, IRIAP_EVENT event,=20
-			   struct sk_buff *skb)=20
+void iriap_do_client_event(struct iriap_cb *self, IRIAP_EVENT event,
+			   struct sk_buff *skb)
 {
 	ASSERT(self !=3D NULL, return;);
 	ASSERT(self->magic =3D=3D IAS_MAGIC, return;);
@@ -131,30 +131,30 @@
 	(*iriap_state[ self->client_state]) (self, event, skb);
 }
=20
-void iriap_do_call_event(struct iriap_cb *self, IRIAP_EVENT event,=20
-			 struct sk_buff *skb)=20
+void iriap_do_call_event(struct iriap_cb *self, IRIAP_EVENT event,
+			 struct sk_buff *skb)
 {
 	ASSERT(self !=3D NULL, return;);
 	ASSERT(self->magic =3D=3D IAS_MAGIC, return;);
-=09
+
 	(*iriap_state[ self->call_state]) (self, event, skb);
 }
=20
-void iriap_do_server_event(struct iriap_cb *self, IRIAP_EVENT event,=20
-			   struct sk_buff *skb)=20
+void iriap_do_server_event(struct iriap_cb *self, IRIAP_EVENT event,
+			   struct sk_buff *skb)
 {
 	ASSERT(self !=3D NULL, return;);
 	ASSERT(self->magic =3D=3D IAS_MAGIC, return;);
-=09
+
 	(*iriap_state[ self->server_state]) (self, event, skb);
 }
=20
-void iriap_do_r_connect_event(struct iriap_cb *self, IRIAP_EVENT event, =

-			      struct sk_buff *skb)=20
+void iriap_do_r_connect_event(struct iriap_cb *self, IRIAP_EVENT event,
+			      struct sk_buff *skb)
 {
 	ASSERT(self !=3D NULL, return;);
 	ASSERT(self->magic =3D=3D IAS_MAGIC, return;);
-=09
+
 	(*iriap_state[ self->r_connect_state]) (self, event, skb);
 }
=20
@@ -165,8 +165,8 @@
  *    S-Disconnect, The device has no LSAP connection to a particular
  *    remote device.
  */
-static void state_s_disconnect(struct iriap_cb *self, IRIAP_EVENT event,=
=20
-			       struct sk_buff *skb)=20
+static void state_s_disconnect(struct iriap_cb *self, IRIAP_EVENT event,=

+			       struct sk_buff *skb)
 {
 	ASSERT(self !=3D NULL, return;);
 	ASSERT(self->magic =3D=3D IAS_MAGIC, return;);
@@ -192,8 +192,8 @@
  *    S-Connecting
  *
  */
-static void state_s_connecting(struct iriap_cb *self, IRIAP_EVENT event,=
=20
-			       struct sk_buff *skb)=20
+static void state_s_connecting(struct iriap_cb *self, IRIAP_EVENT event,=

+			       struct sk_buff *skb)
 {
 	ASSERT(self !=3D NULL, return;);
 	ASSERT(self->magic =3D=3D IAS_MAGIC, return;);
@@ -223,10 +223,10 @@
  *
  *    S-Call, The device can process calls to a specific remote
  *    device. Whenever the LSAP connection is disconnected, this state
- *    catches that event and clears up=20
+ *    catches that event and clears up
  */
-static void state_s_call(struct iriap_cb *self, IRIAP_EVENT event,=20
-			 struct sk_buff *skb)=20
+static void state_s_call(struct iriap_cb *self, IRIAP_EVENT event,
+			 struct sk_buff *skb)
 {
 	ASSERT(self !=3D NULL, return;);
=20
@@ -248,8 +248,8 @@
  *    S-Make-Call
  *
  */
-static void state_s_make_call(struct iriap_cb *self, IRIAP_EVENT event, =

-			      struct sk_buff *skb)=20
+static void state_s_make_call(struct iriap_cb *self, IRIAP_EVENT event,
+			      struct sk_buff *skb)
 {
 	ASSERT(self !=3D NULL, return;);
=20
@@ -257,7 +257,7 @@
 	case IAP_CALL_REQUEST:
 		skb =3D self->skb;
 		self->skb =3D NULL;
-	=09
+
 		irlmp_data_request(self->lsap, skb);
 		iriap_next_call_state(self, S_OUTSTANDING);
 		break;
@@ -275,8 +275,8 @@
  *    S-Calling
  *
  */
-static void state_s_calling(struct iriap_cb *self, IRIAP_EVENT event,=20
-			    struct sk_buff *skb)=20
+static void state_s_calling(struct iriap_cb *self, IRIAP_EVENT event,
+			    struct sk_buff *skb)
 {
 	IRDA_DEBUG(0, __FUNCTION__ "(), Not implemented\n");
 }
@@ -287,8 +287,8 @@
  *    S-Outstanding, The device is waiting for a response to a command
  *
  */
-static void state_s_outstanding(struct iriap_cb *self, IRIAP_EVENT event=
,=20
-				struct sk_buff *skb)=20
+static void state_s_outstanding(struct iriap_cb *self, IRIAP_EVENT event=
,
+				struct sk_buff *skb)
 {
 	ASSERT(self !=3D NULL, return;);
=20
@@ -302,7 +302,7 @@
 	default:
 		IRDA_DEBUG(0, __FUNCTION__ "(), Unknown event %d\n", event);
 		break;
-	}	=09
+	}
 }
=20
 /*
@@ -310,8 +310,8 @@
  *
  *    S-Replying, The device is collecting a multiple part response
  */
-static void state_s_replying(struct iriap_cb *self, IRIAP_EVENT event,=20
-			     struct sk_buff *skb)=20
+static void state_s_replying(struct iriap_cb *self, IRIAP_EVENT event,
+			     struct sk_buff *skb)
 {
 	IRDA_DEBUG(0, __FUNCTION__ "(), Not implemented\n");
 }
@@ -322,8 +322,8 @@
  *    S-Wait-for-Call
  *
  */
-static void state_s_wait_for_call(struct iriap_cb *self, IRIAP_EVENT eve=
nt,=20
-				  struct sk_buff *skb)=20
+static void state_s_wait_for_call(struct iriap_cb *self, IRIAP_EVENT eve=
nt,
+				  struct sk_buff *skb)
 {
 	IRDA_DEBUG(0, __FUNCTION__ "(), Not implemented\n");
 }
@@ -335,15 +335,15 @@
  *    S-Wait-Active
  *
  */
-static void state_s_wait_active(struct iriap_cb *self, IRIAP_EVENT event=
,=20
-				struct sk_buff *skb)=20
+static void state_s_wait_active(struct iriap_cb *self, IRIAP_EVENT event=
,
+				struct sk_buff *skb)
 {
 	IRDA_DEBUG(0, __FUNCTION__ "(), Not implemented\n");
 }
=20
 /***********************************************************************=
***
- *=20
- *  Server FSM=20
+ *
+ *  Server FSM
  *
  ***********************************************************************=
***/
=20
@@ -353,27 +353,27 @@
  *    LM-IAS server is disconnected (not processing any requests!)
  *
  */
-static void state_r_disconnect(struct iriap_cb *self, IRIAP_EVENT event,=
=20
-			       struct sk_buff *skb)=20
+static void state_r_disconnect(struct iriap_cb *self, IRIAP_EVENT event,=

+			       struct sk_buff *skb)
 {
 	struct sk_buff *tx_skb;
-=09
+
 	switch (event) {
 	case IAP_LM_CONNECT_INDICATION:
 		tx_skb =3D dev_alloc_skb(64);
 		if (tx_skb =3D=3D NULL) {
-			WARNING(__FUNCTION__ "(), unable to malloc!\n");
+			WARNING("%s: unable to malloc!\n", __FUNCTION__);
 			return;
 		}
=20
 		/* Reserve space for MUX_CONTROL and LAP header */
 		skb_reserve(tx_skb, LMP_MAX_HEADER);
-	=09
+
 		irlmp_connect_response(self->lsap, tx_skb);
 		/*LM_Idle_request(idle); */
-	=09
+
 		iriap_next_server_state(self, R_CALL);
-	=09
+
 		/*
 		 *  Jump to R-Connect FSM, we skip R-Waiting since we do not
 		 *  care about LM_Idle_request()!
@@ -382,22 +382,19 @@
=20
 		if (skb)
 			dev_kfree_skb(skb);
-	=09
+
 		break;
 	default:
 		IRDA_DEBUG(0, __FUNCTION__ "(), unknown event %d\n", event);
 		break;
-	}	=09
+	}
 }
=20
 /*
  * Function state_r_call (self, event, skb)
- *
- *   =20
- *
  */
-static void state_r_call(struct iriap_cb *self, IRIAP_EVENT event,=20
-			 struct sk_buff *skb)=20
+static void state_r_call(struct iriap_cb *self, IRIAP_EVENT event,
+			 struct sk_buff *skb)
 {
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
=20
@@ -405,7 +402,7 @@
 	case IAP_LM_DISCONNECT_INDICATION:
 		/* Abort call */
 		iriap_next_server_state(self, R_DISCONNECT);
-		iriap_next_r_connect_state(self, R_WAITING);	=09
+		iriap_next_r_connect_state(self, R_WAITING);
 		break;
 	default:
 		IRDA_DEBUG(0, __FUNCTION__ "(), unknown event!\n");
@@ -413,24 +410,21 @@
 	}
 }
=20
-/*=20
- *  R-Connect FSM=20
-*/
+/*
+ *  R-Connect FSM
+ */
=20
 /*
  * Function state_r_waiting (self, event, skb)
- *
- *   =20
- *
  */
-static void state_r_waiting(struct iriap_cb *self, IRIAP_EVENT event,=20
-			    struct sk_buff *skb)=20
+static void state_r_waiting(struct iriap_cb *self, IRIAP_EVENT event,
+			    struct sk_buff *skb)
 {
 	IRDA_DEBUG(0, __FUNCTION__ "(), Not implemented\n");
 }
=20
-static void state_r_wait_active(struct iriap_cb *self, IRIAP_EVENT event=
,=20
-				struct sk_buff *skb)=20
+static void state_r_wait_active(struct iriap_cb *self, IRIAP_EVENT event=
,
+				struct sk_buff *skb)
 {
 	IRDA_DEBUG(0, __FUNCTION__ "(), Not implemented\n");
 }
@@ -441,15 +435,15 @@
  *    We are receiving a command
  *
  */
-static void state_r_receiving(struct iriap_cb *self, IRIAP_EVENT event, =

-			      struct sk_buff *skb)=20
+static void state_r_receiving(struct iriap_cb *self, IRIAP_EVENT event,
+			      struct sk_buff *skb)
 {
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
=20
 	switch (event) {
 	case IAP_RECV_F_LST:
 		iriap_next_r_connect_state(self, R_EXECUTE);
-	 	=09
+
 		iriap_call_indication(self, skb);
 		break;
 	default:
@@ -465,26 +459,26 @@
  *    The server is processing the request
  *
  */
-static void state_r_execute(struct iriap_cb *self, IRIAP_EVENT event,=20
-			    struct sk_buff *skb)=20
+static void state_r_execute(struct iriap_cb *self, IRIAP_EVENT event,
+			    struct sk_buff *skb)
 {
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
=20
 	ASSERT(skb !=3D NULL, return;);
-=09
+
 	if (!self || self->magic !=3D IAS_MAGIC) {
 		IRDA_DEBUG(0, __FUNCTION__ "(), bad pointer self\n");
 		return;
-	}=09
+	}
=20
 	switch (event) {
 	case IAP_CALL_RESPONSE:
-		/* =20
+		/*
 		 *  Since we don't implement the Waiting state, we return
 		 *  to state Receiving instead, DB.
 		 */
 		iriap_next_r_connect_state(self, R_RECEIVING);
-	 	=09
+
 		irlmp_data_request(self->lsap, skb);
 		break;
 	default:
@@ -493,19 +487,15 @@
 	}
 }
=20
-static void state_r_returning(struct iriap_cb *self, IRIAP_EVENT event, =

-			      struct sk_buff *skb)=20
+static void state_r_returning(struct iriap_cb *self, IRIAP_EVENT event,
+			      struct sk_buff *skb)
 {
 	IRDA_DEBUG(0, __FUNCTION__ "(), event=3D%d\n", event);
=20
 	switch (event) {
 	case IAP_RECV_F_LST:
-	=09
 		break;
 	default:
 		break;
 	}
 }
-
-
-

--------------030804050706040208030502--

