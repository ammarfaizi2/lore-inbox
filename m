Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWDTQcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWDTQcb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 12:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbWDTQcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 12:32:31 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:5590 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751070AbWDTQca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 12:32:30 -0400
Date: Thu, 20 Apr 2006 17:32:23 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: "Yu, Luming" <luming.yu@intel.com>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Message-ID: <20060420163222.GA30197@srcf.ucam.org>
References: <554C5F4C5BA7384EB2B412FD46A3BAD1332980@pdsmsx411.ccr.corp.intel.com> <20060420073713.GA25735@srcf.ucam.org> <4447AA59.8010300@linux.intel.com> <20060420153848.GA29726@srcf.ucam.org> <4447AF4D.7030507@linux.intel.com> <20060420161546.GB30021@srcf.ucam.org> <4447B692.3000704@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4447B692.3000704@linux.intel.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 08:28:02PM +0400, Alexey Starikovskiy wrote:

> I don't quite understand your point... You want all buttons/switches in a 
> computer to send events to input layer, regardless if this make sense or 
> not, just to be consistent? May be you should go other way around and  if 
> keyboard has some strange key, send it on its strange way? 

There's a reason that KEY_POWER and KEY_SLEEP are already present in 
/usr/include/linux/input.h. It makes sense to expose keys that are on my 
keyboard in the same way as other keys on my keyboard. Just think of the 
ACPI events interface as a bus that a small keyboard with not many keys 
sits on.

>From the userspace point of view, it's *far* easier to deal with this 
stuff if the keys generate keycodes.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
