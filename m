Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266035AbRF1RCp>; Thu, 28 Jun 2001 13:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266038AbRF1RCf>; Thu, 28 Jun 2001 13:02:35 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:36366 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266032AbRF1RC2>; Thu, 28 Jun 2001 13:02:28 -0400
Subject: Re: RFC: Changes for PCI
To: tinglett@vnet.ibm.com (Todd Inglett)
Date: Thu, 28 Jun 2001 18:01:27 +0100 (BST)
Cc: davem@redhat.com (David S. Miller),
        tgall%rchland.vnet@RCHGATE.RCHLAND.IBM.COM,
        linux-kernel@vger.kernel.org
In-Reply-To: <3B3B5FCE.EF80E5E9@vnet.ibm.com> from "Todd Inglett" at Jun 28, 2001 11:48:14 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FfAV-0007GV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> beyond 256 physical busses in 2.4?  Maybe not.  But it is a simple
> change and it does work and it works around the existing drivers which
> compare busid+devfn for uniqueness when they really should compare
> pci_dev pointers.  Should it be redone the correct way (domains) in

I think it might be better to fix the needed drivers. I suspect ppc64 isnt
going to need that man drivers handle with initially

> The patch does not handle the user mode case.  This leaves the X server
> broken.  We could probably weed out busses beyond 256 under
> /proc/bus/pci as a workaround -- meaning the video adapter (if any --
> rare in these boxes) must be in one of the first I/O drawers.

Or scan the busses for video cards and number those busses 0,1,2... then
number the rest. Ugly but probably best for 2.4


