Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268261AbTCFR4H>; Thu, 6 Mar 2003 12:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268266AbTCFR4H>; Thu, 6 Mar 2003 12:56:07 -0500
Received: from customer-148-223-196-18.uninet.net.mx ([148.223.196.18]:10624
	"EHLO soltisns.soltis.cc") by vger.kernel.org with ESMTP
	id <S268261AbTCFR4F>; Thu, 6 Mar 2003 12:56:05 -0500
From: "jds" <jds@soltis.cc>
To: linux-kernel@vger.kernel.org
Subject: problems in kernel 2.4.20  stat() seems to return always size zero for any fifo (named pipe)
Date: Thu, 6 Mar 2003 12:22:02 -0600
Message-Id: <20030306180838.M2529@soltis.cc>
X-Mailer: Open WebMail 1.90 20030212
X-OriginatingIP: 170.169.46.200 (jds)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi:

I have a problem using stat() with kernel 2.4.20
The size of ANY fifo is always 0.
There is no backward compatibility.
Probably it is a kernel bug in this particular version.
The problem shows up when using the ls, stat commands.

How reproducible:
Always

Steps to Reproduce:
1. mkfifo xx
2. cat > xx &
3. cat < xx
4. ^Z
5. echo "abcd" > xx


Actual Results:  prw-rw-r--    1 kostadin kostadin        0 Feb 21 13:54 xx


Expected Results:  prw-rw-r--    1 kostadin kostadin        5 Feb 21 13:54 xx

In Kernel 2.4.18-X the RedHat work perfect, e inclusive in 2.4.20-X the Redhat
  beta 8.0.94

Helpme please.
