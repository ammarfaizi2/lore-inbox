Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261815AbTCGWTZ>; Fri, 7 Mar 2003 17:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261817AbTCGWTZ>; Fri, 7 Mar 2003 17:19:25 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:37807
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261815AbTCGWTY>; Fri, 7 Mar 2003 17:19:24 -0500
Subject: Re: Interrupt problem, no USB on SMP machine with 2.4.19/20/21
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Ed Wildgoose <Ed@Wildgooses.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030307221343.GC21315@kroah.com>
References: <3E68F616.3090602@Wildgooses.com>
	 <20030307221343.GC21315@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047080149.23803.25.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 07 Mar 2003 23:35:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-07 at 22:13, Greg KH wrote:
> Have you booted with "noapic" on the command line?  That's the only way
> a lot of VIA motherboards will get their onboard USB controller to work
> properly.

VIA onboard devices require the interrupt line and pin are both written in
APIC mode. Linux for reasons I still don't understand does not do that by
default. The current -ac tree has a quirk for this although it doesnt seem
to be working for all cases and needs a victim to review it more carefully

