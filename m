Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263675AbTK2GNg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 01:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263691AbTK2GNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 01:13:36 -0500
Received: from fep01-mail.bloor.is.net.cable.rogers.com ([66.185.86.71]:16534
	"EHLO fep01-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S263675AbTK2GNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 01:13:34 -0500
Message-ID: <3FC7F2E3.8080109@rogers.com>
Date: Sat, 29 Nov 2003 01:14:11 +0000
From: pZa1x <pZa1x@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: pZa1x <pZa1x@rogers.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: APM Suspend Problem
References: <3FC7F031.5060502@rogers.com>
In-Reply-To: <3FC7F031.5060502@rogers.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep01-mail.bloor.is.net.cable.rogers.com from [24.157.208.226] using ID <dw2price@rogers.com> at Sat, 29 Nov 2003 01:12:26 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A follow-up

by shutting down PCMCIA and rmmod'ing all the related modules ie ide_cs, 
ds, yenta_socket, pcmcia_core the suspend works on AC again.

So, I add them back one by one:
pcmcia_core -> still works
yenta_socket -> FAILS!
rmmod yenta_socket -> works again!

Summary: suspend works on my Thinkpad T21
(a) with no apm module or apmd but with all PCMCIA (ie. hardware 
suspend- close lid etc);
(b) with apm & apmd and all PCMCIA but no AC power
(c) with apm & apmd but no yenta_socket and the rest but with AC power

The problem is a combination of apm, yenta_socket and AC power.

pZa1x wrote:
> I would like to join in here. I have a Thinkpad T20 I just put 
> 2.6.0-test11 on and APM will only suspend properly if the power plug is 
> pulled out of the back (thanks for that tip, btw). With power connected, 
> it plays a high-low beep and turns off screen and HD without suspending 
> properly (and if left too long, may not come back to life).
> 
> I believe I read somewhere there is some kind of settings to override 
> power features when AC power is connected. Perhaps this problem is 
> related to that. I tried running "apm -i" and "apm -n" but it wouldn't 
> recognize the commands as set out in the man page.
> 
> If I stop apmd AND rmmod apm then I can suspend by closing the lid 
> (hardware suspend I guess) but then I have no battery monitor capability.
> 
> I tried ACPI but it would not work without =force as a kernel parameter 
> and when used, did not cleanly come back from a suspend.
> 
> APM worked perfectly in 2.4.20 which is what I used up to today. Are the 
> APM/ACPI people out there?
> 
> an interesting email on "suspend rejects" caused by kernel drivers from 
> a year ago or more:
> 
> http://open.nit.ca/lists/archives/apmd-list/msg00006.html
> 


