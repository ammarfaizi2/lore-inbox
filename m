Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271068AbRICBue>; Sun, 2 Sep 2001 21:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271072AbRICBuY>; Sun, 2 Sep 2001 21:50:24 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:45784 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S271068AbRICBuK>; Sun, 2 Sep 2001 21:50:10 -0400
Date: Mon, 3 Sep 2001 03:50:25 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org,
        Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
Subject: Re: Editing-in-place of a large file
Message-ID: <20010903035025.B802@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010903032439.A802@nightmaster.csn.tu-chemnitz.de> <E15diak-0000mq-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E15diak-0000mq-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Sep 03, 2001 at 02:31:58AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2001 at 02:31:58AM +0100, Alan Cox wrote:
> Another approach would be to keep your own index of blocks and use that
> for the data reads.

That is reimplementing file system functionality in user space. 
I'm in doubts that this is considered good design...

But I've done a similar thing anyway (using a ordered list of
continous mmap()ed chunks) some years ago (see my other posting
in this thread mentioning C++) ;-)

> Since fdelete and fzero wont actually relayout the files in
> order to make the data linear (even if such calls existed)
> there isnt much point performancewise doing it in kernel space

That's the problem of the file system to be used. And the data
doesn't need to be linear. Current file systems on Linux only
avoid fragmentation, but they don't actively fight it by moving
things around, so this doesn't matter anyway.

> - its a very specialised application

Editing video and audio streams is more common then you think and
letting the user wait, while we copy 4GB around is not what I
consider user friendly, even for the selective user friendlyness
of a Unix ;-)


Regards

Ingo Oeser
