Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbTEUWrH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 18:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbTEUWrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 18:47:07 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:10881
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S262324AbTEUWrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 18:47:06 -0400
Date: Wed, 21 May 2003 18:50:08 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Paul Rolland <rol@as2917.net>
cc: "'Corey Minyard'" <minyard@acm.org>, "" <linux-kernel@vger.kernel.org>
Subject: Re: e100 latency, cpu cycle saver and e1000...
In-Reply-To: <011a01c31fa3$725354e0$3f00a8c0@witbe>
Message-ID: <Pine.LNX.4.50.0305211848130.25777-100000@montezuma.mastecende.com>
References: <011a01c31fa3$725354e0$3f00a8c0@witbe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 May 2003, Paul Rolland wrote:

> Correct, machines are not idle... but 
>  - they are doing globally the same work,
>  - this behavior is something I can reproduce test after test, since
>    I've started this morning...
> 
> I started using that because IP1 was exhibiting high latency yesterday
> 'til I rebooted it, and since it is working quite fine...
> Of course, I can reboot also IP2, but I'd like to understand why
> and how to avoid it later...

One thing you can do to reduce packet handling latency (at the cost of 
CPU) with both the e1000 is drop down the RX Delay Interrupt timers, ditto 
for the Tx Delay. The hardware delays in increments of 1.024ms

	Zwane
-- 
function.linuxpower.ca
