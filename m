Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263813AbUDQKzE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 06:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbUDQKzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 06:55:04 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:63186 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S263813AbUDQKzB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 06:55:01 -0400
From: Duncan Sands <baldrick@free.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: kgdboe: spinlock already locked
Date: Sat, 17 Apr 2004 12:54:58 +0200
User-Agent: KMail/1.5.4
References: <200404161730.46655.baldrick@free.fr>
In-Reply-To: <200404161730.46655.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404171254.58472.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> drivers/net/8139too.c:2098: spin_lock(drivers/net/8139too.c:c15c93a0)
> already locked by drivers/net/8139too.c/2098 drivers/net/8139too.c:2120:
> spin_unlock(drivers/net/8139too.c:c15c93a0) not locked

Without preempt, I instead get plenty of these:

eth0: Out-of-sync dirty pointer ... vs ...

(8139too.c, line 1816).

Ciao,

Duncan.
