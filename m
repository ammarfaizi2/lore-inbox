Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290028AbSAKRox>; Fri, 11 Jan 2002 12:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290031AbSAKRoo>; Fri, 11 Jan 2002 12:44:44 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:15578 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S290028AbSAKRoe>; Fri, 11 Jan 2002 12:44:34 -0500
Content-Type: text/plain; charset=US-ASCII
From: "ChristianK."@t-online.de (Christian Koenig)
To: "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] Briging doesn't compile without TCP/IP Networking
Date: Fri, 11 Jan 2002 18:46:25 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <16On3u-1zr9mqC@fwd05.sul.t-online.com> <20020110.191713.48532251.davem@redhat.com>
In-Reply-To: <20020110.191713.48532251.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <16P5j6-16m9PEC@fwd03.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday 11 January 2002 04:17, David S. Miller wrote:
>
> It is better to conditionalize or remove the include than to add
> CONFIG_INET ifdefs to a TCP header :-)
>
> I thought I had fixed this in current kernels...
Nope, not all.
I thing it's the right thing to remove / replace it with other
include's

Check,this one is this better ?

MfG, Christian K. (And sorry for my poor English).

diff -Nubr linux-2.4.17.orig/net/core/rtnetlink.c 
linux-2.4.17/net/core/rtnetlink.c
--- linux-2.4.17.orig/net/core/rtnetlink.c	Fri Dec 21 18:42:05 2001
+++ linux-2.4.17/net/core/rtnetlink.c	Fri Jan 11 18:20:40 2002
@@ -45,7 +45,6 @@
 #include <net/protocol.h>
 #include <net/arp.h>
 #include <net/route.h>
-#include <net/tcp.h>
 #include <net/udp.h>
 #include <net/sock.h>
 #include <net/pkt_sched.h>
diff -Nubr linux-2.4.17.orig/net/unix/af_unix.c 
linux-2.4.17/net/unix/af_unix.c
--- linux-2.4.17.orig/net/unix/af_unix.c	Fri Dec 21 18:42:06 2001
+++ linux-2.4.17/net/unix/af_unix.c	Fri Jan 11 18:23:05 2002
@@ -100,8 +100,8 @@
 #include <asm/uaccess.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
+#include <linux/rtnetlink.h>
 #include <net/sock.h>
-#include <net/tcp.h>
 #include <net/af_unix.h>
 #include <linux/proc_fs.h>
 #include <net/scm.h>
diff -Nubr linux-2.4.17.orig/net/unix/garbage.c 
linux-2.4.17/net/unix/garbage.c
--- linux-2.4.17.orig/net/unix/garbage.c	Sat Jun 30 04:38:26 2001
+++ linux-2.4.17/net/unix/garbage.c	Fri Jan 11 18:37:55 2002
@@ -78,7 +78,6 @@
 #include <linux/proc_fs.h>

 #include <net/sock.h>
-#include <net/tcp.h>
 #include <net/af_unix.h>
 #include <net/scm.h>

