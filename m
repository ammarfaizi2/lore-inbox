Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbUKIHuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUKIHuF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 02:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUKIHuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 02:50:05 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:4771 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261420AbUKIHsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 02:48:20 -0500
Date: Tue, 9 Nov 2004 18:48:13 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [2/6] PPC64 iSeries remove trailing white space
Message-Id: <20041109184813.1a6e02cf.sfr@canb.auug.org.au>
In-Reply-To: <20041109184551.03b8a32c.sfr@canb.auug.org.au>
References: <20041109184223.16ea3414.sfr@canb.auug.org.au>
	<20041109184551.03b8a32c.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__9_Nov_2004_18_48_13_+1100_C/w5mdBCEgdWS=YN"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__9_Nov_2004_18_48_13_+1100_C/w5mdBCEgdWS=YN
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Nothing more than removing trailing white space from mf.c.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus-bk-mf.0.5/arch/ppc64/kernel/mf.c linus-bk-mf.0.6/arch/ppc64/kernel/mf.c
--- linus-bk-mf.0.5/arch/ppc64/kernel/mf.c	2004-11-09 16:30:30.000000000 +1100
+++ linus-bk-mf.0.6/arch/ppc64/kernel/mf.c	2004-11-09 16:39:08.000000000 +1100
@@ -9,17 +9,17 @@
   * all partitions in the iSeries.  It also provides miscellaneous low-level
   * machine facility type operations.
   *
-  * 
+  *
   * This program is free software; you can redistribute it and/or modify
   * it under the terms of the GNU General Public License as published by
   * the Free Software Foundation; either version 2 of the License, or
   * (at your option) any later version.
-  * 
+  *
   * This program is distributed in the hope that it will be useful,
   * but WITHOUT ANY WARRANTY; without even the implied warranty of
   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   * GNU General Public License for more details.
-  * 
+  *
   * You should have received a copy of the GNU General Public License
   * along with this program; if not, write to the Free Software
   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
@@ -497,7 +497,7 @@
 		pending_event_head = pending_event_head->next;
 		two = pending_event_head;
 		free_pending_event(oldHead);
-	} 
+	}
 	spin_unlock_irqrestore(&pending_event_spinlock, flags);
 
 	/* send next waiting event */
@@ -695,7 +695,7 @@
 			break;
 	case 'B':	newSide = 1;
 			break;
-	case 'C':	newSide = 2; 
+	case 'C':	newSide = 2;
 			break;
 	default:	newSide = 3;
 			break;
@@ -959,7 +959,7 @@
 
 	*time = mktime(year, mon, day, hour, min, sec);
 	*time += (jiffies / HZ);
-    
+
 	/*
 	 * Now THIS is a nasty hack!
 	 * It ensures that the first two calls to mf_getRtcTime get different
@@ -1020,7 +1020,7 @@
 
 				if (year <= 69)
 					year += 100;
-	    
+
 				tm->tm_sec = sec;
 				tm->tm_min = min;
 				tm->tm_hour = hour;
@@ -1051,17 +1051,17 @@
 	char ceTime[12] = "\x00\x00\x00\x41\x00\x00\x00\x00\x00\x00\x00\x00";
 	u8 day, mon, hour, min, sec, y1, y2;
 	unsigned year;
-    
+
 	year = 1900 + tm->tm_year;
 	y1 = year / 100;
 	y2 = year % 100;
-    
+
 	sec = tm->tm_sec;
 	min = tm->tm_min;
 	hour = tm->tm_hour;
 	day = tm->tm_mday;
 	mon = tm->tm_mon + 1;
-	    
+
 	BIN_TO_BCD(sec);
 	BIN_TO_BCD(min);
 	BIN_TO_BCD(hour);
@@ -1077,7 +1077,7 @@
 	ceTime[8] = hour;
 	ceTime[10] = day;
 	ceTime[11] = mon;
-   
+
 	return signal_ce_msg(ceTime, NULL);
 }
 
@@ -1093,7 +1093,7 @@
 	}
 
 	len = mf_getCmdLine(page, &len, (u64)data);
-   
+
 	p = page;
 	while (len < (count - 1)) {
 		if (!*p || *p == '\n')
@@ -1146,7 +1146,7 @@
 		len = count;
 	if (len < 0)
 		len = 0;
-	return len;			
+	return len;
 }
 
 static int proc_mf_change_side(struct file *file, const char __user *buffer,
@@ -1180,15 +1180,15 @@
 
 	mf_getSrcHistory(page, count);
 	len = count;
-	len -= off;			
-	if (len < count) {		
-		*eof = 1;		
-		if (len <= 0)		
-			return 0;	
-	} else				
-		len = count;		
-	*start = page + off;		
-	return len;			
+	len -= off;
+	if (len < count) {
+		*eof = 1;
+		if (len <= 0)
+			return 0;
+	} else
+		len = count;
+	*start = page + off;
+	return len;
 }
 
 static int proc_mf_change_src(struct file *file, const char __user *buffer,
@@ -1214,7 +1214,7 @@
 	else
 		mf_displaySrc(*(u32 *)stkbuf);
 
-	return count;			
+	return count;
 }
 
 static int proc_mf_change_cmdline(struct file *file, const char *buffer,
@@ -1225,10 +1225,10 @@
 
 	mf_setCmdLine(buffer, count, (u64)data);
 
-	return count;			
+	return count;
 }
 
-static ssize_t proc_mf_change_vmlinux(struct file *file, 
+static ssize_t proc_mf_change_vmlinux(struct file *file,
 				      const char __user *buf,
 				      size_t count, loff_t *ppos)
 {
@@ -1244,7 +1244,7 @@
 
 	*ppos += count;
 
-	return count;			
+	return count;
 }
 
 static struct file_operations proc_vmlinux_operations = {

--Signature=_Tue__9_Nov_2004_18_48_13_+1100_C/w5mdBCEgdWS=YN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBkHY94CJfqux9a+8RAiWfAJ418ZEKe53QbiLG8HcL5pdCCZinlgCgizVb
QbvuSPBhq/dSJ13qD9evuSA=
=qOq5
-----END PGP SIGNATURE-----

--Signature=_Tue__9_Nov_2004_18_48_13_+1100_C/w5mdBCEgdWS=YN--
