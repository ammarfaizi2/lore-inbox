Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263349AbTDCKlC>; Thu, 3 Apr 2003 05:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263350AbTDCKlC>; Thu, 3 Apr 2003 05:41:02 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:63367 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S263349AbTDCKkz>; Thu, 3 Apr 2003 05:40:55 -0500
Date: Thu, 3 Apr 2003 12:52:15 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Subject: [PATCH] C99 Initializers for net/ipv6 [2.4]
Message-ID: <Pine.LNX.4.51.0304031250110.13088@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a conversion to C99 initializers to the files in net/ipv6.
It compiles.
Patch is against 2.4.21pre6.

Regards,
Maciej Soltysiak

diff -Nru linux-2.4.20.bak/net/ipv6/af_inet6.c linux-2.4.20/net/ipv6/af_inet6.c
--- linux-2.4.20.bak/net/ipv6/af_inet6.c	2003-04-03 11:49:57.000000000 +0200
+++ linux-2.4.20/net/ipv6/af_inet6.c	2003-04-03 11:58:20.000000000 +0200
@@ -464,45 +464,45 @@
 }

 struct proto_ops inet6_stream_ops = {
-	family:		PF_INET6,
+	.family		= PF_INET6,

-	release:	inet6_release,
-	bind:		inet6_bind,
-	connect:	inet_stream_connect,		/* ok		*/
-	socketpair:	sock_no_socketpair,		/* a do nothing	*/
-	accept:		inet_accept,			/* ok		*/
-	getname:	inet6_getname,
-	poll:		tcp_poll,			/* ok		*/
-	ioctl:		inet6_ioctl,			/* must change  */
-	listen:		inet_listen,			/* ok		*/
-	shutdown:	inet_shutdown,			/* ok		*/
-	setsockopt:	inet_setsockopt,		/* ok		*/
-	getsockopt:	inet_getsockopt,		/* ok		*/
-	sendmsg:	inet_sendmsg,			/* ok		*/
-	recvmsg:	inet_recvmsg,			/* ok		*/
-	mmap:		sock_no_mmap,
-	sendpage:	tcp_sendpage
+	.release	= inet6_release,
+	.bind		= inet6_bind,
+	.connect	= inet_stream_connect,		/* ok		*/
+	.socketpair	= sock_no_socketpair,		/* a do nothing	*/
+	.accept		= inet_accept,			/* ok		*/
+	.getname	= inet6_getname,
+	.poll		= tcp_poll,			/* ok		*/
+	.ioctl		= inet6_ioctl,			/* must change  */
+	.listen		= inet_listen,			/* ok		*/
+	.shutdown	= inet_shutdown,			/* ok		*/
+	.setsockopt	= inet_setsockopt,		/* ok		*/
+	.getsockopt	= inet_getsockopt,		/* ok		*/
+	.sendmsg	= inet_sendmsg,			/* ok		*/
+	.recvmsg	= inet_recvmsg,			/* ok		*/
+	.mmap		= sock_no_mmap,
+	.sendpage	= tcp_sendpage
 };

 struct proto_ops inet6_dgram_ops = {
-	family:		PF_INET6,
+	.family		= PF_INET6,

-	release:	inet6_release,
-	bind:		inet6_bind,
-	connect:	inet_dgram_connect,		/* ok		*/
-	socketpair:	sock_no_socketpair,		/* a do nothing	*/
-	accept:		sock_no_accept,			/* a do nothing	*/
-	getname:	inet6_getname,
-	poll:		datagram_poll,			/* ok		*/
-	ioctl:		inet6_ioctl,			/* must change  */
-	listen:		sock_no_listen,			/* ok		*/
-	shutdown:	inet_shutdown,			/* ok		*/
-	setsockopt:	inet_setsockopt,		/* ok		*/
-	getsockopt:	inet_getsockopt,		/* ok		*/
-	sendmsg:	inet_sendmsg,			/* ok		*/
-	recvmsg:	inet_recvmsg,			/* ok		*/
-	mmap:		sock_no_mmap,
-	sendpage:	sock_no_sendpage,
+	.release	= inet6_release,
+	.bind		= inet6_bind,
+	.connect	= inet_dgram_connect,		/* ok		*/
+	.socketpair	= sock_no_socketpair,		/* a do nothing	*/
+	.accept		= sock_no_accept,			/* a do nothing	*/
+	.getname	= inet6_getname,
+	.poll		= datagram_poll,			/* ok		*/
+	.ioctl		= inet6_ioctl,			/* must change  */
+	.listen		= sock_no_listen,			/* ok		*/
+	.shutdown	= inet_shutdown,			/* ok		*/
+	.setsockopt	= inet_setsockopt,		/* ok		*/
+	.getsockopt	= inet_getsockopt,		/* ok		*/
+	.sendmsg	= inet_sendmsg,			/* ok		*/
+	.recvmsg	= inet_recvmsg,			/* ok		*/
+	.mmap		= sock_no_mmap,
+	.sendpage	= sock_no_sendpage,
 };

 struct net_proto_family inet6_family_ops = {
@@ -525,13 +525,13 @@
 #endif

 static struct inet_protosw rawv6_protosw = {
-	type:        SOCK_RAW,
-	protocol:    IPPROTO_IP,	/* wild card */
-	prot:        &rawv6_prot,
-	ops:         &inet6_dgram_ops,
-	capability:  CAP_NET_RAW,
-	no_check:    UDP_CSUM_DEFAULT,
-	flags:       INET_PROTOSW_REUSE,
+	.type		= SOCK_RAW,
+	.protocol	= IPPROTO_IP,	/* wild card */
+	.prot		= &rawv6_prot,
+	.ops		= &inet6_dgram_ops,
+	.capability	= CAP_NET_RAW,
+	.no_check	= UDP_CSUM_DEFAULT,
+	.flags		= INET_PROTOSW_REUSE,
 };

 #define INETSW6_ARRAY_LEN (sizeof(inetsw6_array) / sizeof(struct inet_protosw))
diff -Nru linux-2.4.20.bak/net/ipv6/raw.c linux-2.4.20/net/ipv6/raw.c
--- linux-2.4.20.bak/net/ipv6/raw.c	2003-04-03 11:49:57.000000000 +0200
+++ linux-2.4.20/net/ipv6/raw.c	2003-04-03 11:59:29.000000000 +0200
@@ -903,19 +903,19 @@
 }

 struct proto rawv6_prot = {
-	name:		"RAW",
-	close:		rawv6_close,
-	connect:	udpv6_connect,
-	disconnect:	udp_disconnect,
-	ioctl:		rawv6_ioctl,
-	init:		rawv6_init_sk,
-	destroy:	inet6_destroy_sock,
-	setsockopt:	rawv6_setsockopt,
-	getsockopt:	rawv6_getsockopt,
-	sendmsg:	rawv6_sendmsg,
-	recvmsg:	rawv6_recvmsg,
-	bind:		rawv6_bind,
-	backlog_rcv:	rawv6_rcv_skb,
-	hash:		raw_v6_hash,
-	unhash:		raw_v6_unhash,
+	.name		= "RAW",
+	.close		= rawv6_close,
+	.connect	= udpv6_connect,
+	.disconnect	= udp_disconnect,
+	.ioctl		= rawv6_ioctl,
+	.init		= rawv6_init_sk,
+	.destroy	= inet6_destroy_sock,
+	.setsockopt	= rawv6_setsockopt,
+	.getsockopt	= rawv6_getsockopt,
+	.sendmsg	= rawv6_sendmsg,
+	.recvmsg	= rawv6_recvmsg,
+	.bind		= rawv6_bind,
+	.backlog_rcv	= rawv6_rcv_skb,
+	.hash		= raw_v6_hash,
+	.unhash		= raw_v6_unhash,
 };
diff -Nru linux-2.4.20.bak/net/ipv6/sit.c linux-2.4.20/net/ipv6/sit.c
--- linux-2.4.20.bak/net/ipv6/sit.c	2003-04-03 11:49:57.000000000 +0200
+++ linux-2.4.20/net/ipv6/sit.c	2003-04-03 11:58:49.000000000 +0200
@@ -63,8 +63,8 @@
 static int ipip6_tunnel_init(struct net_device *dev);

 static struct net_device ipip6_fb_tunnel_dev = {
-	name: 		"sit0",
-	init:		ipip6_fb_tunnel_init,
+	.name		= "sit0",
+	.init		= ipip6_fb_tunnel_init,
 };

 static struct ip_tunnel ipip6_fb_tunnel = {
diff -Nru linux-2.4.20.bak/net/ipv6/tcp_ipv6.c linux-2.4.20/net/ipv6/tcp_ipv6.c
--- linux-2.4.20.bak/net/ipv6/tcp_ipv6.c	2003-04-03 11:49:57.000000000 +0200
+++ linux-2.4.20/net/ipv6/tcp_ipv6.c	2003-04-03 11:56:23.000000000 +0200
@@ -2109,23 +2109,23 @@
 }

 struct proto tcpv6_prot = {
-	name:		"TCPv6",
-	close:		tcp_close,
-	connect:	tcp_v6_connect,
-	disconnect:	tcp_disconnect,
-	accept:		tcp_accept,
-	ioctl:		tcp_ioctl,
-	init:		tcp_v6_init_sock,
-	destroy:	tcp_v6_destroy_sock,
-	shutdown:	tcp_shutdown,
-	setsockopt:	tcp_setsockopt,
-	getsockopt:	tcp_getsockopt,
-	sendmsg:	tcp_sendmsg,
-	recvmsg:	tcp_recvmsg,
-	backlog_rcv:	tcp_v6_do_rcv,
-	hash:		tcp_v6_hash,
-	unhash:		tcp_unhash,
-	get_port:	tcp_v6_get_port,
+	.name		= "TCPv6",
+	.close		= tcp_close,
+	.connect	= tcp_v6_connect,
+	.disconnect	= tcp_disconnect,
+	.accept		= tcp_accept,
+	.ioctl		= tcp_ioctl,
+	.init		= tcp_v6_init_sock,
+	.destroy	= tcp_v6_destroy_sock,
+	.shutdown	= tcp_shutdown,
+	.setsockopt	= tcp_setsockopt,
+	.getsockopt	= tcp_getsockopt,
+	.sendmsg	= tcp_sendmsg,
+	.recvmsg	= tcp_recvmsg,
+	.backlog_rcv	= tcp_v6_do_rcv,
+	.hash		= tcp_v6_hash,
+	.unhash		= tcp_unhash,
+	.get_port	= tcp_v6_get_port,
 };

 static struct inet6_protocol tcpv6_protocol =
@@ -2142,13 +2142,13 @@
 extern struct proto_ops inet6_stream_ops;

 static struct inet_protosw tcpv6_protosw = {
-	type:        SOCK_STREAM,
-	protocol:    IPPROTO_TCP,
-	prot:        &tcpv6_prot,
-	ops:         &inet6_stream_ops,
-	capability:  -1,
-	no_check:    0,
-	flags:       INET_PROTOSW_PERMANENT,
+	.type		= SOCK_STREAM,
+	.protocol	= IPPROTO_TCP,
+	.prot		= &tcpv6_prot,
+	.ops		= &inet6_stream_ops,
+	.capability	= -1,
+	.no_check	= 0,
+	.flags		= INET_PROTOSW_PERMANENT,
 };

 void __init tcpv6_init(void)
diff -Nru linux-2.4.20.bak/net/ipv6/udp.c linux-2.4.20/net/ipv6/udp.c
--- linux-2.4.20.bak/net/ipv6/udp.c	2003-04-03 11:49:57.000000000 +0200
+++ linux-2.4.20/net/ipv6/udp.c	2003-04-03 11:55:18.000000000 +0200
@@ -1003,32 +1003,32 @@
 }

 struct proto udpv6_prot = {
-	name:		"UDP",
-	close:		udpv6_close,
-	connect:	udpv6_connect,
-	disconnect:	udp_disconnect,
-	ioctl:		udp_ioctl,
-	destroy:	inet6_destroy_sock,
-	setsockopt:	ipv6_setsockopt,
-	getsockopt:	ipv6_getsockopt,
-	sendmsg:	udpv6_sendmsg,
-	recvmsg:	udpv6_recvmsg,
-	backlog_rcv:	udpv6_queue_rcv_skb,
-	hash:		udp_v6_hash,
-	unhash:		udp_v6_unhash,
-	get_port:	udp_v6_get_port,
+	.name		= "UDP",
+	.close		= udpv6_close,
+	.connect	= udpv6_connect,
+	.disconnect	= udp_disconnect,
+	.ioctl		= udp_ioctl,
+	.destroy	= inet6_destroy_sock,
+	.setsockopt	= ipv6_setsockopt,
+	.getsockopt	= ipv6_getsockopt,
+	.sendmsg	= udpv6_sendmsg,
+	.recvmsg	= udpv6_recvmsg,
+	.backlog_rcv	= udpv6_queue_rcv_skb,
+	.hash		= udp_v6_hash,
+	.unhash		= udp_v6_unhash,
+	.get_port	= udp_v6_get_port,
 };

 extern struct proto_ops inet6_dgram_ops;

 static struct inet_protosw udpv6_protosw = {
-	type:        SOCK_DGRAM,
-	protocol:    IPPROTO_UDP,
-	prot:        &udpv6_prot,
-	ops:         &inet6_dgram_ops,
-	capability:  -1,
-	no_check:    UDP_CSUM_DEFAULT,
-	flags:       INET_PROTOSW_PERMANENT,
+	.type		= SOCK_DGRAM,
+	.protocol	= IPPROTO_UDP,
+	.prot		= &udpv6_prot,
+	.ops		= &inet6_dgram_ops,
+	.capability	= -1,
+	.no_check	= UDP_CSUM_DEFAULT,
+	.flags		= INET_PROTOSW_PERMANENT,
 };


