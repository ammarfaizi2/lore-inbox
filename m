Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274426AbRITL1O>; Thu, 20 Sep 2001 07:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274427AbRITL1F>; Thu, 20 Sep 2001 07:27:05 -0400
Received: from mail.fbab.net ([212.75.83.8]:52233 "HELO mail.fbab.net")
	by vger.kernel.org with SMTP id <S274426AbRITL0z>;
	Thu, 20 Sep 2001 07:26:55 -0400
X-Qmail-Scanner-Mail-From: mag@fbab.net via mail.fbab.net
X-Qmail-Scanner-Rcpt-To: andrea@suse.de linux-kernel@vger.kernel.org
X-Qmail-Scanner: 0.94 (No viruses found. Processed in 5.978206 secs)
Message-ID: <066a01c141c7$86c74c30$020a0a0a@totalmef>
From: "Magnus Naeslund\(f\)" <mag@fbab.net>
To: "Andrea Arcangeli" <andrea@suse.de>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: 2.4.10pre12aa1 pgbench
Date: Thu, 20 Sep 2001 13:29:35 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is not any scientific super bench, but this is what matters for me :)

It's an Alpha UX-164 633mhz with 1.25GB memory.
It's considerably slower than 2.4.5aa1, sorry to say.

This is my pgbench diffs:

--- 2.4.5aa1.txt        Thu Sep 20 09:13:30 2001
+++ 2.4.10pre12aa1.txt  Thu Sep 20 13:08:37 2001
@@ -9,9 +9,9 @@
 number of clients: 1
 number of transactions per client: 10
 number of transactions actually processed: 10/10
-tps = 25.139082(including connections establishing)
-tps = 28.741744(excluding connections establishing)
-0.02user 0.00system 0:00.80elapsed 3%CPU (0avgtext+0avgdata 0maxresident)k
+tps = 9.923214(including connections establishing)
+tps = 10.497442(excluding connections establishing)
+0.02user 0.00system 0:01.15elapsed 2%CPU (0avgtext+0avgdata 0maxresident)k
 0inputs+0outputs (0major+0minor)pagefaults 0swaps


@@ -24,9 +24,9 @@
 number of clients: 1
 number of transactions per client: 100
 number of transactions actually processed: 100/100
-tps = 27.289761(including connections establishing)
-tps = 27.678849(excluding connections establishing)
-0.06user 0.05system 0:03.86elapsed 3%CPU (0avgtext+0avgdata 0maxresident)k
+tps = 13.779075(including connections establishing)
+tps = 13.875670(excluding connections establishing)
+0.05user 0.04system 0:07.42elapsed 1%CPU (0avgtext+0avgdata 0maxresident)k
 0inputs+0outputs (0major+0minor)pagefaults 0swaps


@@ -39,9 +39,9 @@
 number of clients: 20
 number of transactions per client: 10
 number of transactions actually processed: 200/200
-tps = 17.166296(including connections establishing)
-tps = 17.917905(excluding connections establishing)
-0.11user 0.14system 0:11.87elapsed 2%CPU (0avgtext+0avgdata 0maxresident)k
+tps = 16.683457(including connections establishing)
+tps = 17.374824(excluding connections establishing)
+0.11user 0.13system 0:12.17elapsed 2%CPU (0avgtext+0avgdata 0maxresident)k
 0inputs+0outputs (0major+0minor)pagefaults 0swaps


@@ -54,9 +54,9 @@
 number of clients: 20
 number of transactions per client: 100
 number of transactions actually processed: 2000/2000
-tps = 27.149347(including connections establishing)
-tps = 27.330001(excluding connections establishing)
-0.98user 1.27system 1:13.97elapsed 3%CPU (0avgtext+0avgdata 0maxresident)k
+tps = 26.025792(including connections establishing)
+tps = 26.189368(excluding connections establishing)
+0.84user 1.33system 1:17.03elapsed 2%CPU (0avgtext+0avgdata 0maxresident)k
 0inputs+0outputs (0major+0minor)pagefaults 0swaps


@@ -69,9 +69,9 @@
 number of clients: 50
 number of transactions per client: 10
 number of transactions actually processed: 500/500
-tps = 22.105250(including connections establishing)
-tps = 23.342988(excluding connections establishing)
-0.28user 0.40system 0:23.00elapsed 3%CPU (0avgtext+0avgdata 0maxresident)k
+tps = 19.077870(including connections establishing)
+tps = 19.985427(excluding connections establishing)
+0.28user 0.42system 0:26.57elapsed 2%CPU (0avgtext+0avgdata 0maxresident)k
 0inputs+0outputs (0major+0minor)pagefaults 0swaps


@@ -84,9 +84,9 @@
 number of clients: 50
 number of transactions per client: 100
 number of transactions actually processed: 5000/5000
-tps = 20.743853(including connections establishing)
-tps = 20.863022(excluding connections establishing)
-2.55user 4.32system 4:01.46elapsed 2%CPU (0avgtext+0avgdata 0maxresident)k
+tps = 18.688064(including connections establishing)
+tps = 18.770892(excluding connections establishing)
+2.76user 4.20system 4:27.74elapsed 2%CPU (0avgtext+0avgdata 0maxresident)k
 0inputs+0outputs (0major+0minor)pagefaults 0swaps


@@ -99,9 +99,9 @@
 number of clients: 100
 number of transactions per client: 10
 number of transactions actually processed: 1000/1000
-tps = 30.153119(including connections establishing)
-tps = 32.500791(excluding connections establishing)
-0.69user 1.11system 0:33.90elapsed 5%CPU (0avgtext+0avgdata 0maxresident)k
+tps = 16.874544(including connections establishing)
+tps = 17.579728(excluding connections establishing)
+0.64user 1.18system 0:59.94elapsed 3%CPU (0avgtext+0avgdata 0maxresident)k
 0inputs+0outputs (0major+0minor)pagefaults 0swaps


@@ -114,9 +114,9 @@
 number of clients: 100
 number of transactions per client: 100
 number of transactions actually processed: 10000/10000
-tps = 16.258988(including connections establishing)
-tps = 16.322457(excluding connections establishing)
-6.59user 14.50system 10:15.27elapsed 3%CPU (0avgtext+0avgdata
0maxresident)k
+tps = 15.257859(including connections establishing)
+tps = 15.313045(excluding connections establishing)
+6.55user 14.54system 10:55.68elapsed 3%CPU (0avgtext+0avgdata
0maxresident)k
 0inputs+0outputs (0major+0minor)pagefaults 0swaps


@@ -129,9 +129,9 @@
 number of clients: 200
 number of transactions per client: 10
 number of transactions actually processed: 2000/2000
-tps = 20.326710(including connections establishing)
-tps = 21.324192(excluding connections establishing)
-1.62user 3.60system 1:39.77elapsed 5%CPU (0avgtext+0avgdata 0maxresident)k
+tps = 16.447976(including connections establishing)
+tps = 17.126929(excluding connections establishing)
+1.70user 3.72system 2:03.03elapsed 4%CPU (0avgtext+0avgdata 0maxresident)k
 0inputs+0outputs (0major+0minor)pagefaults 0swaps


@@ -144,7 +144,7 @@
 number of clients: 200
 number of transactions per client: 100
 number of transactions actually processed: 20000/20000
-tps = 8.367056(including connections establishing)
-tps = 8.383456(excluding connections establishing)
-19.83user 73.54system 39:50.71elapsed 3%CPU (0avgtext+0avgdata
0maxresident)k
+tps = 7.374791(including connections establishing)
+tps = 7.387783(excluding connections establishing)
+19.79user 71.96system 45:15.92elapsed 3%CPU (0avgtext+0avgdata
0maxresident)k
 0inputs+0outputs (0major+0minor)pagefaults 0swaps



Magnus

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 Programmer/Networker [|] Magnus Naeslund
 PGP Key: http://www.genline.nu/mag_pgp.txt
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


