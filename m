Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276877AbRJ0T01>; Sat, 27 Oct 2001 15:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276894AbRJ0T0R>; Sat, 27 Oct 2001 15:26:17 -0400
Received: from calais.pt.lu ([194.154.192.52]:56313 "EHLO calais.pt.lu")
	by vger.kernel.org with ESMTP id <S276877AbRJ0T0M>;
	Sat, 27 Oct 2001 15:26:12 -0400
Message-Id: <200110271926.f9RJQcT01766@hitchhiker.org.lu>
To: Alexander Viro <viro@math.psu.edu>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org
Reply-To: alain@linux.lu
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Re: Poor floppy performance in kernel 2.4.10 
In-Reply-To: Your message of "Sat, 27 Oct 2001 15:19:48 EDT."
             <Pine.GSO.4.21.0110271517010.21545-100000@weyl.math.psu.edu> 
Date: Sat, 27 Oct 2001 21:26:37 +0200
From: Alain Knaff <Alain.Knaff@hitchhiker.org.lu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>On Sat, 27 Oct 2001, Alain Knaff wrote:
>
>> And "mapping" itself seems to point to i_data of the device's inode
>> structure (not the device entry's inode, but the device's itself).
> 
>> Which means that if the inode is put (all references to the block
>> device closed), and later the same major/minor is reopened, it may
>
>Stop here.  bdev->bd_inode is destroyed only when bdev is destroyed.
>If we make block_device long-living (i.e. they stay around until all
>pages are evicted from cache _or_ device gets unregistered) ->bd_inode
>will follow.

That would be ok with me. Long live block_device! ;-)

Alain
