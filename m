Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbWE0FzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWE0FzN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 01:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWE0FzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 01:55:13 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:37783 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751402AbWE0FzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 01:55:11 -0400
Date: Fri, 26 May 2006 10:38:30 -0400
To: Robert Hancock <hancockr@shaw.ca>
Cc: Linas Vepstas <linas@austin.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCI reset using x86 or x86-64 BIOS calls?
Message-ID: <20060526143830.GA16442@csclub.uwaterloo.ca>
References: <6gr2t-1Pp-9@gated-at.bofh.it> <44765F57.90703@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44765F57.90703@shaw.ca>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 07:52:23PM -0600, Robert Hancock wrote:
> Unlikely - if you mean just resetting one PCI device, it's likely 
> electrically impossible on many, if not most machines as the RST lines 
> will be tied together on all slots.
> 
> The BIOS might possibly have the ability to issue a PCI bus reset 
> independent of resetting the CPU, chipset, etc. but I don't think 
> there's any standardized way to trigger this, even so.
> 
> In any case, I don't think - or at least would hope - that a PCI device 
> going so far into the weeds that it can't be recovered without a RST 
> would be a rare situation.

Well I know there is a way to make a pci to pci bridge assert reset on
the secondary bus, which of course resets all devices behind the bridge.
I am not sure when, other than in the bios, this would be useful.  I
wouldn't want to have to go clean up the pci configuration settings on
all the devices after the reset.  I considered doing it to solve a rare
problem with some pci cards, but decided a reboot was simpler.

Len Sorensen
