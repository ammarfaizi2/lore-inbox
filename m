Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751659AbWCLSDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbWCLSDM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 13:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbWCLSDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 13:03:11 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60098 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751612AbWCLSDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 13:03:11 -0500
Subject: Re: Memory barriers and spin_unlock safety
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Hancock <hancockr@shaw.ca>
Cc: Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <441225B7.5010003@shaw.ca>
References: <5Ml19-2Ki-19@gated-at.bofh.it> <5MlO0-3JU-13@gated-at.bofh.it>
	 <5MCF0-2TS-27@gated-at.bofh.it> <5MITJ-2l4-15@gated-at.bofh.it>
	 <5NXxl-6WZ-9@gated-at.bofh.it> <5NY0h-7wa-1@gated-at.bofh.it>
	 <441225B7.5010003@shaw.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 12 Mar 2006 18:09:12 +0000
Message-Id: <1142186952.20056.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-03-10 at 19:19 -0600, Robert Hancock wrote:
> PCI I/O writes are allowed to be posted by the host bus bridge (not 
> other bridges) according to the PCI 2.2 spec. Maybe no x86 platform 
> actually does this, but it's allowed, so technically a device would need 
> to do a read in order to ensure that I/O writes have arrived at the 
> device as well.

Existing Linux drivers largely believe that PCI I/O cycles as opposed to
MMIO cycles are not posted. At least one MIPS platform that did post
them ended up ensuring PCI I/O cycle posting didn't occur to get a
running Linux system - so its quite a deep assumption.

