Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135811AbREIXNI>; Wed, 9 May 2001 19:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135813AbREIXM7>; Wed, 9 May 2001 19:12:59 -0400
Received: from mail2.bonn-fries.net ([62.140.6.78]:48391 "HELO
	mail2.bonn-fries.net") by vger.kernel.org with SMTP
	id <S135811AbREIXMo>; Wed, 9 May 2001 19:12:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: john slee <indigoid@higherplane.net>,
        Mart?n Marqu?s <martin@bugs.unl.edu.ar>
Subject: Re: reiserfs, xfs, ext2, ext3
Date: Thu, 10 May 2001 01:12:47 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01050910381407.26653@bugs> <20010510004959.B7653@higherplane.net>
In-Reply-To: <20010510004959.B7653@higherplane.net>
MIME-Version: 1.0
Message-Id: <01051001124700.06492@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 May 2001 16:49, john slee wrote:
> On Wed, May 09, 2001 at 10:38:14AM +0300, Mart?n Marqu?s wrote:
> > We are waiting for a server with dual PIII, RAID 1,0 and 5 18Gb
> > scsi disks to come so we can change our proxy server, that will run
> > on Linux with Squid. One disk will go inside (I think?) and the
> > other 4 on a tower conected to the RAID, which will be have the
> > cache of the squid server.
[...]
> also appropriate could be ext2 with daniel phillips' directory
> indexing patches.

The ext2 indexing patch is apparently stable but it's still pre-alpha 
until the hash function is finalized.  I could see using it to run 
performance tests of ext2+indexing against the alternatives, but only 
if you are prepared to rerun mke2fs later.  Then there is the matter of 
making fsck index-aware.  As it stands now, if fsck finds an index it 
will remove it.

But by all means please test the patch:

  http://nl.linux.org/~phillips/htree/dx.testme-2.4.4-4

It would be great to see a table of ReiserFS/XFS/Ext2+index performance 
results.  Well, to make it really fair it should be Ext3+index so I'd 
better add 'backport the patch to 2.2' or 'bug Stephen and friends to 
hurry up' to my to-do list.

--
Daniel
