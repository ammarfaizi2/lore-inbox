Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262481AbSKISuY>; Sat, 9 Nov 2002 13:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262510AbSKISuY>; Sat, 9 Nov 2002 13:50:24 -0500
Received: from oe62.law11.hotmail.com ([64.4.16.197]:5892 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S262481AbSKISuY> convert rfc822-to-8bit;
	Sat, 9 Nov 2002 13:50:24 -0500
X-Originating-IP: [64.81.213.196]
From: "Dino Klein" <dinoklein@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: compile failure for ipv4/netfilter/ipt_TCPMSS.c in 2.5.46
Date: Sat, 9 Nov 2002 13:52:31 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Message-ID: <OE62sKBEr8pkpLkTgbL00002270@hotmail.com>
X-OriginalArrivalTime: 09 Nov 2002 18:57:03.0465 (UTC) FILETIME=[CAA11D90:01C28821]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following when compiling:
net/ipv4/netfilter/ipt_TCPMSS.c: In function `ipt_tcpmss_target':
net/ipv4/netfilter/ipt_TCPMSS.c:88: structure has no member named `pmtu'
net/ipv4/netfilter/ipt_TCPMSS.c:91: structure has no member named `pmtu'
net/ipv4/netfilter/ipt_TCPMSS.c:95: structure has no member named `pmtu'


I was looking around the headers (without much prior knowledge), and
wondering whether the statement:
(*pskb)->dst->pmtu
should be changed to:
(*pskb)->dst->dev->mtu

I'm just taking a stab at this; is this correct?
