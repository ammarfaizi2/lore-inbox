Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264414AbTLKXhZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 18:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbTLKXhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 18:37:25 -0500
Received: from smtp.enternet.hu ([62.112.192.21]:63748 "EHLO smtp.enternet.hu")
	by vger.kernel.org with ESMTP id S264414AbTLKXhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 18:37:24 -0500
Message-ID: <002301c3c03f$ba925250$0101010a@client>
From: "Hettinger Tamas" <hetting@freemail.hu>
To: <linux-kernel@vger.kernel.org>
Subject: 
Date: Fri, 12 Dec 2003 00:37:23 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody !

I've been developing a kernel module and I needed some timer functions. I
found init_timer() add_timer() del_timer() etc... but I would ask some
questions about them.

1) When I set a timer, it is added to a timer_list chain with add_timer().
If the time is up and the scheduled function is called, should I remove the
timer_list struct from the chain via del_timer() ? Or is it removed
automatically ?

2) How can a module safely removed if it has some running timers ? I have to
call del_timer() in cleanup_module() for each running timer ? And what's the
purpose of the timer_pending function ?

thanks

