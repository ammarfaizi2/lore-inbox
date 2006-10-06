Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751550AbWJFQIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbWJFQIS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 12:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbWJFQIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 12:08:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14563 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751550AbWJFQIR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 12:08:17 -0400
Date: Fri, 6 Oct 2006 09:07:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: Jeff Garzik <jeff@garzik.org>, Andi Kleen <ak@suse.de>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: Please pull x86-64 bug fixes
In-Reply-To: <1160132630.3000.98.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0610060906140.3952@g5.osdl.org>
References: <200610051910.25418.ak@suse.de> <200610051953.23510.ak@suse.de>
  <45255D34.804@garzik.org> <200610052142.29692.ak@suse.de> 
 <452564B9.4010209@garzik.org>  <Pine.LNX.4.64.0610051536590.3952@g5.osdl.org>
 <1160132630.3000.98.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Oct 2006, Arjan van de Ven wrote:
>
> we can do a tiny bit better than the current code; some chipsets have
> the address of the MMIO region stored in their config space; so we can
> get to that using the old method and validate the acpi code with that.

Yes. I think trusting ACPI is _always_ a mistake. It's insane. We should 
never ask the firmware for any data that we can just figure out ourselves.

And we should tell all hardware companies that firmware tables are stupid, 
and that we just want to know what the hell the registers MEAN!

I've certainly tried to tell Intel that. I think they may even have heard 
me occasionally.

I can't understand why some people _still_ think ACPI is a good idea..

		Linus
