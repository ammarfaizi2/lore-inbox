Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264943AbUATFwU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 00:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264961AbUATFwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 00:52:20 -0500
Received: from ns1.goquest.com ([12.18.108.6]:9928 "HELO mail.goquest.com")
	by vger.kernel.org with SMTP id S264943AbUATFwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 00:52:19 -0500
Message-ID: <000501c3df19$6769cfb0$6600a8c0@pixl>
From: "Peter Maas" <peter@goquest.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Busy-wait delay in qmail 1.03 after upgrading to Linux 2.6
Date: Mon, 19 Jan 2004 23:51:09 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re: Haakon Riiser
>I think I've been able to create a simple test program that
>demonstrates the bug I encountered with Qmail.

I've compiled and tested the code you posted, i thought that i would add
that renicing the LISTENER processes shows some interesting effects.

at nice 0 the writer spits out about 40 writes under .01 ms, then 3 to 5
writes at 97+ ms, after about 3 minutes its starts to get more random.
at nice -1 the writer spits out about 40 writes under .01 ms, then about 40
writes at 97+ ms, kept this cycle for over 10 minutes.
at nice 1 the writer spits out a few hundred writes under .01 ms, and
occasionally one at 97+ ms.

same effect if elevator=deadline

This thread caught my intrest because I run qmail on this box.

Peter Maas

Pentium II - 400MHz 128MB PC100
kernel-2.6.1-1.126 from http://people.redhat.com/arjanv/2.6/
(not subscribed - reads archives)

