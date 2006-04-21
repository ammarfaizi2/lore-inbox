Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWDUUx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWDUUx2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 16:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbWDUUx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 16:53:28 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:6321 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932329AbWDUUx1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 16:53:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rW82kYHwsT8oncXZFd9d20vit8itD2egKu02HrhHMWxOaKR6TQxPVSabQK3+Zw92bXi/zhAeMsaQdCAcJRm5SHP6lqmMLgAu1stWQgkLjivuMDZgjZ5ft2Em4eO2oHMUH0RTP2c4JqX8srH+czDqyLz2hw5zNZYNFdbMLVnPLQM=
Message-ID: <9871ee5f0604211353p21f29e56gaeef61255ebae85d@mail.gmail.com>
Date: Fri, 21 Apr 2006 16:53:26 -0400
From: "Timothy Miller" <theosib@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: HELP: Need to determine physical slot number of card in PCIe slot
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I apologize if this is not the right place to ask this question.  I
have done some googling around, and I have not found an answer to
this, although I suspect I'm just not using the right search terms. 
Also, I'm not a member of this list, so please CC me if you reply.

I have put together a diagnostic system for my employer using a
stripped-down Gentoo system (2.6.15 kernel).  We're testing some PCIe
cards on an ABIT IL8, which has four PCIe slots.  Since this is a test
rig, when a card fails a test, we need to know which of the four slots
the card is in.  When developing this, I had assumed that the PCI bus
ID would be a function of the slot number, but apparently, it is not. 
We can put one card into any of the four slots, and we get the same
bus ID.  If we put in four cards, we get a set of ID numbers that
isn't sequential.

I've poked around in /proc, without finding anything.  I found
/sys/bus/pci_express, but it's really weird what I see, because it
shows what appears to be some slots repeated and some missing, and
also, there doesn't seem to be a way to associate the slot with the
bus ID  (I assume pcie00 is slot zero).  Under /sys/bus/pci/devices, I
do see the PCI bus ID of the cards in question, but I cannot figure
out how to associate that with the slot number.  The directory
/sys/bus/pci/slots is empty.

Is there some reasonable way for me to be able to determine, given a
bus ID, which physical slot the PCIe card is in?

Note:  I am not using a kernel driver for these cards.  I'm using
/dev/mem to map mmio, and I'm using libpci to access PCI config space.
 Everything works great (besides the slot number issue here).

Thank you very much in advance for your help.


--- Timothy Miller
