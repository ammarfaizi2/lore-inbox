Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313125AbSFJMgT>; Mon, 10 Jun 2002 08:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313202AbSFJMgS>; Mon, 10 Jun 2002 08:36:18 -0400
Received: from [195.63.194.11] ([195.63.194.11]:11015 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313125AbSFJMgA>; Mon, 10 Jun 2002 08:36:00 -0400
Message-ID: <3D048F6E.20206@evision-ventures.com>
Date: Mon, 10 Jun 2002 13:37:18 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.21 kill warnings 7/19
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------020708030909000801090205"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020708030909000801090205
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

- Fix improper __FUNCTION__ usage in af_irda.c

- Fix redundant white space usage there - I couldn't resist.

--------------020708030909000801090205
Content-Type: text/plain;
 name="warn-2.5.21-7.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="warn-2.5.21-7.diff"

diff -urN linux-2.5.21/net/irda/af_irda.c linux/net/irda/af_irda.c
--- linux-2.5.21/net/irda/af_irda.c	2002-06-09 07:28:46.000000000 +0200
+++ linux/net/irda/af_irda.c	2002-06-09 20:46:21.000000000 +0200
@@ -1,5 +1,5 @@
 /*********************************************************************
- *                
+ *
  * Filename:      af_irda.c
  * Version:       0.9
  * Description:   IrDA sockets implementation
@@ -9,37 +9,37 @@
  * Modified at:   Sat Dec 25 21:10:23 1999
  * Modified by:   Dag Brattli <dag@brattli.net>
  * Sources:       af_netroom.c, af_ax25.c, af_rose.c, af_x25.c etc.
- * 
+ *
  *     Copyright (c) 1999 Dag Brattli <dagb@cs.uit.no>
  *     Copyright (c) 1999-2001 Jean Tourrilhes <jt@hpl.hp.com>
  *     All Rights Reserved.
  *
- *     This program is free software; you can redistribute it and/or 
- *     modify it under the terms of the GNU General Public License as 
- *     published by the Free Software Foundation; either version 2 of 
+ *     This program is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of
  *     the License, or (at your option) any later version.
- * 
+ *
  *     This program is distributed in the hope that it will be useful,
  *     but WITHOUT ANY WARRANTY; without even the implied warranty of
  *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  *     GNU General Public License for more details.
- * 
- *     You should have received a copy of the GNU General Public License 
- *     along with this program; if not, write to the Free Software 
- *     Foundation, Inc., 59 Temple Place, Suite 330, Boston, 
+ *
+ *     You should have received a copy of the GNU General Public License
+ *     along with this program; if not, write to the Free Software
+ *     Foundation, Inc., 59 Temple Place, Suite 330, Boston,
  *     MA 02111-1307 USA
  *
  *     Linux-IrDA now supports four different types of IrDA sockets:
  *
  *     o SOCK_STREAM:    TinyTP connections with SAR disabled. The
  *                       max SDU size is 0 for conn. of this type
- *     o SOCK_SEQPACKET: TinyTP connections with SAR enabled. TTP may 
+ *     o SOCK_SEQPACKET: TinyTP connections with SAR enabled. TTP may
  *                       fragment the messages, but will preserve
  *                       the message boundaries
- *     o SOCK_DGRAM:     IRDAPROTO_UNITDATA: TinyTP connections with Unitdata 
+ *     o SOCK_DGRAM:     IRDAPROTO_UNITDATA: TinyTP connections with Unitdata
  *                       (unreliable) transfers
  *                       IRDAPROTO_ULTRA: Connectionless and unreliable data
- *     
+ *
  ********************************************************************/
 
 #include <linux/config.h>
@@ -67,7 +67,7 @@
 
 extern int  irda_init(void);
 extern void irda_cleanup(void);
-extern int  irlap_driver_rcv(struct sk_buff *, struct net_device *, 
+extern int  irlap_driver_rcv(struct sk_buff *, struct net_device *,
 			     struct packet_type *);
 
 static int irda_create(struct socket *sock, int protocol);
@@ -125,7 +125,7 @@
  *    Connection has been closed. Check reason to find out why
  *
  */
-static void irda_disconnect_indication(void *instance, void *sap, 
+static void irda_disconnect_indication(void *instance, void *sap,
 				       LM_REASON reason, struct sk_buff *skb)
 {
 	struct irda_sock *self;
@@ -185,9 +185,9 @@
  *    Connections has been confirmed by the remote device
  *
  */
-static void irda_connect_confirm(void *instance, void *sap, 
+static void irda_connect_confirm(void *instance, void *sap,
 				 struct qos_info *qos,
-				 __u32 max_sdu_size, __u8 max_header_size, 
+				 __u32 max_sdu_size, __u8 max_header_size,
 				 struct sk_buff *skb)
 {
 	struct irda_sock *self;
@@ -211,14 +211,14 @@
 	switch (sk->type) {
 	case SOCK_STREAM:
 		if (max_sdu_size != 0) {
-			ERROR(__FUNCTION__ "(), max_sdu_size must be 0\n");
+			ERROR("%s: max_sdu_size must be 0\n", __FUNCTION__);
 			return;
 		}
 		self->max_data_size = irttp_get_max_seg_size(self->tsap);
 		break;
 	case SOCK_SEQPACKET:
 		if (max_sdu_size == 0) {
-			ERROR(__FUNCTION__ "(), max_sdu_size cannot be 0\n");
+			ERROR("%s: max_sdu_size cannot be 0\n", __FUNCTION__);
 			return;
 		}
 		self->max_data_size = max_sdu_size;
@@ -227,7 +227,7 @@
 		self->max_data_size = irttp_get_max_seg_size(self->tsap);
 	};
 
-	IRDA_DEBUG(2, __FUNCTION__ "(), max_data_size=%d\n", 
+	IRDA_DEBUG(2, __FUNCTION__ "(), max_data_size=%d\n",
 		   self->max_data_size);
 
 	memcpy(&self->qos_tx, qos, sizeof(struct qos_info));
@@ -245,14 +245,14 @@
  *    Incoming connection
  *
  */
-static void irda_connect_indication(void *instance, void *sap, 
+static void irda_connect_indication(void *instance, void *sap,
 				    struct qos_info *qos, __u32 max_sdu_size,
 				    __u8 max_header_size, struct sk_buff *skb)
 {
 	struct irda_sock *self;
 	struct sock *sk;
 
- 	self = (struct irda_sock *) instance;
+	self = (struct irda_sock *) instance;
 
 	IRDA_DEBUG(2, __FUNCTION__ "(%p)\n", self);
 
@@ -264,20 +264,20 @@
 	self->max_header_size = max_header_size;
 
 	/* IrTTP max SDU size in transmit direction */
-	self->max_sdu_size_tx = max_sdu_size;	
+	self->max_sdu_size_tx = max_sdu_size;
 
 	/* Find out what the largest chunk of data that we can transmit is */
 	switch (sk->type) {
 	case SOCK_STREAM:
 		if (max_sdu_size != 0) {
-			ERROR(__FUNCTION__ "(), max_sdu_size must be 0\n");
+			ERROR("%s: max_sdu_size must be 0\n", __FUNCTION__);
 			return;
 		}
 		self->max_data_size = irttp_get_max_seg_size(self->tsap);
 		break;
 	case SOCK_SEQPACKET:
 		if (max_sdu_size == 0) {
-			ERROR(__FUNCTION__ "(), max_sdu_size cannot be 0\n");
+			ERROR("%s: max_sdu_size cannot be 0\n", __FUNCTION__);
 			return;
 		}
 		self->max_data_size = max_sdu_size;
@@ -286,11 +286,11 @@
 		self->max_data_size = irttp_get_max_seg_size(self->tsap);
 	};
 
-	IRDA_DEBUG(2, __FUNCTION__ "(), max_data_size=%d\n", 
+	IRDA_DEBUG(2, __FUNCTION__ "(), max_data_size=%d\n",
 		   self->max_data_size);
 
 	memcpy(&self->qos_tx, qos, sizeof(struct qos_info));
-	
+
 	skb_queue_tail(&sk->receive_queue, skb);
 	sk->state_change(sk);
 }
@@ -327,19 +327,19 @@
  *    Used by TinyTP to tell us if it can accept more data or not
  *
  */
-static void irda_flow_indication(void *instance, void *sap, LOCAL_FLOW flow) 
+static void irda_flow_indication(void *instance, void *sap, LOCAL_FLOW flow)
 {
 	struct irda_sock *self;
 	struct sock *sk;
 
 	IRDA_DEBUG(2, __FUNCTION__ "()\n");
-	
+
 	self = (struct irda_sock *) instance;
 	ASSERT(self != NULL, return;);
 
 	sk = self->sk;
 	ASSERT(sk != NULL, return;);
-	
+
 	switch (flow) {
 	case FLOW_STOP:
 		IRDA_DEBUG(1, __FUNCTION__ "(), IrTTP wants us to slow down\n");
@@ -347,7 +347,7 @@
 		break;
 	case FLOW_START:
 		self->tx_flow = flow;
-		IRDA_DEBUG(1, __FUNCTION__ 
+		IRDA_DEBUG(1, __FUNCTION__
 			   "(), IrTTP wants us to start again\n");
 		wake_up_interruptible(sk->sleep);
 		break;
@@ -367,14 +367,14 @@
  * Note : duplicate from above, but we need our own version that
  * doesn't touch the dtsap_sel and save the full value structure...
  */
-static void irda_getvalue_confirm(int result, __u16 obj_id, 
+static void irda_getvalue_confirm(int result, __u16 obj_id,
 					  struct ias_value *value, void *priv)
 {
 	struct irda_sock *self;
-	
+
 	self = (struct irda_sock *) priv;
 	if (!self) {
-		WARNING(__FUNCTION__ "(), lost myself!\n");
+		WARNING("%s: lost myself!\n", __FUNCTION__);
 		return;
 	}
 
@@ -419,12 +419,12 @@
 						void *priv)
 {
 	struct irda_sock *self;
-	
+
 	IRDA_DEBUG(2, __FUNCTION__ "()\n");
 
 	self = (struct irda_sock *) priv;
 	if (!self) {
-		WARNING(__FUNCTION__ "(), lost myself!\n");
+		WARNING("%s: lost myself!\n", __FUNCTION__);
 		return;
 	}
 
@@ -456,7 +456,7 @@
 static void irda_discovery_timeout(u_long priv)
 {
 	struct irda_sock *self;
-	
+
 	IRDA_DEBUG(2, __FUNCTION__ "()\n");
 
 	self = (struct irda_sock *) priv;
@@ -482,10 +482,10 @@
 	notify_t notify;
 
 	if (self->tsap) {
-		WARNING(__FUNCTION__ "(), busy!\n");
+		WARNING("%s: busy!\n", __FUNCTION__);
 		return -EBUSY;
 	}
-	
+
 	/* Initialize callbacks to be used by the IrDA stack */
 	irda_notify_init(&notify);
 	notify.connect_confirm       = irda_connect_confirm;
@@ -498,7 +498,7 @@
 	strncpy(notify.name, name, NOTIFY_MAX_NAME);
 
 	self->tsap = irttp_open_tsap(tsap_sel, DEFAULT_INITIAL_CREDIT,
-				     &notify);	
+				     &notify);
 	if (self->tsap == NULL) {
 		IRDA_DEBUG( 0, __FUNCTION__ "(), Unable to allocate TSAP!\n");
 		return -ENOMEM;
@@ -524,14 +524,14 @@
 		WARNING(__FUNCTION__ "(), busy!\n");
 		return -EBUSY;
 	}
-	
+
 	/* Initialize callbacks to be used by the IrDA stack */
 	irda_notify_init(&notify);
 	notify.udata_indication	= irda_data_indication;
 	notify.instance = self;
 	strncpy(notify.name, "Ultra", NOTIFY_MAX_NAME);
 
-	self->lsap = irlmp_open_lsap(LSAP_CONNLESS, &notify, pid);	
+	self->lsap = irlmp_open_lsap(LSAP_CONNLESS, &notify, pid);
 	if (self->lsap == NULL) {
 		IRDA_DEBUG( 0, __FUNCTION__ "(), Unable to allocate LSAP!\n");
 		return -ENOMEM;
@@ -559,7 +559,7 @@
 	ASSERT(self != NULL, return -1;);
 
 	if (self->iriap) {
-		WARNING(__FUNCTION__ "(), busy with a previous query\n");
+		WARNING("%s: busy with a previous query\n", __FUNCTION__);
 		return -EBUSY;
 	}
 
@@ -596,10 +596,10 @@
 	case IAS_INTEGER:
 		IRDA_DEBUG(4, __FUNCTION__ "() int=%d\n",
 			   self->ias_result->t.integer);
-		
+
 		if (self->ias_result->t.integer != -1)
 			self->dtsap_sel = self->ias_result->t.integer;
-		else 
+		else
 			self->dtsap_sel = 0;
 		break;
 	default:
@@ -655,7 +655,7 @@
 	if (discoveries == NULL)
 		return -ENETUNREACH;	/* No nodes discovered */
 
-	/* 
+	/*
 	 * Now, check all discovered devices (if any), and connect
 	 * client only about the services that the client is
 	 * interested in...
@@ -714,7 +714,7 @@
 	self->saddr = 0x0;
 	self->dtsap_sel = dtsap_sel;
 
-	IRDA_DEBUG(1, __FUNCTION__ 
+	IRDA_DEBUG(1, __FUNCTION__
 		   "(), discovered requested service ''%s'' at address %08x\n",
 		   name, self->daddr);
 
@@ -737,7 +737,7 @@
 	if (peer) {
 		if (sk->state != TCP_ESTABLISHED)
 			return -ENOTCONN;
-		
+
 		saddr.sir_family = AF_IRDA;
 		saddr.sir_lsap_sel = self->dtsap_sel;
 		saddr.sir_addr = self->daddr;
@@ -746,7 +746,7 @@
 		saddr.sir_lsap_sel = self->stsap_sel;
 		saddr.sir_addr = self->saddr;
 	}
-	
+
 	IRDA_DEBUG(1, __FUNCTION__ "(), tsap_sel = %#x\n", saddr.sir_lsap_sel);
 	IRDA_DEBUG(1, __FUNCTION__ "(), addr = %08x\n", saddr.sir_addr);
 
@@ -776,10 +776,10 @@
 	if (sk->state != TCP_LISTEN) {
 		sk->max_ack_backlog = backlog;
 		sk->state           = TCP_LISTEN;
-		
+
 		return 0;
 	}
-	
+
 	return -EOPNOTSUPP;
 }
 
@@ -808,14 +808,14 @@
 	if ((sk->type == SOCK_DGRAM) && (sk->protocol == IRDAPROTO_ULTRA)) {
 		self->pid = addr->sir_lsap_sel;
 		if (self->pid & 0x80) {
-			IRDA_DEBUG(0, __FUNCTION__ 
+			IRDA_DEBUG(0, __FUNCTION__
 				   "(), extension in PID not supp!\n");
 			return -EOPNOTSUPP;
 		}
 		err = irda_open_lsap(self, self->pid);
 		if (err < 0)
 			return err;
-		
+
 		self->max_data_size = ULTRA_MAX_DATA - LMP_PID_HEADER;
 		self->max_header_size = IRDA_MAX_HEADER + LMP_PID_HEADER;
 
@@ -830,13 +830,13 @@
 	err = irda_open_tsap(self, addr->sir_lsap_sel, addr->sir_name);
 	if (err < 0)
 		return err;
-	
+
 	/*  Register with LM-IAS */
 	self->ias_obj = irias_new_object(addr->sir_name, jiffies);
-	irias_add_integer_attrib(self->ias_obj, "IrDA:TinyTP:LsapSel", 
+	irias_add_integer_attrib(self->ias_obj, "IrDA:TinyTP:LsapSel",
 				 self->stsap_sel, IAS_KERNEL_ATTR);
 	irias_insert_object(self->ias_obj);
-	
+
 	return 0;
 }
 
@@ -872,7 +872,7 @@
 	    (sk->type != SOCK_DGRAM))
 		return -EOPNOTSUPP;
 
-	if (sk->state != TCP_LISTEN) 
+	if (sk->state != TCP_LISTEN)
 		return -EINVAL;
 
 	/*
@@ -921,7 +921,7 @@
 			return -ERESTARTSYS;
 	}
 
- 	newsk = newsock->sk;
+	newsk = newsock->sk;
 	newsk->state = TCP_ESTABLISHED;
 
 	new = irda_sk(newsk);
@@ -933,7 +933,7 @@
 		IRDA_DEBUG(0, __FUNCTION__ "(), dup failed!\n");
 		return -1;
 	}
-		
+
 	new->stsap_sel = new->tsap->stsap_sel;
 	new->dtsap_sel = new->tsap->dtsap_sel;
 	new->saddr = irttp_get_saddr(new->tsap);
@@ -988,7 +988,7 @@
 	struct sockaddr_irda *addr = (struct sockaddr_irda *) uaddr;
 	struct irda_sock *self = irda_sk(sk);
 	int err;
-	
+
 	IRDA_DEBUG(2, __FUNCTION__ "(%p)\n", self);
 
 	/* Don't allow connect for Ultra sockets */
@@ -999,16 +999,16 @@
 		sock->state = SS_CONNECTED;
 		return 0;   /* Connect completed during a ERESTARTSYS event */
 	}
-	
+
 	if (sk->state == TCP_CLOSE && sock->state == SS_CONNECTING) {
 		sock->state = SS_UNCONNECTED;
 		return -ECONNREFUSED;
 	}
-	
+
 	if (sk->state == TCP_ESTABLISHED)
 		return -EISCONN;      /* No reconnect on a seqpacket socket */
-	
-	sk->state   = TCP_CLOSE;	
+
+	sk->state   = TCP_CLOSE;
 	sock->state = SS_UNCONNECTED;
 
 	if (addr_len != sizeof(struct sockaddr_irda))
@@ -1019,7 +1019,7 @@
 		/* Try to find one suitable */
 		err = irda_discover_daddr_and_lsap_sel(self, addr->sir_name);
 		if (err) {
-			IRDA_DEBUG(0, __FUNCTION__ 
+			IRDA_DEBUG(0, __FUNCTION__
 				   "(), auto-connect failed!\n");
 			return err;
 		}
@@ -1027,7 +1027,7 @@
 		/* Use the one provided by the user */
 		self->daddr = addr->sir_addr;
 		IRDA_DEBUG(1, __FUNCTION__ "(), daddr = %08x\n", self->daddr);
-		
+
 		/* Query remote LM-IAS */
 		err = irda_find_lsap_sel(self, addr->sir_name);
 		if (err) {
@@ -1039,14 +1039,14 @@
 	/* Check if we have opened a local TSAP */
 	if (!self->tsap)
 		irda_open_tsap(self, LSAP_ANY, addr->sir_name);
-	
+
 	/* Move to connecting socket, start sending Connect Requests */
 	sock->state = SS_CONNECTING;
 	sk->state   = TCP_SYN_SENT;
 
 	/* Connect to remote device */
-	err = irttp_connect_request(self->tsap, self->dtsap_sel, 
-				    self->saddr, self->daddr, NULL, 
+	err = irttp_connect_request(self->tsap, self->dtsap_sel,
+				    self->saddr, self->daddr, NULL,
 				    self->max_sdu_size_rx, NULL);
 	if (err) {
 		IRDA_DEBUG(0, __FUNCTION__ "(), connect failed!\n");
@@ -1064,9 +1064,9 @@
 		sock->state = SS_UNCONNECTED;
 		return sock_error(sk);	/* Always set at this point */
 	}
-	
+
 	sock->state = SS_CONNECTED;
-	
+
 	/* At this point, IrLMP has assigned our source address */
 	self->saddr = irttp_get_saddr(self->tsap);
 
@@ -1085,7 +1085,7 @@
 	struct irda_sock *self;
 
 	IRDA_DEBUG(2, __FUNCTION__ "()\n");
-	
+
 	/* Check for valid socket type */
 	switch (sock->type) {
 	case SOCK_STREAM:     /* For TTP connections with SAR disabled */
@@ -1112,7 +1112,7 @@
 
 	init_waitqueue_head(&self->query_wait);
 
-	/* Initialise networking socket struct */ 
+	/* Initialise networking socket struct */
 	sock_init_data(sock, sk);	/* Note : set sk->refcnt to 1 */
 	sk->family = PF_IRDA;
 	sk->protocol = protocol;
@@ -1141,13 +1141,13 @@
 			self->max_sdu_size_rx = TTP_SAR_UNBOUND;
 			break;
 		default:
-			ERROR(__FUNCTION__ "(), protocol not supported!\n");
+			ERROR("%s: protocol not supported!\n", __FUNCTION__);
 			return -ESOCKTNOSUPPORT;
 		}
 		break;
 	default:
 		return -ESOCKTNOSUPPORT;
-	}		
+	}
 
 	/* Register as a client with IrLMP */
 	self->ckey = irlmp_register_client(0, NULL, NULL, NULL);
@@ -1202,25 +1202,22 @@
 #endif /* CONFIG_IRDA_ULTRA */
 	kfree(self);
 	MOD_DEC_USE_COUNT;
-	
+
 	return;
 }
 
 /*
  * Function irda_release (sock)
- *
- *    
- *
  */
 static int irda_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
-	
+
 	IRDA_DEBUG(2, __FUNCTION__ "()\n");
 
-        if (sk == NULL) 
+        if (sk == NULL)
 		return 0;
-	
+
 	sk->state       = TCP_CLOSE;
 	sk->shutdown   |= SEND_SHUTDOWN;
 	sk->state_change(sk);
@@ -1231,7 +1228,7 @@
 	irda_sk(sk) = NULL;
 
 	sock_orphan(sk);
-	sock->sk   = NULL;      
+	sock->sk   = NULL;
 
 	/* Purge queues (see sock_init_data()) */
 	skb_queue_purge(&sk->receive_queue);
@@ -1248,7 +1245,7 @@
 	 * 1) This may include IAS request, both in connect and getsockopt.
 	 * Unfortunately, the situation is a bit more messy than it looks,
 	 * because we close iriap and kfree(self) above.
-	 * 
+	 *
 	 * 2) This may include selective discovery in getsockopt.
 	 * Same stuff as above, irlmp registration and self are gone.
 	 *
@@ -1273,10 +1270,10 @@
  * Function irda_sendmsg (sock, msg, len, scm)
  *
  *    Send message down to TinyTP. This function is used for both STREAM and
- *    SEQPACK services. This is possible since it forces the client to 
+ *    SEQPACK services. This is possible since it forces the client to
  *    fragment the message if necessary
  */
-static int irda_sendmsg(struct socket *sock, struct msghdr *msg, int len, 
+static int irda_sendmsg(struct socket *sock, struct msghdr *msg, int len,
 			struct scm_cookie *scm)
 {
 	struct sock *sk = sock->sk;
@@ -1314,24 +1311,24 @@
 
 	/* Check that we don't send out to big frames */
 	if (len > self->max_data_size) {
-		IRDA_DEBUG(2, __FUNCTION__ 
-			   "(), Chopping frame from %d to %d bytes!\n", len, 
+		IRDA_DEBUG(2, __FUNCTION__
+			   "(), Chopping frame from %d to %d bytes!\n", len,
 			   self->max_data_size);
 		len = self->max_data_size;
 	}
 
-	skb = sock_alloc_send_skb(sk, len + self->max_header_size, 
+	skb = sock_alloc_send_skb(sk, len + self->max_header_size,
 				  msg->msg_flags & MSG_DONTWAIT, &err);
 	if (!skb)
 		return -ENOBUFS;
 
 	skb_reserve(skb, self->max_header_size);
-	
+
 	asmptr = skb->h.raw = skb_put(skb, len);
 	memcpy_fromiovec(asmptr, msg->msg_iov, len);
 
-	/* 
-	 * Just send the message to TinyTP, and let it deal with possible 
+	/*
+	 * Just send the message to TinyTP, and let it deal with possible
 	 * errors. No need to duplicate all that here
 	 */
 	err = irttp_data_request(self->tsap, skb);
@@ -1349,7 +1346,7 @@
  *    Try to receive message and copy it to user. The frame is discarded
  *    after being read, regardless of how much the user actually read
  */
-static int irda_recvmsg_dgram(struct socket *sock, struct msghdr *msg, 
+static int irda_recvmsg_dgram(struct socket *sock, struct msghdr *msg,
 			      int size, int flags, struct scm_cookie *scm)
 {
 	struct sock *sk = sock->sk;
@@ -1361,16 +1358,16 @@
 
 	ASSERT(self != NULL, return -1;);
 
-	skb = skb_recv_datagram(sk, flags & ~MSG_DONTWAIT, 
+	skb = skb_recv_datagram(sk, flags & ~MSG_DONTWAIT,
 				flags & MSG_DONTWAIT, &err);
 	if (!skb)
 		return err;
 
 	skb->h.raw = skb->data;
 	copied     = skb->len;
-	
+
 	if (copied > size) {
-		IRDA_DEBUG(2, __FUNCTION__ 
+		IRDA_DEBUG(2, __FUNCTION__
 			   "(), Received truncated frame (%d < %d)!\n",
 			   copied, size);
 		copied = size;
@@ -1423,11 +1420,8 @@
 
 /*
  * Function irda_recvmsg_stream (sock, msg, size, flags, scm)
- *
- *    
- *
  */
-static int irda_recvmsg_stream(struct socket *sock, struct msghdr *msg, 
+static int irda_recvmsg_stream(struct socket *sock, struct msghdr *msg,
 			       int size, int flags, struct scm_cookie *scm)
 {
 	struct sock *sk = sock->sk;
@@ -1440,7 +1434,7 @@
 
 	ASSERT(self != NULL, return -1;);
 
-	if (sock->flags & __SO_ACCEPTCON) 
+	if (sock->flags & __SO_ACCEPTCON)
 		return(-EINVAL);
 
 	if (flags & MSG_OOB)
@@ -1448,7 +1442,7 @@
 
 	if (flags & MSG_WAITALL)
 		target = size;
-		
+
 	msg->msg_namelen = 0;
 
 	do {
@@ -1459,11 +1453,11 @@
 		if (skb==NULL) {
 			if (copied >= target)
 				break;
-			
+
 			/*
 			 *	POSIX 1003.1g mandates this order.
 			 */
-			
+
 			if (sk->err) {
 				return sock_error(sk);
 			}
@@ -1500,7 +1494,7 @@
 				break;
 			}
 
-			kfree_skb(skb);			
+			kfree_skb(skb);
 		} else {
 			IRDA_DEBUG(0, __FUNCTION__ "() questionable!?\n");
 
@@ -1542,9 +1536,9 @@
 	struct sk_buff *skb;
 	unsigned char *asmptr;
 	int err;
-	
+
 	IRDA_DEBUG(4, __FUNCTION__ "(), len=%d\n", len);
-	
+
 	if (msg->msg_flags & ~MSG_DONTWAIT)
 		return -EINVAL;
 
@@ -1559,30 +1553,30 @@
 	self = irda_sk(sk);
 	ASSERT(self != NULL, return -1;);
 
-	/*  
-	 * Check that we don't send out to big frames. This is an unreliable 
-	 * service, so we have no fragmentation and no coalescence 
+	/*
+	 * Check that we don't send out to big frames. This is an unreliable
+	 * service, so we have no fragmentation and no coalescence
 	 */
 	if (len > self->max_data_size) {
 		IRDA_DEBUG(0, __FUNCTION__ "(), Warning to much data! "
-			   "Chopping frame from %d to %d bytes!\n", len, 
+			   "Chopping frame from %d to %d bytes!\n", len,
 			   self->max_data_size);
 		len = self->max_data_size;
 	}
 
-	skb = sock_alloc_send_skb(sk, len + self->max_header_size, 
+	skb = sock_alloc_send_skb(sk, len + self->max_header_size,
 				  msg->msg_flags & MSG_DONTWAIT, &err);
 	if (!skb)
 		return -ENOBUFS;
 
 	skb_reserve(skb, self->max_header_size);
-	
+
 	IRDA_DEBUG(4, __FUNCTION__ "(), appending user data\n");
 	asmptr = skb->h.raw = skb_put(skb, len);
 	memcpy_fromiovec(asmptr, msg->msg_iov, len);
 
-	/* 
-	 * Just send the message to TinyTP, and let it deal with possible 
+	/*
+	 * Just send the message to TinyTP, and let it deal with possible
 	 * errors. No need to duplicate all that here
 	 */
 	err = irttp_udata_request(self->tsap, skb);
@@ -1608,9 +1602,9 @@
 	struct sk_buff *skb;
 	unsigned char *asmptr;
 	int err;
-	
+
 	IRDA_DEBUG(4, __FUNCTION__ "(), len=%d\n", len);
-	
+
 	if (msg->msg_flags & ~MSG_DONTWAIT)
 		return -EINVAL;
 
@@ -1622,24 +1616,24 @@
 	self = irda_sk(sk);
 	ASSERT(self != NULL, return -1;);
 
-	/*  
-	 * Check that we don't send out to big frames. This is an unreliable 
-	 * service, so we have no fragmentation and no coalescence 
+	/*
+	 * Check that we don't send out to big frames. This is an unreliable
+	 * service, so we have no fragmentation and no coalescence
 	 */
 	if (len > self->max_data_size) {
 		IRDA_DEBUG(0, __FUNCTION__ "(), Warning to much data! "
-			   "Chopping frame from %d to %d bytes!\n", len, 
+			   "Chopping frame from %d to %d bytes!\n", len,
 			   self->max_data_size);
 		len = self->max_data_size;
 	}
 
-	skb = sock_alloc_send_skb(sk, len + self->max_header_size, 
+	skb = sock_alloc_send_skb(sk, len + self->max_header_size,
 				  msg->msg_flags & MSG_DONTWAIT, &err);
 	if (!skb)
 		return -ENOBUFS;
 
 	skb_reserve(skb, self->max_header_size);
-	
+
 	IRDA_DEBUG(4, __FUNCTION__ "(), appending user data\n");
 	asmptr = skb->h.raw = skb_put(skb, len);
 	memcpy_fromiovec(asmptr, msg->msg_iov, len);
@@ -1655,9 +1649,6 @@
 
 /*
  * Function irda_shutdown (sk, how)
- *
- *    
- *
  */
 static int irda_shutdown(struct socket *sock, int how)
 {
@@ -1693,11 +1684,8 @@
 
 /*
  * Function irda_poll (file, sock, wait)
- *
- *    
- *
  */
-static unsigned int irda_poll(struct file * file, struct socket *sock, 
+static unsigned int irda_poll(struct file * file, struct socket *sock,
 			      poll_table *wait)
 {
 	struct sock *sk = sock->sk;
@@ -1732,7 +1720,7 @@
 		}
 
 		if (sk->state == TCP_ESTABLISHED) {
-			if ((self->tx_flow == FLOW_START) && 
+			if ((self->tx_flow == FLOW_START) &&
 			    sock_writeable(sk))
 			{
 				mask |= POLLOUT | POLLWRNORM | POLLWRBAND;
@@ -1740,9 +1728,9 @@
 		}
 		break;
 	case SOCK_SEQPACKET:
-		if ((self->tx_flow == FLOW_START) && 
+		if ((self->tx_flow == FLOW_START) &&
 		    sock_writeable(sk))
-		{	
+		{
 			mask |= POLLOUT | POLLWRNORM | POLLWRBAND;
 		}
 		break;
@@ -1752,22 +1740,19 @@
 		break;
 	default:
 		break;
-	}		
+	}
 	return mask;
 }
 
 /*
  * Function irda_ioctl (sock, cmd, arg)
- *
- *    
- *
  */
 static int irda_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 {
 	struct sock *sk = sock->sk;
 
 	IRDA_DEBUG(4, __FUNCTION__ "(), cmd=%#x\n", cmd);
-	
+
 	switch (cmd) {
 	case TIOCOUTQ: {
 		long amount;
@@ -1778,7 +1763,7 @@
 			return -EFAULT;
 		return 0;
 	}
-	
+
 	case TIOCINQ: {
 		struct sk_buff *skb;
 		long amount = 0L;
@@ -1789,18 +1774,18 @@
 			return -EFAULT;
 		return 0;
 	}
-	
+
 	case SIOCGSTAMP:
 		if (sk != NULL) {
 			if (sk->stamp.tv_sec == 0)
 				return -ENOENT;
-			if (copy_to_user((void *)arg, &sk->stamp, 
+			if (copy_to_user((void *)arg, &sk->stamp,
 					 sizeof(struct timeval)))
 				return -EFAULT;
 			return 0;
 		}
 		return -EINVAL;
-		
+
 	case SIOCGIFADDR:
 	case SIOCSIFADDR:
 	case SIOCGIFDSTADDR:
@@ -1811,7 +1796,7 @@
 	case SIOCSIFNETMASK:
 	case SIOCGIFMETRIC:
 	case SIOCSIFMETRIC:
-		return -EINVAL;		
+		return -EINVAL;
 	default:
 		IRDA_DEBUG(1, __FUNCTION__ "(), doing device ioctl!\n");
 		return dev_ioctl(cmd, (void *) arg);
@@ -1827,23 +1812,23 @@
  *    Set some options for the socket
  *
  */
-static int irda_setsockopt(struct socket *sock, int level, int optname, 
+static int irda_setsockopt(struct socket *sock, int level, int optname,
 			   char *optval, int optlen)
 {
- 	struct sock *sk = sock->sk;
+	struct sock *sk = sock->sk;
 	struct irda_sock *self = irda_sk(sk);
 	struct irda_ias_set    *ias_opt;
 	struct ias_object      *ias_obj;
 	struct ias_attrib *	ias_attr;	/* Attribute in IAS object */
 	int opt;
-	
+
 	ASSERT(self != NULL, return -1;);
 
 	IRDA_DEBUG(2, __FUNCTION__ "(%p)\n", self);
 
 	if (level != SOL_IRLMP)
 		return -ENOPROTOOPT;
-		
+
 	switch (optname) {
 	case IRLMP_IAS_SET:
 		/* The user want to add an attribute to an existing IAS object
@@ -1855,7 +1840,7 @@
 
 		if (optlen != sizeof(struct irda_ias_set))
 			return -EINVAL;
-	
+
 		ias_opt = kmalloc(sizeof(struct irda_ias_set), GFP_ATOMIC);
 		if (ias_opt == NULL)
 			return -ENOMEM;
@@ -1863,7 +1848,7 @@
 		/* Copy query to the driver. */
 		if (copy_from_user(ias_opt, (char *)optval, optlen)) {
 			kfree(ias_opt);
-		  	return -EFAULT;
+			return -EFAULT;
 		}
 
 		/* Find the object we target.
@@ -1907,7 +1892,7 @@
 			/* Add an integer attribute */
 			irias_add_integer_attrib(
 				ias_obj,
-				ias_opt->irda_attrib_name, 
+				ias_opt->irda_attrib_name,
 				ias_opt->attribute.irda_attrib_int,
 				IAS_USER_ATTR);
 			break;
@@ -1921,7 +1906,7 @@
 			/* Add an octet sequence attribute */
 			irias_add_octseq_attrib(
 			      ias_obj,
-			      ias_opt->irda_attrib_name, 
+			      ias_opt->irda_attrib_name,
 			      ias_opt->attribute.irda_attrib_octet_seq.octet_seq,
 			      ias_opt->attribute.irda_attrib_octet_seq.len,
 			      IAS_USER_ATTR);
@@ -1939,7 +1924,7 @@
 			/* Add a string attribute */
 			irias_add_string_attrib(
 				ias_obj,
-				ias_opt->irda_attrib_name, 
+				ias_opt->irda_attrib_name,
 				ias_opt->attribute.irda_attrib_string.string,
 				IAS_USER_ATTR);
 			break;
@@ -1958,15 +1943,15 @@
 
 		if (optlen != sizeof(struct irda_ias_set))
 			return -EINVAL;
-	
+
 		ias_opt = kmalloc(sizeof(struct irda_ias_set), GFP_ATOMIC);
 		if (ias_opt == NULL)
 			return -ENOMEM;
-	
+
 		/* Copy query to the driver. */
 		if (copy_from_user(ias_opt, (char *)optval, optlen)) {
 			kfree(ias_opt);
-		  	return -EFAULT;
+			return -EFAULT;
 		}
 
 		/* Find the object we target.
@@ -1993,7 +1978,7 @@
 
 		/* Find the attribute (in the object) we target */
 		ias_attr = irias_find_attrib(ias_obj,
-					     ias_opt->irda_attrib_name); 
+					     ias_opt->irda_attrib_name);
 		if(ias_attr == (struct ias_attrib *) NULL) {
 			kfree(ias_opt);
 			return -EINVAL;
@@ -2001,7 +1986,7 @@
 
 		/* Check is the user space own the object */
 		if(ias_attr->value->owner != IAS_USER_ATTR) {
-			IRDA_DEBUG(1, __FUNCTION__ 
+			IRDA_DEBUG(1, __FUNCTION__
 				   "(), attempting to delete a kernel attribute\n");
 			kfree(ias_opt);
 			return -EPERM;
@@ -2014,26 +1999,25 @@
 	case IRLMP_MAX_SDU_SIZE:
 		if (optlen < sizeof(int))
 			return -EINVAL;
-	
+
 		if (get_user(opt, (int *)optval))
 			return -EFAULT;
-		
+
 		/* Only possible for a seqpacket service (TTP with SAR) */
 		if (sk->type != SOCK_SEQPACKET) {
-			IRDA_DEBUG(2, __FUNCTION__ 
+			IRDA_DEBUG(2, __FUNCTION__
 				   "(), setting max_sdu_size = %d\n", opt);
 			self->max_sdu_size_rx = opt;
 		} else {
-			WARNING(__FUNCTION__ 
-				"(), not allowed to set MAXSDUSIZE for this "
-				"socket type!\n");
+			WARNING("%s: not allowed to set MAXSDUSIZE for this socket type!\n",
+					__FUNCTION__);
 			return -ENOPROTOOPT;
 		}
 		break;
 	case IRLMP_HINTS_SET:
 		if (optlen < sizeof(int))
 			return -EINVAL;
-	
+
 		if (get_user(opt, (int *)optval))
 			return -EFAULT;
 
@@ -2051,7 +2035,7 @@
 		 */
 		if (optlen < sizeof(int))
 			return -EINVAL;
-	
+
 		if (get_user(opt, (int *)optval))
 			return -EFAULT;
 
@@ -2112,20 +2096,17 @@
 	default :
 		return -EINVAL;
 	}
-	
+
 	/* Copy type over */
 	ias_opt->irda_attrib_type = ias_value->type;
-	
+
 	return 0;
 }
 
 /*
  * Function irda_getsockopt (sock, level, optname, optval, optlen)
- *
- *    
- *
  */
-static int irda_getsockopt(struct socket *sock, int level, int optname, 
+static int irda_getsockopt(struct socket *sock, int level, int optname,
 			   char *optval, int *optlen)
 {
 	struct sock *sk = sock->sk;
@@ -2151,7 +2132,7 @@
 
 	if(len < 0)
 		return -EINVAL;
-		
+
 	switch (optname) {
 	case IRLMP_ENUMDEVICES:
 		/* Ask lmp for the current discovery log */
@@ -2163,13 +2144,13 @@
 		err = 0;
 
 		/* Write total list length back to client */
-		if (copy_to_user(optval, &list, 
+		if (copy_to_user(optval, &list,
 				 sizeof(struct irda_device_list) -
 				 sizeof(struct irda_device_info)))
 			err = -EFAULT;
 
 		/* Offset to first device entry */
-		offset = sizeof(struct irda_device_list) - 
+		offset = sizeof(struct irda_device_list) -
 			sizeof(struct irda_device_info);
 
 		/* Copy the list itself - watch for overflow */
@@ -2198,7 +2179,7 @@
 		len = sizeof(int);
 		if (put_user(len, optlen))
 			return -EFAULT;
-		
+
 		if (copy_to_user(optval, &val, len))
 			return -EFAULT;
 		break;
@@ -2218,7 +2199,7 @@
 		/* Copy query to the driver. */
 		if (copy_from_user((char *) ias_opt, (char *)optval, len)) {
 			kfree(ias_opt);
-		  	return -EFAULT;
+			return -EFAULT;
 		}
 
 		/* Find the object we target.
@@ -2236,7 +2217,7 @@
 
 		/* Find the attribute (in the object) we target */
 		ias_attr = irias_find_attrib(ias_obj,
-					     ias_opt->irda_attrib_name); 
+					     ias_opt->irda_attrib_name);
 		if(ias_attr == (struct ias_attrib *) NULL) {
 			kfree(ias_opt);
 			return -EINVAL;
@@ -2253,7 +2234,7 @@
 		if (copy_to_user((char *)optval, (char *) ias_opt,
 				 sizeof(struct irda_ias_set))) {
 			kfree(ias_opt);
-		  	return -EFAULT;
+			return -EFAULT;
 		}
 		/* Note : don't need to put optlen, we checked it */
 		kfree(ias_opt);
@@ -2274,7 +2255,7 @@
 		/* Copy query to the driver. */
 		if (copy_from_user((char *) ias_opt, (char *)optval, len)) {
 			kfree(ias_opt);
-		  	return -EFAULT;
+			return -EFAULT;
 		}
 
 		/* At this point, there are two cases...
@@ -2301,8 +2282,8 @@
 
 		/* Check that we can proceed with IAP */
 		if (self->iriap) {
-			WARNING(__FUNCTION__
-				"(), busy with a previous query\n");
+			WARNING("%s: busy with a previous query\n",
+					__FUNCTION__);
 			kfree(ias_opt);
 			return -EBUSY;
 		}
@@ -2359,7 +2340,7 @@
 		if (copy_to_user((char *)optval, (char *) ias_opt,
 				 sizeof(struct irda_ias_set))) {
 			kfree(ias_opt);
-		  	return -EFAULT;
+			return -EFAULT;
 		}
 		/* Note : don't need to put optlen, we checked it */
 		kfree(ias_opt);
@@ -2398,7 +2379,7 @@
 		if (!self->cachediscovery) {
 			int ret = 0;
 
-			IRDA_DEBUG(1, __FUNCTION__ 
+			IRDA_DEBUG(1, __FUNCTION__
 				   "(), nothing discovered yet, going to sleep...\n");
 
 			/* Set watchdog timer to expire in <val> ms. */
@@ -2417,14 +2398,14 @@
 			if(timer_pending(&(self->watchdog)))
 				del_timer(&(self->watchdog));
 
-			IRDA_DEBUG(1, __FUNCTION__ 
+			IRDA_DEBUG(1, __FUNCTION__
 				   "(), ...waking up !\n");
 
 			if (ret != 0)
 				return ret;
 		}
 		else
-			IRDA_DEBUG(1, __FUNCTION__ 
+			IRDA_DEBUG(1, __FUNCTION__
 				   "(), found immediately !\n");
 
 		/* Tell IrLMP that we have been notified */
@@ -2445,7 +2426,7 @@
 	default:
 		return -ENOPROTOOPT;
 	}
-	
+
 	return 0;
 }
 
@@ -2456,7 +2437,7 @@
 
 static struct proto_ops SOCKOPS_WRAPPED(irda_stream_ops) = {
 	family:		PF_IRDA,
-	
+
 	release:	irda_release,
 	bind:		irda_bind,
 	connect:	irda_connect,
@@ -2477,7 +2458,7 @@
 
 static struct proto_ops SOCKOPS_WRAPPED(irda_seqpacket_ops) = {
 	family:		PF_IRDA,
-	
+
 	release:	irda_release,
 	bind:		irda_bind,
 	connect:	irda_connect,
@@ -2498,7 +2479,7 @@
 
 static struct proto_ops SOCKOPS_WRAPPED(irda_dgram_ops) = {
 	family:		PF_IRDA,
-       
+
 	release:	irda_release,
 	bind:		irda_bind,
 	connect:	irda_connect,
@@ -2520,7 +2501,7 @@
 #ifdef CONFIG_IRDA_ULTRA
 static struct proto_ops SOCKOPS_WRAPPED(irda_ultra_ops) = {
 	family:		PF_IRDA,
-       
+
 	release:	irda_release,
 	bind:		irda_bind,
 	connect:	sock_no_connect,
@@ -2558,11 +2539,11 @@
 			     void *ptr)
 {
 	struct net_device *dev = (struct net_device *) ptr;
-	
+
         /* Reject non IrDA devices */
-	if (dev->type != ARPHRD_IRDA) 
+	if (dev->type != ARPHRD_IRDA)
 		return NOTIFY_DONE;
-	
+
         switch (event) {
 	case NETDEV_UP:
 		IRDA_DEBUG(3, __FUNCTION__ "(), NETDEV_UP\n");
@@ -2581,7 +2562,7 @@
         return NOTIFY_DONE;
 }
 
-static struct packet_type irda_packet_type = 
+static struct packet_type irda_packet_type =
 {
 	0,	/* MUTTER ntohs(ETH_P_IRDA),*/
 	NULL,
@@ -2630,7 +2611,7 @@
 	register_netdevice_notifier(&irda_dev_notifier);
 
 	irda_init();
- 	irda_device_init();
+	irda_device_init();
 	return 0;
 }
 
@@ -2649,16 +2630,16 @@
         dev_remove_pack(&irda_packet_type);
 
         unregister_netdevice_notifier(&irda_dev_notifier);
-	
+
 	sock_unregister(PF_IRDA);
 	irda_cleanup();
-	
+
         return;
 }
 module_exit(irda_proto_cleanup);
- 
+
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
-MODULE_DESCRIPTION("The Linux IrDA Protocol Subsystem"); 
+MODULE_DESCRIPTION("The Linux IrDA Protocol Subsystem");
 MODULE_LICENSE("GPL");
 #ifdef CONFIG_IRDA_DEBUG
 MODULE_PARM(irda_debug, "1l");

--------------020708030909000801090205--

