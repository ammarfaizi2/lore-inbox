Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280967AbRKGUok>; Wed, 7 Nov 2001 15:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280971AbRKGUoa>; Wed, 7 Nov 2001 15:44:30 -0500
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:50576 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S280967AbRKGUoS>; Wed, 7 Nov 2001 15:44:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: James A Sutherland <jas88@cam.ac.uk>
To: Ville Herva <vherva@niksula.hut.fi>
Subject: Re: ext3 vs resiserfs vs xfs
Date: Wed, 7 Nov 2001 20:44:25 +0000
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E161UYR-0004S5-00@the-village.bc.nu> <E161Vbf-0000m9-00@lilac.csi.cam.ac.uk> <20011107213837.F26218@niksula.cs.hut.fi>
In-Reply-To: <20011107213837.F26218@niksula.cs.hut.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E161ZYW-0006ky-00@mauve.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 November 2001 7:38 pm, Ville Herva wrote:
> On Wed, Nov 07, 2001 at 04:31:24PM +0000, you [James A Sutherland] claimed:
> > Hm.. after a decidedly unclean shutdown, I decided to force an fsck here
> > and my ext3 partition DID have two inode errors on fsck... (Having said
> > that, the last entry in syslog was from the SCSI driver, and ext3's
> > journalling probably doesn't help much when the disk it's on goes
> > AWOL...)
>
> A stupid question: does ext3 replay the journal before fsck? If not, the
> inode errors would be expected...

Yes, it does: this was AFTER the journal replay. And yes, it was ext3 not 
ext2 mounting it (well, either that or ext2 has learned to do journal 
replays...). So, AFTER a journal replay, there were still two damaged inodes 
- which sounds like Anton's problem. Maybe ext3 just hates Cambridge? :-)


James.
