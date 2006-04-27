Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964937AbWD0SQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbWD0SQv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 14:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWD0SQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 14:16:51 -0400
Received: from mail.suse.de ([195.135.220.2]:1192 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932073AbWD0SQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 14:16:50 -0400
From: Andi Kleen <ak@suse.de>
To: "Brown, Len" <len.brown@intel.com>
Subject: Re: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Thu, 27 Apr 2006 20:16:39 +0200
User-Agent: KMail/1.9.1
Cc: "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       sergio@sergiomb.no-ip.org, "Kimball Murray" <kimball.murray@gmail.com>,
       linux-kernel@vger.kernel.org, akpm@digeo.com, kmurray@redhat.com,
       linux-acpi@vger.kernel.org
References: <CFF307C98FEABE47A452B27C06B85BB64A3EAB@hdsmsx411.amr.corp.intel.com>
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB64A3EAB@hdsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604272016.39874.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 April 2006 20:13, Brown, Len wrote:
> 
> >There are probably better ways to control 224 possible IRQs by their
> >total number instead of their range, and per-cpu IDTs are the better
> >answer to the IRQ shortage altogether. But just going back to 
> >the way it was wouldn't be right I think.
> >We were able to run 2 generations of
> >systems only because we had this compression, other big systems
> >benefited from it as well.
> 
> I don't propose reverting the IRQ re-name patch and breaking the
> big iron 

It would break VIA, not the big iron.  The big iron is just broken
by not applying the new patch.

> without replacing it with something else that works. 

Sure a lot of users would be unhappy if VIA didn't work anymore.
 
> My point is that the re-name patch has added unnecessary maintenance
> complexity to the 99.9% of systems that it runs on.  We pay that price
> in several ways, including mis-understandings about what devices
> are on what irqs, and mis-understandings about how the code is
> supposed to work.

Undoubtedly it would be cleaner to not have such hacks, but do you have a 
better proposal to make VIA work?

-Andi
