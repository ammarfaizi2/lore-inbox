Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262528AbVGMADg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbVGMADg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 20:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVGMADg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 20:03:36 -0400
Received: from unused.mind.net ([69.9.134.98]:41880 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S262528AbVGMADE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 20:03:04 -0400
Date: Tue, 12 Jul 2005 17:02:13 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Ingo Molnar <mingo@elte.hu>
cc: "K.R. Foley" <kr@cybsft.com>, Daniel Walker <dwalker@mvista.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
In-Reply-To: <20050712160150.GA23943@elte.hu>
Message-ID: <Pine.LNX.4.58.0507121641410.21776@echo.lysdexia.org>
References: <200507121223.10704.annabellesgarden@yahoo.de> <20050712140251.GB18296@elte.hu>
 <1121178339.10199.8.camel@c-67-188-6-232.hsd1.ca.comcast.net>
 <20050712142828.GA20798@elte.hu> <42D3D7ED.7000805@cybsft.com>
 <20050712160150.GA23943@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2005, Ingo Molnar wrote:

> * K.R. Foley <kr@cybsft.com> wrote:
> 
> > Is this why I have been able to boot the latest versions without the 
> > noapic option (and without noticeable keyboard repeat problems) or has 
> > it just been dumb luck?
> 
> yes, i think it's related - the IO-APIC code is now more robust than 
> ever, and that's why any known-broken system would be important to 
> re-check.

Just brought the SIS based Xeon box up on -51-28 with CONFIG_IOAPIC_FAST
and without the noapic option, and all is well.  On -50-43, noapic was 
needed to avoid the spurious interrupt and APIC error on CPU0 messages.

Are there any non-SIS chipsets out there that need the sis_apic_bug 
checks?  What about IOAPIC_POSTFLUSH?

--ww
