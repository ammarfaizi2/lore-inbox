Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267086AbRGOWGX>; Sun, 15 Jul 2001 18:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267088AbRGOWGM>; Sun, 15 Jul 2001 18:06:12 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:60932 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S267086AbRGOWFx>; Sun, 15 Jul 2001 18:05:53 -0400
Message-ID: <3B5213BB.12F792C3@namesys.com>
Date: Mon, 16 Jul 2001 02:05:47 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, volodya@mindspring.com,
        Adam Schrotenboer <ajschrotenboer@lycosmail.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Stability of ReiserFS onj Kernel 2.4.x (sp. 2.4.[56]{-ac*}
In-Reply-To: <E15LopT-0004Cm-00@the-village.bc.nu> <3B51C864.C98B61DE@namesys.com> <01071523304400.06482@starship>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Sunday 15 July 2001 18:44, Hans Reiser wrote:
> > The limits for reiserfs and ext2 for kernels 2.4.x are the same (and
> > they are 2Tb not 1Tb).  The limits are not in the individual
> > filesystems.  We need to have Linux go to 64 bit blocknumbers in
> > 2.5.x, I am seeing a lot of customer demand for it.  (Or we could use
> > scalable integers, which would be better.)
> 
> Or we could introduce the notion of logical blocksize for each block
> minor so that we can measure blocks in the same units the filesystem
> uses.  This would give us 16 TB while being able to stay with 32 bits
> everywhere outside the block drivers themselves.
> 
> We are not that far away from being able to handle 8K blocks, so that
> would bump it up to 32 TB.
> 
> --
> Daniel
16TB is not enough.

I agree that blocknumbers are a significant space user in FS metadata, which is why I think scalable
integers are correct.

Hans
