Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264490AbTGGVTg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 17:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264493AbTGGVTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 17:19:36 -0400
Received: from mpls-qmqp-03.inet.qwest.net ([63.231.195.114]:15374 "HELO
	mpls-qmqp-03.inet.qwest.net") by vger.kernel.org with SMTP
	id S264490AbTGGVTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 17:19:31 -0400
Date: Mon, 7 Jul 2003 16:30:47 -0700
Message-ID: <001401c344df$ccbc63c0$6801a8c0@oemcomputer>
From: "Paul Albrecht" <palbrecht@qwest.net>
To: "Nivedita Singhvi" <niv@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, "netdev" <netdev@oss.sgi.com>
References: <3F08858E.8000907@us.ibm.com> <001a01c3441c$6fe111a0$6801a8c0@oemcomputer> <3F08B7E2.7040208@us.ibm.com> <000d01c3444f$e6439600$6801a8c0@oemcomputer> <3F090A4F.10004@us.ibm.com>
Subject: Re: question about linux tcp request queue handling
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nivedita Singhvi writes:

>
> Again, youre limiting the number of connnection requests
> that are allowed to wait in the *accept* queue, where
> we move to once we're ESTABLISHED.  You arent limiting
> a request sitting in the SYN queue.
>

This statement is inconsistent with the description of this scenario in
Steven's TCP/IP Illustrated.  Specifically, continuing the handshake in the
TCP layer, i.e., sending a syn/ack and moving to the syn_recd state, is
incorrect if the limit of the server's socket backlog would be exceeded.
How do you account for this discrepancy between linux and other
berkeley-derived implementations?


