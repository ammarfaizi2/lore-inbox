Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315897AbSEGS13>; Tue, 7 May 2002 14:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315931AbSEGS12>; Tue, 7 May 2002 14:27:28 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45074 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315897AbSEGS11>; Tue, 7 May 2002 14:27:27 -0400
Date: Tue, 7 May 2002 11:27:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Greg KH <greg@kroah.com>
cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, <mochel@osdl.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] PCI reorg changes for 2.5.14
In-Reply-To: <20020507164942.GA626@kroah.com>
Message-ID: <Pine.LNX.4.44.0205071124310.1080-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 May 2002, Greg KH wrote:
>
> I've added this patch, and both Pat and I moved the files into the
> different directory name.  I'll test this all out and send an updated
> patch later today.

Greg, Pat - this changeset seems to completely break ACPI interrupt
routing.

I suspect it's an ordering issue, with the new "pci_lookup_irq" getting
assigned the wrong value (or the ACPI irq init not being done or
whatever).

Please give this a good look.

		Linus

