Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130486AbQKJLHx>; Fri, 10 Nov 2000 06:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129922AbQKJLHn>; Fri, 10 Nov 2000 06:07:43 -0500
Received: from pizda.ninka.net ([216.101.162.242]:21377 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129608AbQKJLHa>;
	Fri, 10 Nov 2000 06:07:30 -0500
Date: Fri, 10 Nov 2000 02:52:54 -0800
Message-Id: <200011101052.CAA12344@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: asl@launay.org
CC: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20001110115925.A16777@profile4u.com> (asl@launay.org)
Subject: Re: Linux 2.2.18pre21
In-Reply-To: <E13u4XD-0001oe-00@the-village.bc.nu> <20001110115925.A16777@profile4u.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Fri, 10 Nov 2000 11:59:25 +0100
   From: "Arnaud S . Launay" <asl@launay.org>

   trivial patch included, not sure it's the right one.

This one is better:

--- kernel/sysctl.c.~1~	Thu Nov  9 19:41:52 2000
+++ kernel/sysctl.c	Fri Nov 10 02:52:30 2000
@@ -1173,6 +1173,13 @@
 	return -ENOSYS;
 }
 
+int sysctl_jiffies(ctl_table *table, int *name, int nlen,
+		void *oldval, size_t *oldlenp,
+		void *newval, size_t newlen, void **context)
+{
+	return -ENOSYS;
+}
+
 int proc_dostring(ctl_table *table, int write, struct file *filp,
 		  void *buffer, size_t *lenp)
 {
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
