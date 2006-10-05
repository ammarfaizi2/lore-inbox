Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751737AbWJERba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbWJERba (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 13:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWJERba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 13:31:30 -0400
Received: from cantor2.suse.de ([195.135.220.15]:56541 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751737AbWJERb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 13:31:29 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: Please pull x86-64 bug fixes
Date: Thu, 5 Oct 2006 19:31:23 +0200
User-Agent: KMail/1.9.3
Cc: Jeff Garzik <jeff@garzik.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
References: <200610051910.25418.ak@suse.de> <45253E37.6070305@garzik.org>
In-Reply-To: <45253E37.6070305@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610051931.23884.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 19:17, Jeff Garzik wrote:

> Does this fix the following issue:
> 
> PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
> PCI: Not using MMCONFIG.
> 
> 100% of my x86-64 boxes, AMD or Intel, print this message.  And 100% of 
> them work just fine with MMCONFIG.

No. 

But it isn't really a issue. Basically everything[1] will work fine anyways.

[1]  Only thing you're missing AFAIK is PCI Extended Error Reporting.

> I think this rule is far too drastic for real life.

If you have a better proposal please share. I tried a few others, but none
of them could handle all the buggy Intel 9x5 boards that hang on any
mmconfig access (so the "try the first few busses" check already hangs)

Originally I thought
DMI blacklisting would work, but it's on too many systems for that
(and Linus rightfully hated it anyways). ACPI checks also didn't work.
I don't know of any others.

-Andi
