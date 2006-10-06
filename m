Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWJFQV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWJFQV0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 12:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWJFQVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 12:21:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37549 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751563AbWJFQVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 12:21:01 -0400
Subject: Re: [discuss] Re: Please pull x86-64 bug fixes
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, Andi Kleen <ak@suse.de>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0610060906140.3952@g5.osdl.org>
References: <200610051910.25418.ak@suse.de> <200610051953.23510.ak@suse.de>
	 <45255D34.804@garzik.org> <200610052142.29692.ak@suse.de>
	 <452564B9.4010209@garzik.org>
	 <Pine.LNX.4.64.0610051536590.3952@g5.osdl.org>
	 <1160132630.3000.98.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0610060906140.3952@g5.osdl.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 06 Oct 2006 18:19:57 +0200
Message-Id: <1160151597.3000.114.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-06 at 09:07 -0700, Linus Torvalds wrote:
> 
> On Fri, 6 Oct 2006, Arjan van de Ven wrote:
> >
> > we can do a tiny bit better than the current code; some chipsets have
> > the address of the MMIO region stored in their config space; so we can
> > get to that using the old method and validate the acpi code with that.
> 
> Yes. I think trusting ACPI is _always_ a mistake. It's insane. We should 
> never ask the firmware for any data that we can just figure out ourselves.
> 
> And we should tell all hardware companies that firmware tables are stupid, 
> and that we just want to know what the hell the registers MEAN!

the chipset docs do tell us that. I can even buy a case of "if we know
the chipset, just exclusively use the address from that ignore acpi".
I'm trying to find out how uniform the register format is across
chipsets, it seems many are the same, but there might be 2 varieties ;(


> 
> I've certainly tried to tell Intel that. I think they may even have heard 
> me occasionally.
> 
> I can't understand why some people _still_ think ACPI is a good idea..

I'm the wrong person to rant about ACPI against ;)


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

