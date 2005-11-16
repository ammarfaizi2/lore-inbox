Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbVKPGFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbVKPGFi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 01:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030184AbVKPGFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 01:05:38 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:28850 "HELO cstnet.cn")
	by vger.kernel.org with SMTP id S1030187AbVKPGFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 01:05:38 -0500
X-Originating-IP: [159.226.10.6]
Message-ID: <012601c5ea73$a0a1e3f0$060ae29f@javaboy>
From: "jywang" <jywang@cnic.cn>
To: <linux-kernel@vger.kernel.org>
Subject: why the tcp link can't established?
Date: Wed, 16 Nov 2005 14:04:38 +0800
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
    i change the skb when the tcp connect to aother. i mean,
i add a ip_options which include a source route in it.
reset the inet_sk(sk)->saddr to zero and reroute it.
all this done in a NF_IP_LOCAL_OUT hook.

the result is, when the host receive a ACK+SYN, a new
SYN is sent, it should be a ACK instead.

why?




