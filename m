Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291628AbSBNMf5>; Thu, 14 Feb 2002 07:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291608AbSBNMfD>; Thu, 14 Feb 2002 07:35:03 -0500
Received: from r220-1.rz.RWTH-Aachen.DE ([134.130.3.31]:55755 "EHLO
	r220-1.rz.RWTH-Aachen.DE") by vger.kernel.org with ESMTP
	id <S291618AbSBNMes>; Thu, 14 Feb 2002 07:34:48 -0500
Message-ID: <3C6BAEDE.77AD9496@oph.rwth-aachen.de>
Date: Thu, 14 Feb 2002 13:34:38 +0100
From: Stefan Becker <stefan@oph.rwth-aachen.de>
Organization: OPH Netzwerkgruppe
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Ford <david+cert@blue-labs.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ver_linux script updates
In-Reply-To: <3C6ADCAA.6080600@blue-labs.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

David Ford wrote:
[...]
> Please provide feedback on it.

ECN detection doesn't work properly.

--- ver_linux.orig      Thu Feb 14 13:31:43 2002
+++ ver_linux   Thu Feb 14 13:31:33 2002
@@ -44,8 +44,8 @@
 }
 
 function truth {
-      if [ "$@" == "0" ]; then echo "disabled"; fi
-      echo "enabled"
+      if [ "$@" == "0" ]; then echo "disabled"; else
+      echo "enabled"; fi
 }
 
 pv "Gnu C compiler" "$(gcc --version 2>/dev/null)" gcc
@@ -153,5 +153,5 @@
 # kernel tuning options
 if [ -e /proc/sys/net/ipv4/tcp_ecn ]; then
        v=$(cat /proc/sys/net/ipv4/tcp_ecn)
-       pv "TCP option: ECN" "$(truth v)"
+       pv "TCP option: ECN" "$(truth $v)"
 fi

Greeting from Aachen,
Stefan Becker
