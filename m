Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268967AbRHBOpu>; Thu, 2 Aug 2001 10:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268968AbRHBOpk>; Thu, 2 Aug 2001 10:45:40 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1042 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268967AbRHBOpe>; Thu, 2 Aug 2001 10:45:34 -0400
Subject: Re: Persistent device numbers
To: Andrej.Borsenkow@mow.siemens.ru (Borsenkow Andrej)
Date: Thu, 2 Aug 2001 15:37:49 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000901c11b1c$a87b1f40$21c9ca95@mow.siemens.ru> from "Borsenkow Andrej" at Aug 02, 2001 10:30:44 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15SJbh-0000iJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As far as I understand, currently kernel assigns device numbers dynamically.
> It means, that actual, user visible, controller/drive name may change if

To an extent

> Most commercial systems (O.K. those I looked into) have some sort of logical
> device numbering that assigns fixed name based on some unique hardware
> address (cf /etc/path_to_inst in Solaris). Hardware address usually is a
> path needed to access device - i.e. Bus/Slot/Channel[/drive id], so that you
> can set
> 
> PCI0/Slot3/Channel1 == eth3
> 
> and this never changes if you add or remove any card.
> 
> Do I miss something and Linux has such mechanism?

You are mostly talking about a user space problem in reality. Things like
scsiinfo for example build a directory of scsi path based names to the
disks, and the mount code supports mounting by volume label.

You might want to look at devfs too, its not my favourite solution but it
does offer  most of what you are describing
