Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbTGAQag (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 12:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbTGAQag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 12:30:36 -0400
Received: from [66.212.224.118] ([66.212.224.118]:16393 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S262771AbTGAQaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 12:30:35 -0400
Date: Tue, 1 Jul 2003 12:33:49 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Raghava Raju <vraghava_raju@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: To make a function get executed on cpu2
In-Reply-To: <20030701062017.42244.qmail@web20002.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0307011223520.2299@montezuma.mastecende.com>
References: <20030701062017.42244.qmail@web20002.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jun 2003, Raghava Raju wrote:

> In multicpu systems in kernel version 2.4.19, how 
> can we specify that a function be executed on 
> a cpu of our choice(say cpu_2). Moreover if I call a
> function from cpu_1 to be executed on cpu_2, I dont
> want to wait in cpu_1 until complete execution of
> function on cpu_2 . Is it possible?????
> 
> Any example would be really helpful. Please 
> mail back to vraghava_raju@yahoo.com.

You can't really do it portably across all architectures, Alpha has 
smp_call_function_on_cpu which would allow you to do this. If you're 
really desperate you could always do something like the following;

http://www.osdl.org/projects/irqapi/results/patch-cpu_hotplug-smp_call_function_on_cpu_i386

Good luck,
	Zwane
-- 
function.linuxpower.ca
