Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262909AbVCDNEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbVCDNEg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 08:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbVCDNAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 08:00:14 -0500
Received: from f24.mail.ru ([194.67.57.160]:6664 "EHLO f24.mail.ru")
	by vger.kernel.org with ESMTP id S263021AbVCDMto (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 07:49:44 -0500
From: se go <ass22@inbox.ru>
To: linux-kernel@vger.kernel.org
Subject: TCP ACKs carrying data
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [194.85.70.42]
Date: Fri, 04 Mar 2005 15:49:43 +0300
Reply-To: se go <ass22@inbox.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1D7CFT-000N35-00.ass22-inbox-ru@f24.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i got some problems concerning tcp realization in kernel (v 2.4).

i need to make some modifications to tcp to be able to transfer data within ACK segments...(initially their data field is empty)

i suppose i should modify the following functions:

/net/ipv4/tcp_input.c > tcp_ack()  - for processing incoming acks, to read data from their data field

and

/net/ipv4/tcp_output.c > tcp_send_ack() - for processing outgoing acks, to put data in them

my questions are: 
 - am i right in my decision?
 - what problems these modifications may cause (i tried to modify and they do cause!... i just cannot understand what they are)
 - what functions else i may need to modify?
 - how must i modify ACKs to make them do what i want and to make linux kernel correctly treating them.

if you need i can reply the list of modifications i've done.

i'd like to be personally CC'd.


thanks in advance,

Serge Goodenko
Moscow Institute of Physics and Technology
Moscow, Russia

