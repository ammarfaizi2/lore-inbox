Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWCTH6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWCTH6M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 02:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWCTH6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 02:58:12 -0500
Received: from cpe-72-226-39-15.nycap.res.rr.com ([72.226.39.15]:43274 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S932198AbWCTH6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 02:58:11 -0500
From: "Matt LaPlante" <laplam@rpi.edu>
To: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: 2.6.16: Two AES Options
Date: Mon, 20 Mar 2006 02:57:38 -0500
Message-ID: <000001c64bf3$f5659850$fe04a8c0@cyberdogt42>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcZL8/Uaba5OpUHgS9mijIgEEL2bHQ==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
X-Spam-Processed: mail.cyberdogtech.com, Mon, 20 Mar 2006 02:57:48 -0500
	(not processed: message from trusted or authenticated source)
X-Return-Path: laplam@rpi.edu
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Mon, 20 Mar 2006 02:57:49 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
 I just downloaded the new 2.6.16 (very exciting!), and noticed something
odd in my menuconfig.  I was updating from a 2.4.15.4 config, when I noticed
that under cryptographic options I now have two AES entries...  I double
checked, and this occurs whether I use make oldconfig or make menuconfig on
the .15 file:

x x --- Cryptographic API
x x
...
  x x < >   AES cipher algorithms
x x
  x x < >   AES cipher algorithms (i586)
x x
...
  x x     Hardware crypto devices  --->       

Both entries have identical descriptions, yet one has the symbol
CRYPTO_AES_586 and (the new one) is just CRYPTO_AES.  I have no way of
knowing if this is intentional or a bug, but if it's the former it would
seem it deserves a different help text so folks like me know which to
choose.

-
Matt LaPlante



