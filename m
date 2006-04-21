Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWDUCSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWDUCSs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWDUCSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:18:48 -0400
Received: from mail.suse.de ([195.135.220.2]:20133 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750716AbWDUCSr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:18:47 -0400
From: Andi Kleen <ak@suse.de>
To: Kimball Murray <kimball.murray@gmail.com>
Subject: Re: [git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Fri, 21 Apr 2006 04:17:58 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com, kmurray@redhat.com,
       natalie.protasevich@unisys.com, len.brown@intel.com,
       linux-acpi@vger.kernel.org
References: <20060420230931.10317.38083.sendpatchset@dhcp83-97.boston.redhat.com>
In-Reply-To: <20060420230931.10317.38083.sendpatchset@dhcp83-97.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604210417.59028.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 April 2006 01:14, Kimball Murray wrote:
> Hello!
> 
> I'm working on an x86_64 platfrom, where I've hit a problem that appears to
> be caused by a patch that went into 2.6.13 some time ago.  (git details are
> below).  Basically, that patch introduced a work-around for a VIA chipset
> limitation (only 4 bits to store a PCI interrupt).  And that work-around
> causes an unfortunate pin collision on our ioapic.


The patch looks reasonable except

- The variable should be __initdata
- The externs belong in headers

Actually I plan to garbage collect large parts of the x86-64 check_timer
RSN (basically I want to eliminate all the non ACPI compliant routing
support). That might simplify a bit. But I guess it would be still all 
needed for i386 anyways, so it's ok to have it.

-Andi
