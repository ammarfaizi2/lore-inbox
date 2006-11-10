Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946673AbWKJOCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946673AbWKJOCX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 09:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946670AbWKJOCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 09:02:23 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:35712 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1946673AbWKJOCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 09:02:22 -0500
Message-ID: <45548662.1000409@garzik.org>
Date: Fri, 10 Nov 2006 09:02:10 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Adrian Bunk <bunk@stusta.de>, Jeff Chua <jeff.chua.linux@gmail.com>,
       Matthew Wilcox <matthew@wil.cx>, Aaron Durbin <adurbin@google.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [discuss] Re: 2.6.19-rc4: known unfixed regressions (v3)
References: <Pine.LNX.4.64.0611080056480.12828@silvia.corp.fedex.com>	 <Pine.LNX.4.64.0611080932320.3667@g5.osdl.org>	 <Pine.LNX.4.64.0611080951040.3667@g5.osdl.org>	 <200611100757.00203.ak@suse.de> <1163153778.7900.17.camel@localhost.localdomain>
In-Reply-To: <1163153778.7900.17.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Gwe, 2006-11-10 am 07:56 +0100, ysgrifennodd Andi Kleen:
>> I'm sure some people will be upset again if we don't use it.
>> Perhaps there are really users who want to use the PCI-E error handling
>> for example.
> 
> And there is now hardware out there which requires accessing PCI-E
> configuration spaces. Disabling it for those cases is not a sensible
> option t all.

Yeah, mmconfig is required for accessing extended PCI configuration 
space, and for accessing ANY devices on a non-zero PCI segment (read: 
x86 PCI domains).

If you have boot devices on a PCI domain bus, you aren't booting at all, 
unless you're running -mm...

	Jeff



