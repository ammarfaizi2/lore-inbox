Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264903AbTLEXt4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 18:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264905AbTLEXt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 18:49:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:7826 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264903AbTLEXty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 18:49:54 -0500
X-Authenticated: #4512188
Message-ID: <3FD1199E.2030402@gmx.de>
Date: Sat, 06 Dec 2003 00:49:50 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031116
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Allen Martin <AMartin@nvidia.com>
CC: "'Jesse Allen'" <the3dfxdude@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog - found?
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F87E@mail-sc-6.nvidia.com>
In-Reply-To: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F87E@mail-sc-6.nvidia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

*maybe* I found the bugger, at least I got APIC more stable (need to 
test whether oit is really stable, compiling kernel right now...):

It is a problem with CPU disconnect function. I tried various parameters 
in bios and turned cpu disconnect off, and tada, I could do several 
subsequent hdparms and machine is running! As CPU disconnect is a ACPI 
state, if I am not mistkaen, I think there is something broken in ACPI 
right now or in APIC and cpu disconnect triggers the bug.

Maybe now my windows environment is stable, as well. It was much more 
stable with cpu disconnect and apic, nevertheless seldomly locked up.


So gals and guys, try disabling cpu disconnect in bios and see whether 
aopic now runs stable.

I have an Abit NF7-S Rev2.0 with Bios 2.0.

Prakash

