Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261891AbSI3BHF>; Sun, 29 Sep 2002 21:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261892AbSI3BHF>; Sun, 29 Sep 2002 21:07:05 -0400
Received: from smtp3.texas.rr.com ([24.93.36.231]:20647 "EHLO
	txsmtp03.texas.rr.com") by vger.kernel.org with ESMTP
	id <S261891AbSI3BHE>; Sun, 29 Sep 2002 21:07:04 -0400
Message-ID: <00d601c2681e$a60c3280$7f71a018@OMIT>
From: "omit_ECE" <omit@rice.edu>
To: <linux-kernel@vger.kernel.org>
Subject: linux-kernel@vger.kernel.org
Date: Sun, 29 Sep 2002 20:13:56 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I want to know the one-way trip time in TCP header.
In tcp_input.c , I found many functions under which include
rcv_tsval and  rcv_tsecr . I don't know which two are right.
So, I put many "printf" and fprintf in functions and compile the kernel.
But when compiling it, some errors happen,

net/network.o: In function `tcp_parse_options':
net/network.o: In function `tcp_rcv_established':
net/network.o: In function `tcp_rcv_synsent_state_process':
net/network.o: In function `tcp_rcv_state_process':
net/network.o(.text+0x2807b): undefined reference to `printf'
net/network.o(.text+0x2808c): undefined reference to `printf'
net/network.o(.text+0x2631d): undefined reference to `fopen'
net/network.o(.text+0x26334): undefined reference to `fprintf'
net/network.o(.text+0x2634e): undefined reference to `fprintf'
net/network.o(.text+0x2635a): undefined reference to `fclose'

Aren't "printf" and "fprintf"  standard outputs? I also put #include <stdio.h>
and "FILE *in_file", but they didn't work. Please give me suggestions.
Thank you.
