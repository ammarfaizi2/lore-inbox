Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262783AbUKXRmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262783AbUKXRmp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 12:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbUKXRhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 12:37:32 -0500
Received: from zeus.kernel.org ([204.152.189.113]:36033 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262806AbUKXRfF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 12:35:05 -0500
Date: Wed, 24 Nov 2004 15:05:41 +0100
From: Colin Leroy <colin@colino.net>
To: hugang@soulinfo.com
Cc: Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <ncunningham@linuxmail.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@lists.linuxppc.org, benh@kernel.crashing.org
Subject: Re: [PATH] 11-24 swsusp update 3/3
Message-ID: <20041124150541.0fae077d@pirandello>
In-Reply-To: <20041124080459.GC3455@hugang.soulinfo.com>
References: <20041119194007.GA1650@hugang.soulinfo.com>
	<20041122103240.GA11323@hugang.soulinfo.com>
	<20041122110247.GB1063@elf.ucw.cz>
	<200411221254.40732.rjw@sisk.pl>
	<1101160249.7962.52.camel@desktop.cunninghams>
	<20041123215402.GE25926@elf.ucw.cz>
	<20041124080459.GC3455@hugang.soulinfo.com>
X-Mailer: Sylpheed-Claws 0.9.12cvs166.1 (GTK+ 2.4.0; i686-redhat-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Nov 2004 at 16h11, hugang@soulinfo.com wrote:

Hi, 

> +++ linux-2.6.9-ppc-g4-peval-hg/drivers/macintosh/therm_adt746x.c
> @@ -238,6 +239,11 @@
>  #endif
>  	while(!kthread_should_stop())
>  	{
> + 		if (current->flags & PF_FREEZE) {
> + 			printk(KERN_INFO "therm_adt746x: freezing thermostat\n");
> + 			refrigerator(PF_FREEZE);
> + 		}
> + 

It's already in BK:
http://linux.bkbits.net:8080/linux-2.5/cset@4174ae53kZONcTQPizEVPMKvSrJB6g
-- 
Colin
