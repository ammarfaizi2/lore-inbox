Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265678AbUABU4M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 15:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265680AbUABU4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 15:56:12 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:39044 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265678AbUABU4L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 15:56:11 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 2 Jan 2004 12:56:16 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Bill Davidsen <davidsen@tmr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0 batch scheduling, HT aware
In-Reply-To: <bt4j7q$6i2$1@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0401021252070.2488-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jan 2004, Bill Davidsen wrote:

> Yes and even worse, if you stop running setiathome the scientific task 
> *still* only gets half the available CPU!

Look that this is not true. If one core is not running any task, the idle 
task (if not polling) does "hlt" and the "what they call Fetch And 
Deliver" engine will be dedicated to the other core. Also, because the 
halted core not not issue any op to the execution engine, full resources 
will be available for the running task. There are many docs available 
inside the Intel developer web site that explain this.




- Davide


