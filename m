Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315415AbSFTSxB>; Thu, 20 Jun 2002 14:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315416AbSFTSw5>; Thu, 20 Jun 2002 14:52:57 -0400
Received: from host194.steeleye.com ([216.33.1.194]:60684 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S315415AbSFTSw4>; Thu, 20 Jun 2002 14:52:56 -0400
Message-Id: <200206201852.g5KIqoJ06342@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Linus Torvalds <torvalds@transmeta.com>
cc: Patrick Mansfield <patmans@us.ibm.com>, Andries Brouwer <aebr@win.tue.nl>,
       Martin Schwenke <martin@meltin.net>, Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [PATCH] /proc/scsi/map 
In-Reply-To: Message from Linus Torvalds <torvalds@transmeta.com> 
   of "Thu, 20 Jun 2002 11:36:25 PDT." <Pine.LNX.4.44.0206201133180.8225-100000@home.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 20 Jun 2002 14:52:50 -0400
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com said:
> SCSI people, how does that patch look to you? Apparently it does
> everything the scsimap thing does, in a way that is certainly
> acceptable to me. 

It looks OK to me.  It doesn't quite do everything you want in terms of doing 
your bus1/id2/lun0 piece, but it's a good start.

We should probably have some more discussion about the layout of the device 
tree, particularly if it's going to be consistent with other devices like ide 
discs and cds.

I'd like to see the "name" field become mutable from user level somehow just 
so we can fix the enterprise name on broken devices without having to have a 
huge kernel exception table, but that's my only current concern.

James


