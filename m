Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267343AbUJIUAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267343AbUJIUAV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 16:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267345AbUJIUAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 16:00:21 -0400
Received: from ts2-075.twistspace.com ([217.71.122.75]:41176 "EHLO entmoot.nl")
	by vger.kernel.org with ESMTP id S267343AbUJIUAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 16:00:16 -0400
Message-ID: <001d01c4ae43$06f83c30$161b14ac@boromir>
From: "Martijn Sipkema" <martijn@entmoot.nl>
To: "Mark Mielke" <mark@mark.mielke.cc>,
       "David Schwartz" <davids@webmaster.com>
Cc: <linux-kernel@vger.kernel.org>
References: <000801c4ae35$3520ac90$161b14ac@boromir> <MDEHLPKNGKAHNMBLJOLKEEAPOOAA.davids@webmaster.com> <20041009184922.GA8032@mark.mielke.cc>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Date: Sat, 9 Oct 2004 22:00:35 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
> Please - people who don't agree, just ensure that Linux is documented
> to not implement select() on sockets without O_NONBLOCK properly.

Actually, the behaviour isn't correct for sockets with O_NONBLOCK
either, since EAGAIN may only be returned when recvmsg() would not
block without O_NONBLOCK.


--ms


