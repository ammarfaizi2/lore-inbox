Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265213AbSJRPpy>; Fri, 18 Oct 2002 11:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265215AbSJRPpy>; Fri, 18 Oct 2002 11:45:54 -0400
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:36506 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S265213AbSJRPpx> convert rfc822-to-8bit; Fri, 18 Oct 2002 11:45:53 -0400
From: christophe varoqui <christophe.varoqui@free.fr>
Organization: devoteam
To: linux-kernel@vger.kernel.org
Subject: Re: block allocators and LVMs
Date: Fri, 18 Oct 2002 17:51:47 +0200
User-Agent: KMail/1.4.7
References: <3DA24B4A0064C333@mel-rta8.wanadoo.fr> <1034946264.3db006d87c82c@imp.free.fr> <20021018150337.GA3195@fib011235813.fsnet.co.uk>
In-Reply-To: <20021018150337.GA3195@fib011235813.fsnet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200210181751.47361.christophe.varoqui@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 October 2002 17:03, you wrote:
> On Fri, Oct 18, 2002 at 03:04:24PM +0200, christophe.varoqui@free.fr wrote:
> > I realize I didn't pick the right words (from my poor English
> > dictionnary) : I meant an extend remapper rather than a block remapper.
>
> extent remapper.
>
oops, first desillusion :)

>
> What you describe could be very beneficial, especially if you start
> striping the high bandwidth areas.  However in no way could this be
> described as 'online FS defragmentation'.
>
I realize the whole concept is different, but could extent remapping alleviate 
the need of an *intelligent* FS block allocator, as it ensure the best 
statistical-average IO perfs.

I can even imagine an *intelligent* FS block allocator being counter 
productive in the case of a heavily fragmented LV (extends out-of-order ...) 
because, after all, block allocator seem to take for granted that the device 
is linearly mapped over physical.

This whole point fade into mud if the block group object of an extN FS is 
mapped over an LVM extent. But even in this case the *simple* allocator would 
be best in combination with an extent remapper.

I don't pretend an extent remapper can replace the FS block allocator, but 
only *complex* block allocators ... and particularitly those that make the 
false assomption that underlying block device is made of linearly and 
consecutive physical blocks.

cva
