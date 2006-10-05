Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWJEVpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWJEVpG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWJEVoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:44:38 -0400
Received: from mx1.suse.de ([195.135.220.2]:59809 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932283AbWJEVo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:44:26 -0400
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [discuss] Re: Please pull x86-64 bug fixes
Date: Thu, 5 Oct 2006 23:44:18 +0200
User-Agent: KMail/1.9.3
Cc: Jeff Garzik <jeff@garzik.org>, discuss@x86-64.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
References: <200610051910.25418.ak@suse.de> <200610051953.23510.ak@suse.de> <1160085649.1607.35.camel@localhost.localdomain>
In-Reply-To: <1160085649.1607.35.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610052344.18598.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 October 2006 00:00, Alan Cox wrote:
> Ar Iau, 2006-10-05 am 19:53 +0200, ysgrifennodd Andi Kleen:
> > If you have a patch that works with all known BIOS bugs (including Mac Mini,
> > a random Intel 975 board and a Asus AMD K8 board with PCI Express) please share it.
> 
> Well you currently don't have such a patch so thats a disingenuous
> argument.

Sure if I had one I wouldn't need one from Jeff

(who is frankly currently deeply in the  
"it is much easier to give suggestions if you don't understand the problem"
state) 

The current kernel boots everywhere at least and enables mmconfig 
if the BIOS marks it in e820 (which at least some
systems do). Getting it to this point wasn't easy and required
several iterations.

> 	pci_requires_mmconfig(dev)
> 
> which forces it on for that device regardless and may (internal
> implementation detail) print a warning "if your system hangs at this
> point.." type message.

and the user will never see that message because it hangs? 

I think we had that argument before. IMHO such messages are completely
useless. Hangs are not acceptable no matter what messages are printed
before.
 
> That gets us the best of both worlds.

Hanging systems? 

-Andi
 
