Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269058AbRG3SAs>; Mon, 30 Jul 2001 14:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269049AbRG3SAk>; Mon, 30 Jul 2001 14:00:40 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:5 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S269048AbRG3SAc>; Mon, 30 Jul 2001 14:00:32 -0400
Date: Mon, 30 Jul 2001 13:59:04 -0400
From: Chris Mason <mason@suse.com>
To: Lawrence Greenfield <leg+@andrew.cmu.edu>,
        Rik van Riel <riel@conectiva.com.br>, Chris Wedgwood <cw@f00f.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>
Subject: Re: ext3-2.4-0.9.4
Message-ID: <464190000.996515944@tiny>
In-Reply-To: <200107301749.f6UHnCHE001961@acap-dev.nas.cmu.edu>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Monday, July 30, 2001 01:49:12 PM -0400 Lawrence Greenfield
<leg+@andrew.cmu.edu> wrote:

>    Date: Tue, 31 Jul 2001 05:38:13 +1200
>    From: Chris Wedgwood <cw@f00f.org>
> 
>    On Mon, Jul 30, 2001 at 02:25:51PM -0300, Rik van Riel wrote:
> 
>        Note that this is very different from the "link() should be
>        synchronous()" mantra we've been hearing over the last days.
> 
>        These fsync() semantics make lots of sense to me, I'm all
>        for it.
> 
>    And what if the file has hundreds or thousands of links? How do we
>    cleanly keep track of all those?
> 
> You don't have to keep track of all of them, just the uncommitted
> ones. 

Well, the idea is to get it done in the VFS layer.  reiserfs, ext3, and
probably the other journaled filesystems could keep track of the last
transacation and inode was involved with, making the softupdate style
fsync(file) to commit a rename easy.

But, ext2 and the normal filesystems don't have it quite so good.

-chris


