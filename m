Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155296AbQAaHzP>; Mon, 31 Jan 2000 02:55:15 -0500
Received: by vger.rutgers.edu id <S155133AbQAaH1V>; Mon, 31 Jan 2000 02:27:21 -0500
Received: from [216.101.162.242] ([216.101.162.242]:32812 "EHLO pizda.ninka.net") by vger.rutgers.edu with ESMTP id <S155126AbQAaGrq>; Mon, 31 Jan 2000 01:47:46 -0500
Date: Mon, 31 Jan 2000 02:09:37 -0800
Message-Id: <200001311009.CAA06036@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: Jes.Sorensen@cern.ch
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.rutgers.edu
In-reply-to: <d3oga2r22z.fsf@lxplus011.cern.ch> (message from Jes Sorensen on 31 Jan 2000 11:02:28 +0100)
Subject: Re: DMA changes in 2.3.41 - how the f* do I get this working on ARM?
References: <200001300006.AAA02084@raistlin.arm.linux.org.uk> <200001302211.OAA03036@pizda.ninka.net> <d3oga2r22z.fsf@lxplus011.cern.ch>
Sender: owner-linux-kernel@vger.rutgers.edu

   From: Jes Sorensen <Jes.Sorensen@cern.ch>
   Date: 31 Jan 2000 11:02:28 +0100

   The place where this is a real problem is in drivers where data is
   shared between the adapter and the host CPU, for instance the
   53c7xx driver. On the m68k we currently use a
   kernel_set_cachemode() function to change the caching of the page
   allocated for the shared structures, but thats a pretty non
   portable way of doing it. I would like to see something a
   get_free_cachecoherent_page() interface instead, what do you think
   of that?

Sounds like pci_alloc_consistent()

Go read the document and check out the interfaces, I believe
you'll be pleasantly surprised :-)

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
