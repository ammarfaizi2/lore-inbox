Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263733AbUGYGcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263733AbUGYGcz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 02:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263731AbUGYGcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 02:32:55 -0400
Received: from ns1.landhost.net ([66.98.188.87]:27586 "EHLO
	secure.landhost.net") by vger.kernel.org with ESMTP id S263733AbUGYGcx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 02:32:53 -0400
Message-ID: <41035410.2020606@marcansoft.com>
Date: Sun, 25 Jul 2004 08:32:48 +0200
From: =?ISO-8859-1?Q?H=E9ctor_Mart=EDn?= <hector@marcansoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; es-ES; rv:1.6) Gecko/20040409
X-Accept-Language: es-es, es, en-us, en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic
References: <4102CF17.2010207@marcansoft.com> <20040725012712.A15785@electric-eye.fr.zoreil.com>
In-Reply-To: <20040725012712.A15785@electric-eye.fr.zoreil.com>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - secure.landhost.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - marcansoft.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>Interrupt 9 is surely busy, no USB hardware plugged in just in case you're
>>wondering, and normally (while not using eth2) interrupt 9 is rock solid
>>(i.e. I doubt ACPI interrupts at all during normal use unless e.g. the power
>>button is pressed.)
>>
>
>At 60 kirq/s without any network traffic, you may disable acpi then usb
>and eventually poke your nose in the bios setup first. No joke.
>
That's WITH network traffic, and I get 60k packets/s so it makes sense, 
but then once ksoftirqd starts using up all available cpu, I might be 
able to stop it by stoping the network traffic, but then any traffic 
makes it go nuts anyway. The problem is that after some minutes under 
this high-udp-packet-traffic it starts going nuts, with no prior 
warning. The mouse cursor just gets jerky--nothing gradual here, it just 
starts and then won't stop.

I was talking about IRQ9 because at 60k/s it's understandable that ACPI 
takes some CPU trying to see if it's the intended receiver, but 
ksoftirqd's behaviour is obviously not normal, besides the point that it 
works perfectly por 10-20 minutes at least.

I'll be out for a week at least and I doublt I will be able to answer 
back, sorry for the inconvenience, I should've posted this after acoming 
back. Thanks for the answer though ;)
