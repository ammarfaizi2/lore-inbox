Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315167AbSFJMp6>; Mon, 10 Jun 2002 08:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314748AbSFJMpB>; Mon, 10 Jun 2002 08:45:01 -0400
Received: from [195.63.194.11] ([195.63.194.11]:23815 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313898AbSFJMnC>; Mon, 10 Jun 2002 08:43:02 -0400
Message-ID: <3D049113.8050208@evision-ventures.com>
Date: Mon, 10 Jun 2002 13:44:19 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.21 kill warnings 13/19
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------040102090908000707060909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040102090908000707060909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

irlap_event was abusing __FUNCTION__ too.

--------------040102090908000707060909
Content-Type: text/plain;
 name="warn-2.5.21-13.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="warn-2.5.21-13.diff"

diff -urN linux-2.5.21/net/irda/irlap_event.c linux/net/irda/irlap_event.=
c
--- linux-2.5.21/net/irda/irlap_event.c	2002-06-09 07:30:36.000000000 +02=
00
+++ linux/net/irda/irlap_event.c	2002-06-09 21:25:54.000000000 +0200
@@ -1,5 +1,5 @@
 /*********************************************************************
- *               =20
+ *
  * Filename:      irlap_event.c
  * Version:       0.9
  * Description:   IrLAP state machine implementation
@@ -8,19 +8,19 @@
  * Created at:    Sat Aug 16 00:59:29 1997
  * Modified at:   Sat Dec 25 21:07:57 1999
  * Modified by:   Dag Brattli <dag@brattli.net>
- *=20
+ *
  *     Copyright (c) 1998-2000 Dag Brattli <dag@brattli.net>,
  *     Copyright (c) 1998      Thomas Davis <ratbert@radiks.net>
  *     All Rights Reserved.
  *     Copyright (c) 2000-2001 Jean Tourrilhes <jt@hpl.hp.com>
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
@@ -46,35 +46,35 @@
 int sysctl_fast_poll_increase =3D 50;
 #endif
=20
-static int irlap_state_ndm    (struct irlap_cb *self, IRLAP_EVENT event,=
=20
+static int irlap_state_ndm    (struct irlap_cb *self, IRLAP_EVENT event,=

 			       struct sk_buff *skb, struct irlap_info *info);
-static int irlap_state_query  (struct irlap_cb *self, IRLAP_EVENT event,=
=20
+static int irlap_state_query  (struct irlap_cb *self, IRLAP_EVENT event,=

 			       struct sk_buff *skb, struct irlap_info *info);
-static int irlap_state_reply  (struct irlap_cb *self, IRLAP_EVENT event,=
=20
+static int irlap_state_reply  (struct irlap_cb *self, IRLAP_EVENT event,=

 			       struct sk_buff *skb, struct irlap_info *info);
-static int irlap_state_conn   (struct irlap_cb *self, IRLAP_EVENT event,=
=20
+static int irlap_state_conn   (struct irlap_cb *self, IRLAP_EVENT event,=

 			       struct sk_buff *skb, struct irlap_info *info);
-static int irlap_state_setup  (struct irlap_cb *self, IRLAP_EVENT event,=
=20
+static int irlap_state_setup  (struct irlap_cb *self, IRLAP_EVENT event,=

 			       struct sk_buff *skb, struct irlap_info *info);
-static int irlap_state_offline(struct irlap_cb *self, IRLAP_EVENT event,=
=20
+static int irlap_state_offline(struct irlap_cb *self, IRLAP_EVENT event,=

 			       struct sk_buff *skb, struct irlap_info *info);
-static int irlap_state_xmit_p (struct irlap_cb *self, IRLAP_EVENT event,=
=20
+static int irlap_state_xmit_p (struct irlap_cb *self, IRLAP_EVENT event,=

 			       struct sk_buff *skb, struct irlap_info *info);
-static int irlap_state_pclose (struct irlap_cb *self, IRLAP_EVENT event,=
=20
+static int irlap_state_pclose (struct irlap_cb *self, IRLAP_EVENT event,=

 			       struct sk_buff *skb, struct irlap_info *info);
-static int irlap_state_nrm_p  (struct irlap_cb *self, IRLAP_EVENT event,=
=20
+static int irlap_state_nrm_p  (struct irlap_cb *self, IRLAP_EVENT event,=

 			       struct sk_buff *skb, struct irlap_info *info);
-static int irlap_state_reset_wait(struct irlap_cb *self, IRLAP_EVENT eve=
nt,=20
+static int irlap_state_reset_wait(struct irlap_cb *self, IRLAP_EVENT eve=
nt,
 				  struct sk_buff *skb, struct irlap_info *info);
-static int irlap_state_reset  (struct irlap_cb *self, IRLAP_EVENT event,=
=20
+static int irlap_state_reset  (struct irlap_cb *self, IRLAP_EVENT event,=

 			       struct sk_buff *skb, struct irlap_info *info);
-static int irlap_state_nrm_s  (struct irlap_cb *self, IRLAP_EVENT event,=
=20
+static int irlap_state_nrm_s  (struct irlap_cb *self, IRLAP_EVENT event,=

 			       struct sk_buff *skb, struct irlap_info *info);
-static int irlap_state_xmit_s (struct irlap_cb *self, IRLAP_EVENT event,=
=20
+static int irlap_state_xmit_s (struct irlap_cb *self, IRLAP_EVENT event,=

 			       struct sk_buff *skb, struct irlap_info *info);
-static int irlap_state_sclose (struct irlap_cb *self, IRLAP_EVENT event,=
=20
+static int irlap_state_sclose (struct irlap_cb *self, IRLAP_EVENT event,=

 			       struct sk_buff *skb, struct irlap_info *info);
-static int irlap_state_reset_check(struct irlap_cb *, IRLAP_EVENT event,=
=20
+static int irlap_state_reset_check(struct irlap_cb *, IRLAP_EVENT event,=

 				   struct sk_buff *, struct irlap_info *);
=20
 #ifdef CONFIG_IRDA_DEBUG
@@ -138,8 +138,8 @@
 	"LAP_RESET_CHECK",
 };
=20
-static int (*state[])(struct irlap_cb *self, IRLAP_EVENT event,=20
-		      struct sk_buff *skb, struct irlap_info *info) =3D=20
+static int (*state[])(struct irlap_cb *self, IRLAP_EVENT event,
+		      struct sk_buff *skb, struct irlap_info *info) =3D
 {
 	irlap_state_ndm,
 	irlap_state_query,
@@ -167,10 +167,10 @@
 static void irlap_poll_timer_expired(void *data)
 {
 	struct irlap_cb *self =3D (struct irlap_cb *) data;
-=09
+
 	ASSERT(self !=3D NULL, return;);
 	ASSERT(self->magic =3D=3D LAP_MAGIC, return;);
-=09
+
 	irlap_do_event(self, POLL_TIMER_EXPIRED, NULL, NULL);
 }
=20
@@ -186,7 +186,7 @@
 	ASSERT(self->magic =3D=3D LAP_MAGIC, return;);
=20
 #ifdef CONFIG_IRDA_FAST_RR
-	/*=20
+	/*
 	 * Send out the RR frames faster if our own transmit queue is empty, or=

 	 * if the peer is busy. The effect is a much faster conversation
 	 */
@@ -201,7 +201,7 @@
 				 *  FIXME: this should be a more configurable
 				 *         function
 				 */
-				self->fast_RR_timeout +=3D=20
+				self->fast_RR_timeout +=3D
 					(sysctl_fast_poll_increase * HZ/1000);
=20
 				/* Use this fast(er) timeout instead */
@@ -223,7 +223,7 @@
 	if (timeout =3D=3D 0)
 		irlap_do_event(self, POLL_TIMER_EXPIRED, NULL, NULL);
 	else
-		irda_start_timer(&self->poll_timer, timeout, self,=20
+		irda_start_timer(&self->poll_timer, timeout, self,
 				 irlap_poll_timer_expired);
 }
=20
@@ -231,28 +231,28 @@
  * Function irlap_do_event (event, skb, info)
  *
  *    Rushes through the state machine without any delay. If state =3D=3D=
 XMIT
- *    then send queued data frames.=20
+ *    then send queued data frames.
  */
-void irlap_do_event(struct irlap_cb *self, IRLAP_EVENT event,=20
-		    struct sk_buff *skb, struct irlap_info *info)=20
+void irlap_do_event(struct irlap_cb *self, IRLAP_EVENT event,
+		    struct sk_buff *skb, struct irlap_info *info)
 {
 	int ret;
-=09
+
 	if (!self || self->magic !=3D LAP_MAGIC)
 		return;
=20
-  	IRDA_DEBUG(3, __FUNCTION__ "(), event =3D %s, state =3D %s\n",=20
-		   irlap_event[event], irlap_state[self->state]);=20
-=09
+	IRDA_DEBUG(3, __FUNCTION__ "(), event =3D %s, state =3D %s\n",
+		   irlap_event[event], irlap_state[self->state]);
+
 	ret =3D (*state[self->state])(self, event, skb, info);
=20
-	/*=20
+	/*
 	 *  Check if there are any pending events that needs to be executed
 	 */
 	switch (self->state) {
 	case LAP_XMIT_P: /* FALLTHROUGH */
 	case LAP_XMIT_S:
-		/*=20
+		/*
 		 * We just received the pf bit and are at the beginning
 		 * of a new LAP transmit window.
 		 * Check if there are any queued data frames, and do not
@@ -299,15 +299,15 @@
 			self->local_busy =3D FALSE;
 		} else if (self->disconnect_pending) {
 			self->disconnect_pending =3D FALSE;
-		=09
+
 			ret =3D (*state[self->state])(self, DISCONNECT_REQUEST,
 						    NULL, NULL);
 		}
 		break;
 /*	case LAP_NDM: */
-/* 	case LAP_CONN: */
-/* 	case LAP_RESET_WAIT: */
-/* 	case LAP_RESET_CHECK: */
+/*	case LAP_CONN: */
+/*	case LAP_RESET_WAIT: */
+/*	case LAP_RESET_CHECK: */
 	default:
 		break;
 	}
@@ -319,12 +319,12 @@
  *    Switches state and provides debug information
  *
  */
-static inline void irlap_next_state(struct irlap_cb *self, IRLAP_STATE s=
tate)=20
-{=09
+static inline void irlap_next_state(struct irlap_cb *self, IRLAP_STATE s=
tate)
+{
 	/*
 	if (!self || self->magic !=3D LAP_MAGIC)
 		return;
-=09
+
 	IRDA_DEBUG(4, "next LAP state =3D %s\n", irlap_state[state]);
 	*/
 	self->state =3D state;
@@ -336,8 +336,8 @@
  *    NDM (Normal Disconnected Mode) state
  *
  */
-static int irlap_state_ndm(struct irlap_cb *self, IRLAP_EVENT event,=20
-			   struct sk_buff *skb, struct irlap_info *info)=20
+static int irlap_state_ndm(struct irlap_cb *self, IRLAP_EVENT event,
+			   struct sk_buff *skb, struct irlap_info *info)
 {
 	discovery_t *discovery_rsp;
 	int ret =3D 0;
@@ -355,14 +355,14 @@
 			 * postpone the event... - Jean II */
 			IRDA_DEBUG(0, __FUNCTION__
 				   "(), CONNECT_REQUEST: media busy!\n");
-		=09
+
 			/* Always switch state before calling upper layers */
 			irlap_next_state(self, LAP_NDM);
-		=09
+
 			irlap_disconnect_indication(self, LAP_MEDIA_BUSY);
 		} else {
 			irlap_send_snrm_frame(self, &self->qos_rx);
-		=09
+
 			/* Start Final-bit timer */
 			irlap_start_final_timer(self, self->final_timeout);
=20
@@ -372,10 +372,10 @@
 		break;
 	case RECV_SNRM_CMD:
 		/* Check if the frame contains and I field */
-		if (info) {		      =20
+		if (info) {
 			self->daddr =3D info->daddr;
 			self->caddr =3D info->caddr;
-		=09
+
 			irlap_next_state(self, LAP_CONN);
=20
 			irlap_connect_indication(self, skb);
@@ -384,21 +384,21 @@
 				   "contain an I field!\n");
 		}
 		break;
-	case DISCOVERY_REQUEST:	=09
+	case DISCOVERY_REQUEST:
 		ASSERT(info !=3D NULL, return -1;);
=20
-	 	if (self->media_busy) {
- 			IRDA_DEBUG(0, __FUNCTION__ "(), media busy!\n");=20
+		if (self->media_busy) {
+			IRDA_DEBUG(0, __FUNCTION__ "(), media busy!\n");
 			/* irlap->log.condition =3D MEDIA_BUSY; */
-					=09
+
 			/* This will make IrLMP try again */
- 			irlap_discovery_confirm(self, NULL);
+			irlap_discovery_confirm(self, NULL);
 			/* Note : the discovery log is not cleaned up here,
 			 * it will be done in irlap_discovery_request()
 			 * Jean II */
 			return 0;
-	 	}=20
-	=09
+		}
+
 		self->S =3D info->S;
 		self->s =3D info->s;
 		irlap_send_discovery_xid_frame(self, info->S, info->s, TRUE,
@@ -419,17 +419,17 @@
 			if (self->slot =3D=3D info->s) {
 				discovery_rsp =3D irlmp_get_discovery_response();
 				discovery_rsp->daddr =3D info->daddr;
-			=09
-				irlap_send_discovery_xid_frame(self, info->S,=20
-							       self->slot,=20
+
+				irlap_send_discovery_xid_frame(self, info->S,
+							       self->slot,
 							       FALSE,
 							       discovery_rsp);
 				self->frame_sent =3D TRUE;
 			} else
 				self->frame_sent =3D FALSE;
-		=09
-			/*=20
-			 * Remember to multiply the query timeout value with=20
+
+			/*
+			 * Remember to multiply the query timeout value with
 			 * the number of slots used
 			 */
 			irlap_start_query_timer(self, QUERY_TIMEOUT*info->S);
@@ -453,7 +453,7 @@
 			IRDA_DEBUG(1, __FUNCTION__ "(), Receiving final discovery request, mi=
ssed the discovery slots :-(\n");
=20
 			/* Last discovery request -> in the log */
-			irlap_discovery_indication(self, info->discovery);=20
+			irlap_discovery_indication(self, info->discovery);
 		}
 		break;
 	case MEDIA_BUSY_TIMER_EXPIRED:
@@ -472,7 +472,7 @@
 			/* We don't send the frame, just post an event.
 			 * Also, previously this code was in timer.c...
 			 * Jean II */
-			ret =3D (*state[self->state])(self, SEND_UI_FRAME,=20
+			ret =3D (*state[self->state])(self, SEND_UI_FRAME,
 						    NULL, NULL);
 		}
 #endif /* CONFIG_IRDA_ULTRA */
@@ -488,7 +488,7 @@
 				irlap_disconnect_indication(self, LAP_DISC_INDICATION);
 			else
 				ret =3D (*state[self->state])(self,
-							    CONNECT_REQUEST,=20
+							    CONNECT_REQUEST,
 							    NULL, NULL);
 			self->disconnect_pending =3D FALSE;
 		}
@@ -506,13 +506,13 @@
 		break;
 #ifdef CONFIG_IRDA_ULTRA
 	case SEND_UI_FRAME:
-	{  =20
+	{
 		int i;
 		/* Only allowed to repeat an operation twice */
 		for (i=3D0; ((i<2) && (self->media_busy =3D=3D FALSE)); i++) {
 			skb =3D skb_dequeue(&self->txq_ultra);
 			if (skb)
-				irlap_send_ui_frame(self, skb, CBROADCAST,=20
+				irlap_send_ui_frame(self, skb, CBROADCAST,
 						    CMD_FRAME);
 			else
 				break;
@@ -526,7 +526,7 @@
 	case RECV_UI_FRAME:
 		/* Only accept broadcast frames in NDM mode */
 		if (info->caddr !=3D CBROADCAST) {
-			IRDA_DEBUG(0, __FUNCTION__=20
+			IRDA_DEBUG(0, __FUNCTION__
 				   "(), not a broadcast frame!\n");
 		} else
 			irlap_unitdata_indication(self, skb);
@@ -536,7 +536,7 @@
 		/* Remove test frame header */
 		skb_pull(skb, sizeof(struct test_frame));
=20
-		/*=20
+		/*
 		 * Send response. This skb will not be sent out again, and
 		 * will only be used to send out the same info as the cmd
 		 */
@@ -546,12 +546,12 @@
 		IRDA_DEBUG(0, __FUNCTION__ "() not implemented!\n");
 		break;
 	default:
-		IRDA_DEBUG(2, __FUNCTION__ "(), Unknown event %s\n",=20
+		IRDA_DEBUG(2, __FUNCTION__ "(), Unknown event %s\n",
 			   irlap_event[event]);
-	=09
+
 		ret =3D -1;
 		break;
-	}=09
+	}
 	return ret;
 }
=20
@@ -561,8 +561,8 @@
  *    QUERY state
  *
  */
-static int irlap_state_query(struct irlap_cb *self, IRLAP_EVENT event,=20
-			     struct sk_buff *skb, struct irlap_info *info)=20
+static int irlap_state_query(struct irlap_cb *self, IRLAP_EVENT event,
+			     struct sk_buff *skb, struct irlap_info *info)
 {
 	int ret =3D 0;
=20
@@ -574,16 +574,16 @@
 		ASSERT(info !=3D NULL, return -1;);
 		ASSERT(info->discovery !=3D NULL, return -1;);
=20
-		IRDA_DEBUG(4, __FUNCTION__ "(), daddr=3D%08x\n",=20
+		IRDA_DEBUG(4, __FUNCTION__ "(), daddr=3D%08x\n",
 			   info->discovery->daddr);
=20
 		if (!self->discovery_log) {
-			WARNING(__FUNCTION__ "(), discovery log is gone! "
+			WARNING("%s: discovery log is gone! "
 				"maybe the discovery timeout has been set to "
-				"short?\n");
+				"short?\n", __FUNCTION__);
 			break;
 		}
-		hashbin_insert(self->discovery_log,=20
+		hashbin_insert(self->discovery_log,
 			       (irda_queue_t *) info->discovery,
 			       info->discovery->daddr, NULL);
=20
@@ -609,17 +609,17 @@
=20
 		/* Last discovery request ? */
 		if (info->s =3D=3D 0xff)
-			irlap_discovery_indication(self, info->discovery);=20
+			irlap_discovery_indication(self, info->discovery);
 		break;
 	case SLOT_TIMER_EXPIRED:
 		/*
 		 * Wait a little longer if we detect an incoming frame. This
-		 * is not mentioned in the spec, but is a good thing to do,=20
+		 * is not mentioned in the spec, but is a good thing to do,
 		 * since we want to work even with devices that violate the
 		 * timing requirements.
 		 */
 		if (irda_device_is_receiving(self->netdev) && !self->add_wait) {
-			IRDA_DEBUG(2, __FUNCTION__=20
+			IRDA_DEBUG(2, __FUNCTION__
 				   "(), device is slow to answer, "
 				   "waiting some more!\n");
 			irlap_start_slot_timer(self, MSECS_TO_JIFFIES(10));
@@ -629,25 +629,25 @@
 		self->add_wait =3D FALSE;
=20
 		if (self->s < self->S) {
-			irlap_send_discovery_xid_frame(self, self->S,=20
+			irlap_send_discovery_xid_frame(self, self->S,
 						       self->s, TRUE,
 						       self->discovery_cmd);
 			self->s++;
 			irlap_start_slot_timer(self, self->slot_timeout);
-		=09
+
 			/* Keep state */
 			irlap_next_state(self, LAP_QUERY);
 		} else {
 			/* This is the final slot! */
-			irlap_send_discovery_xid_frame(self, self->S, 0xff,=20
+			irlap_send_discovery_xid_frame(self, self->S, 0xff,
 						       TRUE,
 						       self->discovery_cmd);
=20
 			/* Always switch state before calling upper layers */
 			irlap_next_state(self, LAP_NDM);
-=09
+
 			/*
-			 *  We are now finished with the discovery procedure,=20
+			 *  We are now finished with the discovery procedure,
 			 *  so now we must return the results
 			 */
 			irlap_discovery_confirm(self, self->discovery_log);
@@ -657,7 +657,7 @@
 		}
 		break;
 	default:
-		IRDA_DEBUG(2, __FUNCTION__ "(), Unknown event %s\n",=20
+		IRDA_DEBUG(2, __FUNCTION__ "(), Unknown event %s\n",
 			   irlap_event[event]);
=20
 		ret =3D -1;
@@ -671,10 +671,10 @@
  *
  *    REPLY, we have received a XID discovery frame from a device and we=

  *    are waiting for the right time slot to send a response XID frame
- *=20
+ *
  */
-static int irlap_state_reply(struct irlap_cb *self, IRLAP_EVENT event,=20
-			     struct sk_buff *skb, struct irlap_info *info)=20
+static int irlap_state_reply(struct irlap_cb *self, IRLAP_EVENT event,
+			     struct sk_buff *skb, struct irlap_info *info)
 {
 	discovery_t *discovery_rsp;
 	int ret=3D0;
@@ -695,13 +695,13 @@
 		/* Last frame? */
 		if (info->s =3D=3D 0xff) {
 			del_timer(&self->query_timer);
-		=09
+
 			/* info->log.condition =3D REMOTE; */
=20
 			/* Always switch state before calling upper layers */
 			irlap_next_state(self, LAP_NDM);
=20
-			irlap_discovery_indication(self, info->discovery);=20
+			irlap_discovery_indication(self, info->discovery);
 		} else if ((info->s >=3D self->slot) && (!self->frame_sent)) {
 			discovery_rsp =3D irlmp_get_discovery_response();
 			discovery_rsp->daddr =3D info->daddr;
@@ -709,7 +709,7 @@
 			irlap_send_discovery_xid_frame(self, info->S,
 						       self->slot, FALSE,
 						       discovery_rsp);
-		=09
+
 			self->frame_sent =3D TRUE;
 			irlap_next_state(self, LAP_REPLY);
 		}
@@ -728,11 +728,11 @@
  * Function irlap_state_conn (event, skb, info)
  *
  *    CONN, we have received a SNRM command and is waiting for the upper=

- *    layer to accept or refuse connection=20
+ *    layer to accept or refuse connection
  *
  */
-static int irlap_state_conn(struct irlap_cb *self, IRLAP_EVENT event,=20
-			    struct sk_buff *skb, struct irlap_info *info)=20
+static int irlap_state_conn(struct irlap_cb *self, IRLAP_EVENT event,
+			    struct sk_buff *skb, struct irlap_info *info)
 {
 	int ret =3D 0;
=20
@@ -751,20 +751,20 @@
=20
 		irlap_initiate_connection_state(self);
=20
-		/*=20
+		/*
 		 * Applying the parameters now will make sure we change speed
 		 * *after* we have sent the next frame
 		 */
 		irlap_apply_connection_parameters(self, FALSE);
=20
-		/*=20
+		/*
 		 * Sending this frame will force a speed change after it has
 		 * been sent (i.e. the frame will be sent at 9600).
 		 */
 		irlap_send_ua_response_frame(self, &self->qos_rx);
=20
 #if 0
-		/*=20
+		/*
 		 * We are allowed to send two frames, but this may increase
 		 * the connect latency, so lets not do it for now.
 		 */
@@ -787,20 +787,20 @@
 #endif
=20
 		/*
-		 *  The WD-timer could be set to the duration of the P-timer=20
-		 *  for this case, but it is recommended to use twice the=20
-		 *  value (note 3 IrLAP p. 60).=20
+		 *  The WD-timer could be set to the duration of the P-timer
+		 *  for this case, but it is recommended to use twice the
+		 *  value (note 3 IrLAP p. 60).
 		 */
 		irlap_start_wd_timer(self, self->wd_timeout);
 		irlap_next_state(self, LAP_NRM_S);
=20
 		break;
 	case RECV_DISCOVERY_XID_CMD:
-		IRDA_DEBUG(3, __FUNCTION__=20
+		IRDA_DEBUG(3, __FUNCTION__
 			   "(), event RECV_DISCOVER_XID_CMD!\n");
 		irlap_next_state(self, LAP_NDM);
=20
-		break;	=09
+		break;
 	case DISCONNECT_REQUEST:
 		IRDA_DEBUG(0, __FUNCTION__ "(), Disconnect request!\n");
 		irlap_send_dm_frame(self);
@@ -810,11 +810,11 @@
 	default:
 		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %d, %s\n", event,
 			   irlap_event[event]);
-	=09
+
 		ret =3D -1;
 		break;
 	}
-=09
+
 	return ret;
 }
=20
@@ -825,26 +825,26 @@
  *    a remote peer layer and is awaiting a reply .
  *
  */
-static int irlap_state_setup(struct irlap_cb *self, IRLAP_EVENT event,=20
-			     struct sk_buff *skb, struct irlap_info *info)=20
+static int irlap_state_setup(struct irlap_cb *self, IRLAP_EVENT event,
+			     struct sk_buff *skb, struct irlap_info *info)
 {
 	int ret =3D 0;
=20
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
-=09
+
 	ASSERT(self !=3D NULL, return -1;);
 	ASSERT(self->magic =3D=3D LAP_MAGIC, return -1;);
=20
 	switch (event) {
 	case FINAL_TIMER_EXPIRED:
 		if (self->retry_count < self->N3) {
-/*=20
- *  Perform random backoff, Wait a random number of time units, minimum =

- *  duration half the time taken to transmitt a SNRM frame, maximum dura=
tion=20
- *  1.5 times the time taken to transmit a SNRM frame. So this time shou=
ld=20
+/*
+ *  Perform random backoff, Wait a random number of time units, minimum
+ *  duration half the time taken to transmitt a SNRM frame, maximum dura=
tion
+ *  1.5 times the time taken to transmit a SNRM frame. So this time shou=
ld
  *  between 15 msecs and 45 msecs.
  */
-			irlap_start_backoff_timer(self, MSECS_TO_JIFFIES(20 +=20
+			irlap_start_backoff_timer(self, MSECS_TO_JIFFIES(20 +
 						        (jiffies % 30)));
 		} else {
 			/* Always switch state before calling upper layers */
@@ -877,18 +877,18 @@
 			skb_pull(skb, sizeof(struct snrm_frame));
=20
 			irlap_qos_negotiate(self, skb);
-		=09
+
 			/* Send UA frame and then change link settings */
 			irlap_apply_connection_parameters(self, FALSE);
 			irlap_send_ua_response_frame(self, &self->qos_rx);
=20
 			irlap_next_state(self, LAP_NRM_S);
 			irlap_connect_confirm(self, skb);
-		=09
-			/*=20
+
+			/*
 			 *  The WD-timer could be set to the duration of the
 			 *  P-timer for this case, but it is recommended
-			 *  to use twice the value (note 3 IrLAP p. 60). =20
+			 *  to use twice the value (note 3 IrLAP p. 60).
 			 */
 			irlap_start_wd_timer(self, self->wd_timeout);
 		} else {
@@ -915,7 +915,7 @@
 		/* Set the new link setting *now* (before the rr frame) */
 		irlap_apply_connection_parameters(self, TRUE);
 		self->retry_count =3D 0;
-	=09
+
 		/* Wait for turnaround time to give a chance to the other
 		 * device to be ready to receive us.
 		 * Note : the time to switch speed is typically larger
@@ -933,7 +933,7 @@
 		irlap_connect_confirm(self, skb);
 		break;
 	case RECV_DM_RSP:     /* FALLTHROUGH */
-	case RECV_DISC_CMD:=20
+	case RECV_DISC_CMD:
 		del_timer(&self->final_timer);
 		irlap_next_state(self, LAP_NDM);
=20
@@ -941,11 +941,11 @@
 		break;
 	default:
 		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %d, %s\n", event,
-			   irlap_event[event]);	=09
+			   irlap_event[event]);
=20
 		ret =3D -1;
 		break;
-	}=09
+	}
 	return ret;
 }
=20
@@ -955,8 +955,8 @@
  *    OFFLINE state, not used for now!
  *
  */
-static int irlap_state_offline(struct irlap_cb *self, IRLAP_EVENT event,=
=20
-			       struct sk_buff *skb, struct irlap_info *info)=20
+static int irlap_state_offline(struct irlap_cb *self, IRLAP_EVENT event,=

+			       struct sk_buff *skb, struct irlap_info *info)
 {
 	IRDA_DEBUG( 0, __FUNCTION__ "(), Unknown event\n");
=20
@@ -965,31 +965,31 @@
=20
 /*
  * Function irlap_state_xmit_p (self, event, skb, info)
- *=20
+ *
  *    XMIT, Only the primary station has right to transmit, and we
  *    therefore do not expect to receive any transmissions from other
  *    stations.
- *=20
+ *
  */
-static int irlap_state_xmit_p(struct irlap_cb *self, IRLAP_EVENT event, =

-			      struct sk_buff *skb, struct irlap_info *info)=20
+static int irlap_state_xmit_p(struct irlap_cb *self, IRLAP_EVENT event,
+			      struct sk_buff *skb, struct irlap_info *info)
 {
 	int ret =3D 0;
-=09
+
 	switch (event) {
 	case SEND_I_CMD:
 		/*
 		 *  Only send frame if send-window > 0.
-		 */=20
+		 */
 		if ((self->window > 0) && (!self->remote_busy)) {
 #ifdef CONFIG_IRDA_DYNAMIC_WINDOW
 			/*
-			 *  Test if we have transmitted more bytes over the=20
-			 *  link than its possible to do with the current=20
+			 *  Test if we have transmitted more bytes over the
+			 *  link than its possible to do with the current
 			 *  speed and turn-around-time.
 			 */
 			if (skb->len > self->bytes_left) {
-				IRDA_DEBUG(4, __FUNCTION__=20
+				IRDA_DEBUG(4, __FUNCTION__
 					   "(), Not allowed to transmit more "
 					   "bytes!\n");
 				skb_queue_head(&self->txq, skb_get(skb));
@@ -1009,18 +1009,18 @@
 			 *  Send data with poll bit cleared only if window > 1
 			 *  and there is more frames after this one to be sent
 			 */
-			if ((self->window > 1) &&=20
-			    skb_queue_len( &self->txq) > 0)=20
-			{  =20
+			if ((self->window > 1) &&
+			    skb_queue_len( &self->txq) > 0)
+			{
 				irlap_send_data_primary(self, skb);
 				irlap_next_state(self, LAP_XMIT_P);
 			} else {
 				irlap_send_data_primary_poll(self, skb);
 				irlap_next_state(self, LAP_NRM_P);
-			=09
-				/*=20
+
+				/*
 				 * Make sure state machine does not try to send
-				 * any more frames=20
+				 * any more frames
 				 */
 				ret =3D -EPROTO;
 			}
@@ -1029,12 +1029,12 @@
 			self->fast_RR =3D FALSE;
 #endif /* CONFIG_IRDA_FAST_RR */
 		} else {
-			IRDA_DEBUG(4, __FUNCTION__=20
+			IRDA_DEBUG(4, __FUNCTION__
 				   "(), Unable to send! remote busy?\n");
 			skb_queue_head(&self->txq, skb_get(skb));
=20
 			/*
-			 *  The next ret is important, because it tells=20
+			 *  The next ret is important, because it tells
 			 *  irlap_next_state _not_ to deliver more frames
 			 */
 			ret =3D -EPROTO;
@@ -1067,7 +1067,7 @@
 		 * when we return... - Jean II */
 		break;
 	default:
-		IRDA_DEBUG(0, __FUNCTION__ "(), Unknown event %s\n",=20
+		IRDA_DEBUG(0, __FUNCTION__ "(), Unknown event %s\n",
 			   irlap_event[event]);
=20
 		ret =3D -EINVAL;
@@ -1081,15 +1081,15 @@
  *
  *    PCLOSE state
  */
-static int irlap_state_pclose(struct irlap_cb *self, IRLAP_EVENT event, =

-			      struct sk_buff *skb, struct irlap_info *info)=20
+static int irlap_state_pclose(struct irlap_cb *self, IRLAP_EVENT event,
+			      struct sk_buff *skb, struct irlap_info *info)
 {
 	int ret =3D 0;
=20
 	IRDA_DEBUG(1, __FUNCTION__ "()\n");
-=09
+
 	ASSERT(self !=3D NULL, return -1;);
-	ASSERT(self->magic =3D=3D LAP_MAGIC, return -1;);=09
+	ASSERT(self->magic =3D=3D LAP_MAGIC, return -1;);
=20
 	switch (event) {
 	case RECV_UA_RSP: /* FALLTHROUGH */
@@ -1101,7 +1101,7 @@
=20
 		/* Always switch state before calling upper layers */
 		irlap_next_state(self, LAP_NDM);
-	=09
+
 		irlap_disconnect_indication(self, LAP_DISC_INDICATION);
 		break;
 	case FINAL_TIMER_EXPIRED:
@@ -1124,7 +1124,7 @@
 		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %d\n", event);
=20
 		ret =3D -1;
-		break;=09
+		break;
 	}
 	return ret;
 }
@@ -1138,8 +1138,8 @@
  *   transmit any frames and is expecting to receive frames only from th=
e
  *   secondary to which transmission permissions has been given.
  */
-static int irlap_state_nrm_p(struct irlap_cb *self, IRLAP_EVENT event,=20
-			     struct sk_buff *skb, struct irlap_info *info)=20
+static int irlap_state_nrm_p(struct irlap_cb *self, IRLAP_EVENT event,
+			     struct sk_buff *skb, struct irlap_info *info)
 {
 	int ret =3D 0;
 	int ns_status;
@@ -1149,7 +1149,7 @@
 	case RECV_I_RSP: /* Optimize for the common case */
 		/* FIXME: must check for remote_busy below */
 #ifdef CONFIG_IRDA_FAST_RR
-		/*=20
+		/*
 		 *  Reset the fast_RR so we can use the fast RR code with
 		 *  full speed the next time since peer may have more frames
 		 *  to transmitt
@@ -1161,19 +1161,19 @@
 		ns_status =3D irlap_validate_ns_received(self, info->ns);
 		nr_status =3D irlap_validate_nr_received(self, info->nr);
=20
-		/*=20
+		/*
 		 *  Check for expected I(nformation) frame
 		 */
 		if ((ns_status =3D=3D NS_EXPECTED) && (nr_status =3D=3D NR_EXPECTED)) =
{
 			/*  poll bit cleared?  */
 			if (!info->pf) {
 				self->vr =3D (self->vr + 1) % 8;
-		=09
+
 				/* Update Nr received */
 				irlap_update_nr_received( self, info->nr);
-			=09
+
 				self->ack_required =3D TRUE;
-			=09
+
 				/* Keep state, do not move this line */
 				irlap_next_state(self, LAP_NRM_P);
=20
@@ -1182,18 +1182,18 @@
 				del_timer(&self->final_timer);
=20
 				self->vr =3D (self->vr + 1) % 8;
-		=09
+
 				/* Update Nr received */
 				irlap_update_nr_received(self, info->nr);
-	=09
-				/* =20
+
+				/*
 				 *  Got expected NR, so reset the
 				 *  retry_count. This is not done by IrLAP,
-				 *  which is strange! =20
+				 *  which is strange!
 				 */
 				self->retry_count =3D 0;
 				self->ack_required =3D TRUE;
-		=09
+
 				irlap_wait_min_turn_around(self, &self->qos_tx);
=20
 				/* Call higher layer *before* changing state
@@ -1218,16 +1218,16 @@
 				irlap_start_poll_timer(self, self->poll_timeout);
 			}
 			break;
-		=09
+
 		}
 		/* Unexpected next to send (Ns) */
 		if ((ns_status =3D=3D NS_UNEXPECTED) && (nr_status =3D=3D NR_EXPECTED)=
)
 		{
 			if (!info->pf) {
 				irlap_update_nr_received(self, info->nr);
-			=09
+
 				/*
-				 *  Wait until the last frame before doing=20
+				 *  Wait until the last frame before doing
 				 *  anything
 				 */
=20
@@ -1236,57 +1236,57 @@
 			} else {
 				IRDA_DEBUG(4, __FUNCTION__
 				       "(), missing or duplicate frame!\n");
-			=09
+
 				/* Update Nr received */
 				irlap_update_nr_received(self, info->nr);
-			=09
+
 				irlap_wait_min_turn_around(self, &self->qos_tx);
 				irlap_send_rr_frame(self, CMD_FRAME);
-			=09
+
 				self->ack_required =3D FALSE;
-		=09
+
 				irlap_start_final_timer(self, self->final_timeout);
 				irlap_next_state(self, LAP_NRM_P);
 			}
 			break;
 		}
-		/*=20
-		 *  Unexpected next to receive (Nr)=20
+		/*
+		 *  Unexpected next to receive (Nr)
 		 */
 		if ((ns_status =3D=3D NS_EXPECTED) && (nr_status =3D=3D NR_UNEXPECTED)=
)
 		{
 			if (info->pf) {
 				self->vr =3D (self->vr + 1) % 8;
-		=09
+
 				/* Update Nr received */
 				irlap_update_nr_received(self, info->nr);
-		=09
+
 				/* Resend rejected frames */
 				irlap_resend_rejected_frames(self, CMD_FRAME);
-			=09
+
 				self->ack_required =3D FALSE;
 				irlap_start_final_timer(self, self->final_timeout);
-			=09
+
 				/* Keep state, do not move this line */
 				irlap_next_state(self, LAP_NRM_P);
=20
 				irlap_data_indication(self, skb, FALSE);
 			} else {
-				/*=20
+				/*
 				 *  Do not resend frames until the last
 				 *  frame has arrived from the other
 				 *  device. This is not documented in
-				 *  IrLAP!! =20
+				 *  IrLAP!!
 				 */
 				self->vr =3D (self->vr + 1) % 8;
=20
 				/* Update Nr received */
 				irlap_update_nr_received(self, info->nr);
-			=09
+
 				self->ack_required =3D FALSE;
=20
 				/* Keep state, do not move this line!*/
-				irlap_next_state(self, LAP_NRM_P);=20
+				irlap_next_state(self, LAP_NRM_P);
=20
 				irlap_data_indication(self, skb, FALSE);
 			}
@@ -1296,15 +1296,15 @@
 		 *  Unexpected next to send (Ns) and next to receive (Nr)
 		 *  Not documented by IrLAP!
 		 */
-		if ((ns_status =3D=3D NS_UNEXPECTED) &&=20
-		    (nr_status =3D=3D NR_UNEXPECTED))=20
+		if ((ns_status =3D=3D NS_UNEXPECTED) &&
+		    (nr_status =3D=3D NR_UNEXPECTED))
 		{
-			IRDA_DEBUG(4, __FUNCTION__=20
+			IRDA_DEBUG(4, __FUNCTION__
 				   "(), unexpected nr and ns!\n");
 			if (info->pf) {
 				/* Resend rejected frames */
 				irlap_resend_rejected_frames(self, CMD_FRAME);
-			=09
+
 				/* Give peer some time to retransmit! */
 				irlap_start_final_timer(self, self->final_timeout);
=20
@@ -1313,7 +1313,7 @@
 			} else {
 				/* Update Nr received */
 				/* irlap_update_nr_received( info->nr); */
-			=09
+
 				self->ack_required =3D FALSE;
 			}
 			break;
@@ -1325,23 +1325,23 @@
 		if ((nr_status =3D=3D NR_INVALID) || (ns_status =3D=3D NS_INVALID)) {
 			if (info->pf) {
 				del_timer(&self->final_timer);
-			=09
+
 				irlap_next_state(self, LAP_RESET_WAIT);
-			=09
+
 				irlap_disconnect_indication(self, LAP_RESET_INDICATION);
 				self->xmitflag =3D TRUE;
 			} else {
 				del_timer(&self->final_timer);
-			=09
+
 				irlap_disconnect_indication(self, LAP_RESET_INDICATION);
-			=09
+
 				self->xmitflag =3D FALSE;
 			}
 			break;
 		}
 		IRDA_DEBUG(1, __FUNCTION__ "(), Not implemented!\n");
-		IRDA_DEBUG(1, __FUNCTION__=20
-		      "(), event=3D%s, ns_status=3D%d, nr_status=3D%d\n",=20
+		IRDA_DEBUG(1, __FUNCTION__
+		      "(), event=3D%s, ns_status=3D%d, nr_status=3D%d\n",
 		      irlap_event[ event], ns_status, nr_status);
 		break;
 	case RECV_UI_FRAME:
@@ -1353,34 +1353,34 @@
 			del_timer(&self->final_timer);
 			irlap_data_indication(self, skb, TRUE);
 			irlap_next_state(self, LAP_XMIT_P);
-			printk(__FUNCTION__ "(): RECV_UI_FRAME: next state %s\n", irlap_state=
[self->state]);
+			printk("%s: RECV_UI_FRAME: next state %s\n", __FUNCTION__, irlap_stat=
e[self->state]);
 			irlap_start_poll_timer(self, self->poll_timeout);
 		}
 		break;
 	case RECV_RR_RSP:
-		/* =20
-		 *  If you get a RR, the remote isn't busy anymore,=20
-		 *  no matter what the NR=20
+		/*
+		 *  If you get a RR, the remote isn't busy anymore,
+		 *  no matter what the NR
 		 */
 		self->remote_busy =3D FALSE;
=20
-		/*=20
-		 *  Nr as expected?=20
+		/*
+		 *  Nr as expected?
 		 */
 		ret =3D irlap_validate_nr_received(self, info->nr);
-		if (ret =3D=3D NR_EXPECTED) {=09
+		if (ret =3D=3D NR_EXPECTED) {
 			/* Stop final timer */
 			del_timer(&self->final_timer);
-		=09
+
 			/* Update Nr received */
 			irlap_update_nr_received(self, info->nr);
-		=09
+
 			/*
-			 *  Got expected NR, so reset the retry_count. This=20
-			 *  is not done by the IrLAP standard , which is=20
+			 *  Got expected NR, so reset the retry_count. This
+			 *  is not done by the IrLAP standard , which is
 			 *  strange! DB.
 			 */
-			self->retry_count =3D 0;		=09
+			self->retry_count =3D 0;
 			irlap_wait_min_turn_around(self, &self->qos_tx);
=20
 			irlap_next_state(self, LAP_XMIT_P);
@@ -1388,22 +1388,22 @@
 			/* Start poll timer */
 			irlap_start_poll_timer(self, self->poll_timeout);
 		} else if (ret =3D=3D NR_UNEXPECTED) {
-			ASSERT(info !=3D NULL, return -1;);=09
-			/*=20
-			 *  Unexpected nr!=20
+			ASSERT(info !=3D NULL, return -1;);
+			/*
+			 *  Unexpected nr!
 			 */
-		=09
+
 			/* Update Nr received */
 			irlap_update_nr_received(self, info->nr);
=20
 			IRDA_DEBUG(4, "RECV_RR_FRAME: Retrans:%d, nr=3D%d, va=3D%d, "
 			      "vs=3D%d, vr=3D%d\n",
-			      self->retry_count, info->nr, self->va,=20
+			      self->retry_count, info->nr, self->va,
 			      self->vs, self->vr);
-		=09
+
 			/* Resend rejected frames */
 			irlap_resend_rejected_frames(self, CMD_FRAME);
-		=09
+
 			irlap_next_state(self, LAP_NRM_P);
 		} else if (ret =3D=3D NR_INVALID) {
 			IRDA_DEBUG(1, __FUNCTION__ "(), Received RR with "
@@ -1426,7 +1426,7 @@
 		/* Update Nr received */
 		irlap_update_nr_received(self, info->nr);
 		irlap_next_state(self, LAP_XMIT_P);
-		=09
+
 		/* Start poll timer */
 		irlap_start_poll_timer(self, self->poll_timeout);
 		break;
@@ -1437,7 +1437,7 @@
 		irlap_reset_indication(self);
 		break;
 	case FINAL_TIMER_EXPIRED:
-		/*=20
+		/*
 		 *  We are allowed to wait for additional 300 ms if
 		 *  final timer expires when we are in the middle
 		 *  of receiving a frame (page 45, IrLAP). Check that
@@ -1449,8 +1449,8 @@
 			irlap_start_final_timer(self, MSECS_TO_JIFFIES(300));
=20
 			/*
-			 *  Don't allow this to happen one more time in a row,=20
-			 *  or else we can get a pretty tight loop here if=20
+			 *  Don't allow this to happen one more time in a row,
+			 *  or else we can get a pretty tight loop here if
 			 *  if we only receive half a frame. DB.
 			 */
 			self->add_wait =3D TRUE;
@@ -1463,9 +1463,9 @@
 			/* Retry sending the pf bit to the secondary */
 			irlap_wait_min_turn_around(self, &self->qos_tx);
 			irlap_send_rr_frame(self, CMD_FRAME);
-		=09
+
 			irlap_start_final_timer(self, self->final_timeout);
-		 	self->retry_count++;
+			self->retry_count++;
 			IRDA_DEBUG(4, "irlap_state_nrm_p: FINAL_TIMER_EXPIRED:"
 				   " retry_count=3D%d\n", self->retry_count);
=20
@@ -1515,7 +1515,7 @@
 		irlap_disconnect_request(self);
 		break;
 	default:
-		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %s\n",=20
+		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %s\n",
 			   irlap_event[event]);
=20
 		ret =3D -1;
@@ -1531,16 +1531,16 @@
  *    awaiting reset of disconnect request.
  *
  */
-static int irlap_state_reset_wait(struct irlap_cb *self, IRLAP_EVENT eve=
nt,=20
+static int irlap_state_reset_wait(struct irlap_cb *self, IRLAP_EVENT eve=
nt,
 				  struct sk_buff *skb, struct irlap_info *info)
 {
 	int ret =3D 0;
-=09
+
 	IRDA_DEBUG(3, __FUNCTION__ "(), event =3D %s\n", irlap_event[event]);
-=09
+
 	ASSERT(self !=3D NULL, return -1;);
 	ASSERT(self->magic =3D=3D LAP_MAGIC, return -1;);
-=09
+
 	switch (event) {
 	case RESET_REQUEST:
 		if (self->xmitflag) {
@@ -1562,11 +1562,11 @@
 		irlap_next_state( self, LAP_PCLOSE);
 		break;
 	default:
-		IRDA_DEBUG(2, __FUNCTION__ "(), Unknown event %s\n",=20
+		IRDA_DEBUG(2, __FUNCTION__ "(), Unknown event %s\n",
 			   irlap_event[event]);
=20
 		ret =3D -1;
-		break;=09
+		break;
 	}
 	return ret;
 }
@@ -1578,16 +1578,16 @@
  *    reply.
  *
  */
-static int irlap_state_reset(struct irlap_cb *self, IRLAP_EVENT event,=20
+static int irlap_state_reset(struct irlap_cb *self, IRLAP_EVENT event,
 			     struct sk_buff *skb, struct irlap_info *info)
 {
 	int ret =3D 0;
-=09
+
 	IRDA_DEBUG(3, __FUNCTION__ "(), event =3D %s\n", irlap_event[event]);
-=09
+
 	ASSERT(self !=3D NULL, return -1;);
 	ASSERT(self->magic =3D=3D LAP_MAGIC, return -1;);
-=09
+
 	switch (event) {
 	case RECV_DISC_CMD:
 		del_timer(&self->final_timer);
@@ -1602,12 +1602,12 @@
 		break;
 	case RECV_UA_RSP:
 		del_timer(&self->final_timer);
-	=09
+
 		/* Initiate connection state */
 		irlap_initiate_connection_state(self);
-	=09
+
 		irlap_reset_confirm();
-	=09
+
 		self->remote_busy =3D FALSE;
=20
 		irlap_next_state(self, LAP_XMIT_P);
@@ -1628,16 +1628,16 @@
 			irlap_next_state(self, LAP_RESET);
 		} else if (self->retry_count >=3D self->N3) {
 			irlap_apply_default_connection_parameters(self);
-		=09
+
 			/* Always switch state before calling upper layers */
 			irlap_next_state(self, LAP_NDM);
-		=09
+
 			irlap_disconnect_indication(self, LAP_NO_RESPONSE);
 		}
 		break;
 	case RECV_SNRM_CMD:
-		/*=20
-		 * SNRM frame is not allowed to contain an I-field in this=20
+		/*
+		 * SNRM frame is not allowed to contain an I-field in this
 		 * state
 		 */
 		if (!info) {
@@ -1649,47 +1649,47 @@
 			irlap_start_wd_timer(self, self->wd_timeout);
 			irlap_next_state(self, LAP_NDM);
 		} else {
-			IRDA_DEBUG(0, __FUNCTION__=20
+			IRDA_DEBUG(0, __FUNCTION__
 				   "(), SNRM frame contained an I field!\n");
 		}
 		break;
 	default:
-		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %s\n",=20
-			   irlap_event[event]);=09
+		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %s\n",
+			   irlap_event[event]);
=20
 		ret =3D -1;
-		break;=09
+		break;
 	}
 	return ret;
 }
=20
 /*
  * Function irlap_state_xmit_s (event, skb, info)
- *=20
+ *
  *   XMIT_S, The secondary station has been given the right to transmit,=

  *   and we therefor do not expect to receive any transmissions from oth=
er
- *   stations. =20
+ *   stations.
  */
-static int irlap_state_xmit_s(struct irlap_cb *self, IRLAP_EVENT event, =

-			      struct sk_buff *skb, struct irlap_info *info)=20
+static int irlap_state_xmit_s(struct irlap_cb *self, IRLAP_EVENT event,
+			      struct sk_buff *skb, struct irlap_info *info)
 {
 	int ret =3D 0;
-=09
-	IRDA_DEBUG(4, __FUNCTION__ "(), event=3D%s\n", irlap_event[event]);=20
+
+	IRDA_DEBUG(4, __FUNCTION__ "(), event=3D%s\n", irlap_event[event]);
=20
 	ASSERT(self !=3D NULL, return -ENODEV;);
 	ASSERT(self->magic =3D=3D LAP_MAGIC, return -EBADR;);
-=09
+
 	switch (event) {
 	case SEND_I_CMD:
 		/*
 		 *  Send frame only if send window > 1
-		 */=20
+		 */
 		if ((self->window > 0) && (!self->remote_busy)) {
 #ifdef CONFIG_IRDA_DYNAMIC_WINDOW
 			/*
-			 *  Test if we have transmitted more bytes over the=20
-			 *  link than its possible to do with the current=20
+			 *  Test if we have transmitted more bytes over the
+			 *  link than its possible to do with the current
 			 *  speed and turn-around-time.
 			 */
 			if (skb->len > self->bytes_left) {
@@ -1697,7 +1697,7 @@
=20
 				/*
 				 *  Switch to NRM_S, this is only possible
-				 *  when we are in secondary mode, since we=20
+				 *  when we are in secondary mode, since we
 				 *  must be sure that we don't miss any RR
 				 *  frames
 				 */
@@ -1715,18 +1715,18 @@
 			 *  Send data with final bit cleared only if window > 1
 			 *  and there is more frames to be sent
 			 */
-			if ((self->window > 1) &&=20
-			    skb_queue_len(&self->txq) > 0)=20
-			{  =20
+			if ((self->window > 1) &&
+			    skb_queue_len(&self->txq) > 0)
+			{
 				irlap_send_data_secondary(self, skb);
 				irlap_next_state(self, LAP_XMIT_S);
 			} else {
 				irlap_send_data_secondary_final(self, skb);
 				irlap_next_state(self, LAP_NRM_S);
=20
-				/*=20
+				/*
 				 * Make sure state machine does not try to send
-				 * any more frames=20
+				 * any more frames
 				 */
 				ret =3D -EPROTO;
 			}
@@ -1747,7 +1747,7 @@
 		 * when we return... - Jean II */
 		break;
 	default:
-		IRDA_DEBUG(2, __FUNCTION__ "(), Unknown event %s\n",=20
+		IRDA_DEBUG(2, __FUNCTION__ "(), Unknown event %s\n",
 			   irlap_event[event]);
=20
 		ret =3D -EINVAL;
@@ -1759,12 +1759,12 @@
 /*
  * Function irlap_state_nrm_s (event, skb, info)
  *
- *    NRM_S (Normal Response Mode as Secondary) state, in this state we =
are=20
+ *    NRM_S (Normal Response Mode as Secondary) state, in this state we =
are
  *    expecting to receive frames from the primary station
  *
  */
-static int irlap_state_nrm_s(struct irlap_cb *self, IRLAP_EVENT event,=20
-			     struct sk_buff *skb, struct irlap_info *info)=20
+static int irlap_state_nrm_s(struct irlap_cb *self, IRLAP_EVENT event,
+			     struct sk_buff *skb, struct irlap_info *info)
 {
 	int ns_status;
 	int nr_status;
@@ -1779,28 +1779,28 @@
 	case RECV_I_CMD: /* Optimize for the common case */
 		/* FIXME: must check for remote_busy below */
 		IRDA_DEBUG(4, __FUNCTION__ "(), event=3D%s nr=3D%d, vs=3D%d, ns=3D%d, =
"
-			   "vr=3D%d, pf=3D%d\n", irlap_event[event], info->nr,=20
+			   "vr=3D%d, pf=3D%d\n", irlap_event[event], info->nr,
 			   self->vs, info->ns, self->vr, info->pf);
=20
 		self->retry_count =3D 0;
=20
 		ns_status =3D irlap_validate_ns_received(self, info->ns);
 		nr_status =3D irlap_validate_nr_received(self, info->nr);
-		/*=20
+		/*
 		 *  Check for expected I(nformation) frame
 		 */
 		if ((ns_status =3D=3D NS_EXPECTED) && (nr_status =3D=3D NR_EXPECTED)) =
{
-			/*=20
+			/*
 			 *  poll bit cleared?
 			 */
 			if (!info->pf) {
 				self->vr =3D (self->vr + 1) % 8;
-			=09
+
 				/* Update Nr received */
 				irlap_update_nr_received(self, info->nr);
-			=09
+
 				self->ack_required =3D TRUE;
-			=09
+
 				/*
 				 *  Starting WD-timer here is optional, but
 				 *  not recommended. Note 6 IrLAP p. 83
@@ -1815,18 +1815,18 @@
 				break;
 			} else {
 				self->vr =3D (self->vr + 1) % 8;
-			=09
+
 				/* Update Nr received */
 				irlap_update_nr_received(self, info->nr);
-			=09
-				/*=20
+
+				/*
 				 *  We should wait before sending RR, and
 				 *  also before changing to XMIT_S
-				 *  state. (note 1, IrLAP p. 82)=20
+				 *  state. (note 1, IrLAP p. 82)
 				 */
 				irlap_wait_min_turn_around(self, &self->qos_tx);
=20
-				/* =20
+				/*
 				 * Give higher layers a chance to
 				 * immediately reply with some data before
 				 * we decide if we should send a RR frame
@@ -1835,17 +1835,17 @@
 				irlap_data_indication(self, skb, FALSE);
=20
 				/* Any pending data requests?  */
-				if ((skb_queue_len(&self->txq) > 0) &&=20
-				    (self->window > 0))=20
+				if ((skb_queue_len(&self->txq) > 0) &&
+				    (self->window > 0))
 				{
 					self->ack_required =3D TRUE;
-				=09
+
 					del_timer(&self->wd_timer);
-				=09
+
 					irlap_next_state(self, LAP_XMIT_S);
 				} else {
 					irlap_send_rr_frame(self, RSP_FRAME);
-					irlap_start_wd_timer(self,=20
+					irlap_start_wd_timer(self,
 							     self->wd_timeout);
=20
 					/* Keep the state */
@@ -1862,33 +1862,33 @@
 			/* Unexpected next to send, with final bit cleared */
 			if (!info->pf) {
 				irlap_update_nr_received(self, info->nr);
-			=09
+
 				irlap_start_wd_timer(self, self->wd_timeout);
 			} else {
 				/* Update Nr received */
 				irlap_update_nr_received(self, info->nr);
-		=09
+
 				irlap_wait_min_turn_around(self, &self->qos_tx);
 				irlap_send_rr_frame(self, CMD_FRAME);
-		=09
+
 				irlap_start_wd_timer(self, self->wd_timeout);
 			}
 			break;
 		}
=20
-		/*=20
+		/*
 		 *  Unexpected Next to Receive(NR) ?
 		 */
 		if ((ns_status =3D=3D NS_EXPECTED) && (nr_status =3D=3D NR_UNEXPECTED)=
)
 		{
 			if (info->pf) {
 				IRDA_DEBUG(4, "RECV_I_RSP: frame(s) lost\n");
-			=09
+
 				self->vr =3D (self->vr + 1) % 8;
-			=09
+
 				/* Update Nr received */
 				irlap_update_nr_received(self, info->nr);
-			=09
+
 				/* Resend rejected frames */
 				irlap_resend_rejected_frames(self, RSP_FRAME);
=20
@@ -1905,10 +1905,10 @@
 			 */
 			if (!info->pf) {
 				self->vr =3D (self->vr + 1) % 8;
-			=09
+
 				/* Update Nr received */
 				irlap_update_nr_received(self, info->nr);
-			=09
+
 				/* Keep state, do not move this line */
 				irlap_next_state(self, LAP_NRM_S);
=20
@@ -1917,7 +1917,7 @@
 			}
 			break;
 		}
-	=09
+
 		if (ret =3D=3D NR_INVALID) {
 			IRDA_DEBUG(0, "NRM_S, NR_INVALID not implemented!\n");
 		}
@@ -1926,7 +1926,7 @@
 		}
 		break;
 	case RECV_UI_FRAME:
-		/*=20
+		/*
 		 *  poll bit cleared?
 		 */
 		if (!info->pf) {
@@ -1936,11 +1936,11 @@
 			/*
 			 *  Any pending data requests?
 			 */
-			if ((skb_queue_len(&self->txq) > 0) &&=20
-			    (self->window > 0) && !self->remote_busy)=20
+			if ((skb_queue_len(&self->txq) > 0) &&
+			    (self->window > 0) && !self->remote_busy)
 			{
 				irlap_data_indication(self, skb, TRUE);
-			=09
+
 				del_timer(&self->wd_timer);
=20
 				irlap_next_state(self, LAP_XMIT_S);
@@ -1951,7 +1951,7 @@
=20
 				irlap_send_rr_frame(self, RSP_FRAME);
 				self->ack_required =3D FALSE;
-			=09
+
 				irlap_start_wd_timer(self, self->wd_timeout);
=20
 				/* Keep the state */
@@ -1962,28 +1962,28 @@
 	case RECV_RR_CMD:
 		self->retry_count =3D 0;
=20
-		/*=20
-		 *  Nr as expected?=20
+		/*
+		 *  Nr as expected?
 		 */
 		nr_status =3D irlap_validate_nr_received(self, info->nr);
 		if (nr_status =3D=3D NR_EXPECTED) {
-			if ((skb_queue_len( &self->txq) > 0) &&=20
+			if ((skb_queue_len( &self->txq) > 0) &&
 			    (self->window > 0)) {
 				self->remote_busy =3D FALSE;
-			=09
+
 				/* Update Nr received */
 				irlap_update_nr_received(self, info->nr);
 				del_timer(&self->wd_timer);
-			=09
+
 				irlap_wait_min_turn_around(self, &self->qos_tx);
 				irlap_next_state(self, LAP_XMIT_S);
-			} else {		=09
+			} else {
 				self->remote_busy =3D FALSE;
 				/* Update Nr received */
 				irlap_update_nr_received(self, info->nr);
 				irlap_wait_min_turn_around(self, &self->qos_tx);
 				irlap_start_wd_timer(self, self->wd_timeout);
-			=09
+
 				/* Note : if the link is idle (this case),
 				 * we never go in XMIT_S, so we never get a
 				 * chance to process any DISCONNECT_REQUEST.
@@ -1997,7 +1997,7 @@
 				} else {
 					/* Just send back pf bit */
 					irlap_send_rr_frame(self, RSP_FRAME);
-			=09
+
 					irlap_next_state(self, LAP_NRM_S);
 				}
 			}
@@ -2009,11 +2009,11 @@
 			irlap_start_wd_timer(self, self->wd_timeout);
=20
 			/* Keep state */
-			irlap_next_state(self, LAP_NRM_S);=20
+			irlap_next_state(self, LAP_NRM_S);
 		} else {
-			IRDA_DEBUG(1, __FUNCTION__=20
+			IRDA_DEBUG(1, __FUNCTION__
 				   "(), invalid nr not implemented!\n");
-		}=20
+		}
 		break;
 	case RECV_SNRM_CMD:
 		/* SNRM frame is not allowed to contain an I-field */
@@ -2021,12 +2021,12 @@
 			del_timer(&self->wd_timer);
 			IRDA_DEBUG(1, __FUNCTION__ "(), received SNRM cmd\n");
 			irlap_next_state(self, LAP_RESET_CHECK);
-		=09
+
 			irlap_reset_indication(self);
 		} else {
-			IRDA_DEBUG(0, __FUNCTION__=20
+			IRDA_DEBUG(0, __FUNCTION__
 				   "(), SNRM frame contained an I-field!\n");
-		=09
+
 		}
 		break;
 	case RECV_REJ_CMD:
@@ -2057,7 +2057,7 @@
 		 *   which explain why we use (self->N2 / 2) here !!!
 		 * Jean II
 		 */
-		IRDA_DEBUG(1, __FUNCTION__ "(), retry_count =3D %d\n",=20
+		IRDA_DEBUG(1, __FUNCTION__ "(), retry_count =3D %d\n",
 			   self->retry_count);
=20
 		if (self->retry_count < (self->N2 / 2)) {
@@ -2070,7 +2070,7 @@
 							STATUS_NO_ACTIVITY);
 		} else {
 			irlap_apply_default_connection_parameters(self);
-		=09
+
 			/* Always switch state before calling upper layers */
 			irlap_next_state(self, LAP_NDM);
 			irlap_disconnect_indication(self, LAP_NO_RESPONSE);
@@ -2110,7 +2110,7 @@
 		irlap_send_test_frame(self, self->caddr, info->daddr, skb);
 		break;
 	default:
-		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %d, (%s)\n",=20
+		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %d, (%s)\n",
 			   event, irlap_event[event]);
=20
 		ret =3D -EINVAL;
@@ -2121,12 +2121,9 @@
=20
 /*
  * Function irlap_state_sclose (self, event, skb, info)
- *
- *   =20
- *
  */
-static int irlap_state_sclose(struct irlap_cb *self, IRLAP_EVENT event, =

-			      struct sk_buff *skb, struct irlap_info *info)=20
+static int irlap_state_sclose(struct irlap_cb *self, IRLAP_EVENT event,
+			      struct sk_buff *skb, struct irlap_info *info)
 {
 	int ret =3D 0;
=20
@@ -2134,7 +2131,7 @@
=20
 	ASSERT(self !=3D NULL, return -ENODEV;);
 	ASSERT(self->magic =3D=3D LAP_MAGIC, return -EBADR;);
-=09
+
 	switch (event) {
 	case RECV_DISC_CMD:
 		/* Always switch state before calling upper layers */
@@ -2156,7 +2153,7 @@
=20
 		del_timer(&self->wd_timer);
 		irlap_apply_default_connection_parameters(self);
-	=09
+
 		irlap_disconnect_indication(self, LAP_DISC_INDICATION);
 		break;
 	case WD_TIMER_EXPIRED:
@@ -2164,11 +2161,11 @@
 		irlap_next_state(self, LAP_NDM);
=20
 		irlap_apply_default_connection_parameters(self);
-	=09
+
 		irlap_disconnect_indication(self, LAP_DISC_INDICATION);
 		break;
 	default:
-		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %d, (%s)\n",=20
+		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %d, (%s)\n",
 			   event, irlap_event[event]);
=20
 		ret =3D -EINVAL;
@@ -2178,24 +2175,24 @@
 	return -1;
 }
=20
-static int irlap_state_reset_check( struct irlap_cb *self, IRLAP_EVENT e=
vent,=20
-				   struct sk_buff *skb,=20
-				   struct irlap_info *info)=20
+static int irlap_state_reset_check( struct irlap_cb *self, IRLAP_EVENT e=
vent,
+				   struct sk_buff *skb,
+				   struct irlap_info *info)
 {
 	int ret =3D 0;
=20
-	IRDA_DEBUG(1, __FUNCTION__ "(), event=3D%s\n", irlap_event[event]);=20
+	IRDA_DEBUG(1, __FUNCTION__ "(), event=3D%s\n", irlap_event[event]);
=20
 	ASSERT(self !=3D NULL, return -ENODEV;);
 	ASSERT(self->magic =3D=3D LAP_MAGIC, return -EBADR;);
-=09
+
 	switch (event) {
 	case RESET_RESPONSE:
 		irlap_send_ua_response_frame(self, &self->qos_rx);
 		irlap_initiate_connection_state(self);
 		irlap_start_wd_timer(self, WD_TIMEOUT);
 		irlap_flush_all_queues(self);
-	=09
+
 		irlap_next_state(self, LAP_NRM_S);
 		break;
 	case DISCONNECT_REQUEST:
@@ -2205,7 +2202,7 @@
 		irlap_next_state(self, LAP_SCLOSE);
 		break;
 	default:
-		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %d, (%s)\n",=20
+		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %d, (%s)\n",
 			   event, irlap_event[event]);
=20
 		ret =3D -EINVAL;

--------------040102090908000707060909--

