Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264536AbTH2K4u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 06:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264539AbTH2K4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 06:56:50 -0400
Received: from dyn-ctb-203-221-73-68.webone.com.au ([203.221.73.68]:62730 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S264536AbTH2K4o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 06:56:44 -0400
Message-ID: <3F4F3162.9040307@cyberone.com.au>
Date: Fri, 29 Aug 2003 20:56:34 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test4: Hang in i8042_init
References: <3F4EDC47.2020302@cyberone.com.au> <1062153908.700.4.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1062153908.700.4.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Felipe Alfaro Solana wrote:

>On Fri, 2003-08-29 at 06:53, Nick Piggin wrote:
>
>>Is what I am getting. Last line is something like input: PC Speaker
>>(followed by the initcall).
>>
>>dmseg and lspci from a working kernel attached. Let me know if I can
>>do more.
>>
>
>Could it be something related with
>http://bugzilla.kernel.org/show_bug.cgi?id=1123?
>
>
>

Yes it seems quite likely. Further poking reveals that the
box still locks with a PS2 mouse _and_ the USB mouse. A PS2
mouse on its own allows the system to boot, although
interrupt 10 (eth0, usb) is not working. Booting with
acpi=off allows the system to boot normally with the USB
mouse, and interrupt 10 works.


