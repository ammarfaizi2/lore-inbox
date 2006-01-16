Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbWAPPxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWAPPxz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 10:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWAPPxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 10:53:55 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:7655 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751057AbWAPPxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 10:53:55 -0500
Date: Mon, 16 Jan 2006 10:53:53 -0500
To: Joshua Kwan <joshk@triplehelix.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [?] PCI BIOS masks some IDs to prevent OS detection?
Message-ID: <20060116155353.GC18972@csclub.uwaterloo.ca>
References: <20060113144529.56fa3166@darjeeling.triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060113144529.56fa3166@darjeeling.triplehelix.org>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 02:45:29PM -0800, Joshua Kwan wrote:
> I'd like to tap some of the Linux-PCI gurus about something weird I've
> been helping a friend with...
> 
> He recently installed a PCI RAID card, and ever since, his Ethernet
> card stopped working. Further investigation revealed that his
> Realtek 8139 (10ec:8139) card had become 10ec:0139, and his 3Com Cyclone
> card had become 10b7:1055 from 10b7:9055.
> 
> Did the PCI bus decide to mask those PCI IDs to prevent some sort of
> resource conflict that would ensue from loading an appropriate driver
> for these devices?

Maybe the raid card has a pin shorted to ground, so all reads of that
bit read as 0.  That would explain why all the cards lost the same bit.
It appears to be the highest bit on the bus that is stuck low.

I see this fairly frequently on our own mainboards due to a problem with
the soldering of a surface mount pci bridge chip on the bottom of
the board.

So check if the problem goes away if the raid card is removed, and you
could check the raid card in another machine too.  Either it isn't
seated properly, or it is broken, or the pci slot is defective perhaps.

Len Sorensen
