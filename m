Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266688AbRGOQos>; Sun, 15 Jul 2001 12:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266696AbRGOQoi>; Sun, 15 Jul 2001 12:44:38 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:19215 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S266688AbRGOQoW>; Sun, 15 Jul 2001 12:44:22 -0400
Message-ID: <3B51C864.C98B61DE@namesys.com>
Date: Sun, 15 Jul 2001 20:44:20 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: volodya@mindspring.com, Adam Schrotenboer <ajschrotenboer@lycosmail.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Stability of ReiserFS onj Kernel 2.4.x (sp. 2.4.[56]{-ac*}
In-Reply-To: <E15LopT-0004Cm-00@the-village.bc.nu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Which is a good point - can ext2 handle more than 4gig partitions ? I have
> > some vague ideas that it doesn't (and that it does not handle files more
> > than 2gig long). I am reasonable sure that ReiserFS is better in this
> > regard though I am not certain about this either.
> 
> Ext2 handles files larger than 2Gb, and can handle up to about 1Tb per volume
> which is the block layer fs size limit.
> 
> Alan

The limits for reiserfs and ext2 for kernels 2.4.x are the same (and they are 2Tb not 1Tb).  The
limits are not in the individual filesystems.  We need to have Linux go to 64 bit blocknumbers in
2.5.x, I am seeing a lot of customer demand for it.  (Or we could use scalable integers, which would
be better.)

Hans
