Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318838AbSIISuy>; Mon, 9 Sep 2002 14:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318839AbSIISuy>; Mon, 9 Sep 2002 14:50:54 -0400
Received: from chaos.analogic.com ([204.178.40.224]:49794 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318838AbSIISuR>; Mon, 9 Sep 2002 14:50:17 -0400
Date: Mon, 9 Sep 2002 14:57:58 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Daniel Phillips <phillips@arcor.de>
cc: Imran Badr <imran.badr@cavium.com>, "'David S. Miller'" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Calculating kernel logical address ..
In-Reply-To: <E17oTcN-0006sn-00@starship>
Message-ID: <Pine.LNX.3.95.1020909145236.18459A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Sep 2002, Daniel Phillips wrote:

> On Monday 09 September 2002 20:43, Richard B. Johnson wrote:
> > On Mon, 9 Sep 2002, Daniel Phillips wrote:
> > 
> > > On Monday 09 September 2002 20:00, Richard B. Johnson wrote:
> > > > For some reason, (claimed performance reasons) user-mode code
> > > > has to be able to get data directly from hardware with no
> > > > intervening copy operation. I think any claimed advantage goes
> > > > away when you look at the overhead necessary for user-mode
> > > > code to sleep before, and awaken after, the DMA operation but
> > > > often marketing departments make those decisions.
> > > 
> > > Pfft.  Try turning off ide dma and see what happens.
> > 
> > I know that DMA works, I'm talking about DMA direct-to-user
> > which is not what the file-systems that use DMA do.
> 
> The next generation of fast, parallel filesystems relies on dma
> to/from user space.  Besides, what do you think happens when you
> read/write a mmap?

You write to some memory that may (perhaps never) be written to
the underlying device, using whatever I/O method that underlying
device uses, including network.

And, if you are going to DMA direct to/from user-space, you have
a real big performance problem when the user changes a single byte
or a small number of bytes in a file. So your (theoretical) next
generation, as you say, "fast" parallel filesystems won't be doing
this.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

