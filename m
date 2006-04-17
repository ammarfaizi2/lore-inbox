Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWDQPkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWDQPkx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 11:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWDQPkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 11:40:52 -0400
Received: from wasp.net.au ([203.190.192.17]:51179 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S1751135AbWDQPkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 11:40:52 -0400
Message-ID: <4443B750.2050506@wasp.net.au>
Date: Mon, 17 Apr 2006 19:42:08 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Thunderbird 3.0a1 (X11/20060414)
MIME-Version: 1.0
To: dtor_core@ameritech.net
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16.1 psmouse.c: TouchPad at isa0060/serio4/input0 lost sync
 at byte 1 and ACPI
References: <44437793.20908@wasp.net.au>	 <d120d5000604170522q54b4b6ftc263f16a649a99e7@mail.gmail.com>	 <44439FCE.50809@wasp.net.au> <d120d5000604170816i5ea3d0b8m71e454dd5e49b6cd@mail.gmail.com>
In-Reply-To: <d120d5000604170816i5ea3d0b8m71e454dd5e49b6cd@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> Would you mind telling me what these applications are? Hopefully they
> only poll "status" and not "info" file. And 2 seconds is definitely
> too high. It would be nice if you could reduce "pollers" to just 1
> application though.

Sure.. one is "allin1" a dockapp, one is cpufreqd (which polls the ac adaptor and not the battery), 
then we have  and the other is a script I wrote to poll every 60s or so to tickle my suspend script 
when the battery drops to 5%

When I really want to beat it up I have another script (which is the 2s poll) that estimates battery 
time remaining based on the delta of each percent drop in battery time (as my retarded acpi bios 
just estimates it based on a 4 hr runtime with a linear division of the % left)

I've modified allin1 to poll about once a minute. I have to look closer at cpufreqd to see how that 
one polls yet.

Regards,
Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
