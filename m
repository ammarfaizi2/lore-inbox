Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272557AbRH3Xbf>; Thu, 30 Aug 2001 19:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272558AbRH3XbZ>; Thu, 30 Aug 2001 19:31:25 -0400
Received: from pizda.ninka.net ([216.101.162.242]:3988 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S272557AbRH3XbU>;
	Thu, 30 Aug 2001 19:31:20 -0400
Date: Thu, 30 Aug 2001 16:31:29 -0700 (PDT)
Message-Id: <20010830.163129.55479282.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: kraxel@bytesex.org, linux-kernel@vger.kernel.org
Subject: Re: [UPDATE] 2.4.10-pre2 PCI64, API changes README
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E15cbGc-00027M-00@the-village.bc.nu>
In-Reply-To: <20010830.161453.130817352.davem@redhat.com>
	<E15cbGc-00027M-00@the-village.bc.nu>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Fri, 31 Aug 2001 00:30:34 +0100 (BST)

   That isnt done anyway - the card executes a risc instruction set for the
   DMA engine specifying which to skip and draw. So you feed it a base
   physical address for the fb via ioctl (yes this needs to be a pci device
   bar and offset I suspect) and then tell it about the fb layout and the like

We could do something interesting with /proc/bus/pci/bus/devfn nodes
I suspect.

You open the target fb pci dev, and part of the argument to the video
ioctl is:

	int pci_dev_fd;
	int resource_num;
	u64 offset;
	u64 len;

Something like that.

Later,
David S. Miller
davem@redhat.com
