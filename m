Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262523AbTEFKiJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 06:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbTEFKiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 06:38:09 -0400
Received: from [66.212.224.118] ([66.212.224.118]:53004 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id S262523AbTEFKiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 06:38:08 -0400
Date: Tue, 6 May 2003 06:41:57 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@digeo.com>, Shane Shrybman <shrybman@sympatico.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.68-mmX: Drowning in irq 7: nobody cared!
In-Reply-To: <1052213733.28797.1.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.50.0305060636560.13957-100000@montezuma.mastecende.com>
References: <1052141029.2527.27.camel@mars.goatskin.org> 
 <20030505143006.29c0301a.akpm@digeo.com> <1052213733.28797.1.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003, Alan Cox wrote:

> With APIC at least it doesnt suprise me the least. The IRQ hack seems
> extremely racey. Remember on most systems (especially with PIII type
> APIC) IRQ delivery is asynchronous to the bus so you get
> 
> IRQ arrives
> 			sound card
> 			loop
> 				clean up IRQ
> IRQ sent
> 				still more work, do it
> 			done
> 			HANDLED
> 
> IRQ arrives
> 			sound card
> 			Umm duh no work for me
> 			NOT HANDLED
> 
> 		Whine
> 
> For anything where you get pairs of close IRQ's

Shouldn't this also be observed more easily on P4/xAPIC since you can have 
a pending vector in the IRR and ISR whilst the core processes one.

	Zwane
-- 
function.linuxpower.ca
