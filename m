Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264638AbTFEMFI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 08:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264646AbTFEMFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 08:05:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:47329 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264638AbTFEMFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 08:05:06 -0400
Date: Thu, 05 Jun 2003 05:16:07 -0700 (PDT)
Message-Id: <20030605.051607.71090313.davem@redhat.com>
To: albert@users.sourceforge.net
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, bcollins@debian.org,
       wli@holomorphy.com, tom_gall@vnet.ibm.com, anton@samba.org
Subject: Re: /proc/bus/pci
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1054814759.22103.6114.camel@cube>
References: <Pine.LNX.4.44.0306042117440.2761-100000@home.transmeta.com>
	<1054814759.22103.6114.camel@cube>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Albert Cahalan <albert@users.sourceforge.net>
   Date: Thu, 05 Jun 2003 08:05:59 -0400
   
   To make this clear, mmap() on bar0 would get you
   a mapping of that BAR.
   
We have a way to portably mmap() PCI devices using just the device
node.

If you make this new method, you might have to define a whole
new set of arch level support hooks.

What I'm saying is, we should reuse all of this code we have
to support mmap()'ing PCI devices properly now (via procfs
device node files).
