Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263792AbTFDSgO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 14:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbTFDSgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 14:36:13 -0400
Received: from air-2.osdl.org ([65.172.181.6]:44727 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263823AbTFDSgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 14:36:10 -0400
Date: Wed, 4 Jun 2003 11:50:44 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Is sys_sysfs used? 
In-Reply-To: <Pine.LNX.4.53.0306041442100.1500@chaos>
Message-ID: <Pine.LNX.4.44.0306041148230.13077-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But what would you use as a place-holder?? There are lots
> of unused sys-calls (break, acct, lock, mpx, etc). You
> certainly can't be running out of numbers, and you certainly
> can't remove  a number and change everything else, you'll
> not get up, even with static-linked files!

Mark it as unused in unistd.h (like #232 for asm-i386), and implement it 
as sys_ni_syscall in the entry.S table. 

Al has already reminded me that it must be marked deprecated for a full 
version before it can be removed, but when/if it does, then that's what 
would happen until some lucky sucker took its place.


	-pat

