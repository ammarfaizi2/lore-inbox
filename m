Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263606AbTKKR3B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 12:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTKKR3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 12:29:01 -0500
Received: from ACaen-202-1-1-80.w81-53.abo.wanadoo.fr ([81.53.140.80]:41258
	"HELO Genesyme.localdomain") by vger.kernel.org with SMTP
	id S263606AbTKKR27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 12:28:59 -0500
Subject: Re: reiserfs 3.6 problem with test9
From: Philippe <rouquier.p@wanadoo.fr>
To: Ragnar Hojland Espinosa <ragnar@linalco.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20031111135948.GA5229@linalco.com>
References: <1068553197.1018.43.camel@Genesyme>
	 <20031111135948.GA5229@linalco.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1068572036.344.8.camel@Genesyme>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 11 Nov 2003 18:33:56 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar 11/11/2003 à 14:59, Ragnar Hojland Espinosa a écrit :
> On Tue, Nov 11, 2003 at 01:19:57PM +0100, Philippe wrote:
> > Hello,
> > recently I noticed some annoying problems whenever I try to access some
> > files on my harddrive (reiserfs filesystem). I get "permission denied"
> > even if I am the owner or if I try as root. dmesg answers the following
> > for every file (so it's repeated):
> > 
> > is_tree_node: node level 30065 does not match to the expected one 1
> > vs-5150: search_by_key: invalid format found in block 2554621. Fsck?
> > vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to
> > find stat data of [1000086 2592 0x0 SD]
> > 
> > I rebuilt my filesystem with reiserfsck (3.6.11) and it worked, I could
> > read and write again these files. but soon after the rebuilt some other
> > files (they were not concerned by this problem before) appeared to have
> > the same problem and their number kept growing until I rebuilt again the
> > filesystem ... but again new ones appeared after an hour or two ...
> 
> Last time I had a box with similar problems it was memory.  I'd put
> your system through a memtest.

thanks for your answer.
I did as you said but no problem (memtest 3.0).
Some more info on the problem:
- file that appeared to be "access denied" are not the files I had been
using. I did not write or read them for some time.
- As I looked at the Changelogs and the changes that provoke this error
could be in test4, test5, test6, since test3 was fine.
- I first noticed the problem when I used cvs to mirror the repository
of mozilla. my entire partition was unusable afterward (I had to rebuild
everything even the super block). note that the problem appeared later
also on another partition (why / when ? I don't know) that I had not
rebuilt at all so it's not related to the rebuilding.

regards


