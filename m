Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270969AbTGVRqO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 13:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270981AbTGVRqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 13:46:14 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:57513 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S270969AbTGVRp6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 13:45:58 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 22 Jul 2003 10:54:02 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Jamie Lokier <jamie@shareable.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: asm (lidt) question
In-Reply-To: <Pine.LNX.4.53.0307221347400.2199@chaos>
Message-ID: <Pine.LNX.4.55.0307221052540.1372@bigblue.dev.mcafeelabs.com>
References: <20030717152819.66cfdbaf.rddunlap@osdl.org>
 <Pine.LNX.4.55.0307171535020.4845@bigblue.dev.mcafeelabs.com>
 <Pine.LNX.4.55.0307171615580.4845@bigblue.dev.mcafeelabs.com>
 <20030722172722.GC3267@mail.jlokier.co.uk> <Pine.LNX.4.55.0307221021130.1372@bigblue.dev.mcafeelabs.com>
 <Pine.LNX.4.53.0307221347400.2199@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jul 2003, Richard B. Johnson wrote:

> LIDT is "load interrupt descriptor table". SIDT is "store interrupt
> descriptor table". Only SIDT modifies memory. LIDT reads from memory
> and puts the result into a special CPU register, therefore doesn't
> modify memory.

Indeed, that why this is not really correct :

__asm__ __volatile__("lidt %0": "=m" (var));

even if it generates the same code of :

__asm__ __volatile__("lidt %0": : "m" (var));



- Davide

