Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129308AbQKTME0>; Mon, 20 Nov 2000 07:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129670AbQKTMEQ>; Mon, 20 Nov 2000 07:04:16 -0500
Received: from atlantis.hlfl.org ([213.41.91.231]:53253 "HELO
	atlantis.hlfl.org") by vger.kernel.org with SMTP id <S129308AbQKTMEB>;
	Mon, 20 Nov 2000 07:04:01 -0500
Date: Mon, 20 Nov 2000 12:33:58 +0100
From: "Arnaud S . Launay" <asl@launay.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18pre22
Message-ID: <20001120123358.A17268@profile4u.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E13xJ14-0002Do-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <E13xJ14-0002Do-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Nov 19, 2000 at 01:11:33AM +0000
X-PGP-Key: http://launay.org/pgpkey.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sun, Nov 19, 2000 at 01:11:33AM +0000, Alan Cox a écrit:
> Bugs to go: PS/2 mouse detection
> Anything which isnt a strict bug fix or previously agreed is now 2.2.19
> material.

Once again, I needed this patch by Dave Miller to compile the
kernel:


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

	Arnaud.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
