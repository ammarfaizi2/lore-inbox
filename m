Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292285AbSBBNyQ>; Sat, 2 Feb 2002 08:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292283AbSBBNyH>; Sat, 2 Feb 2002 08:54:07 -0500
Received: from ns.suse.de ([213.95.15.193]:48397 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292286AbSBBNxu>;
	Sat, 2 Feb 2002 08:53:50 -0500
Date: Sat, 2 Feb 2002 14:53:49 +0100
From: Dave Jones <davej@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 include file shakeup.
Message-ID: <20020202145348.A6301@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020202002532.A7782@suse.de> <E16WtkG-0000ZR-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16WtkG-0000ZR-00@starship.berlin>; from phillips@bonn-fries.net on Sat, Feb 02, 2002 at 07:33:51AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2002 at 07:33:51AM +0100, Daniel Phillips wrote:

 > > The next step is to split up fs.h some more, as some things are
 > > including it for trivial bits, but sucking in things like the superblock
 > > includes for every fs.  I've already started this by moving ERR_PTR and
 > > friends into <linux/err.h>
 > 
 > Just checking - you realize that getting the super_block includes out of fs.h 
 > is easy, right?  In fact I already did it in my Unbork fs.h (1..4) set of 
 > patches last month
 
 Ah yes, I had forgotten about that thread. I'll go look through
 the archives later today, to make sure I don't duplicate any work
 already done 8-)

 >, at least I set a pattern using ext2 as an example, which 
 > is trivially extended for al filesystems.  Now, I'm just waiting for one of 
 > two things to happen: Al to decide he's finished mucking around in there and 
 > I can submit the patch to Linus, or Al will feel threatened again and submit 
 > a similar patch to Linus.
 
 Matthew Wilcox came up with a suggestion of fs.h fathering an inode.c
 which may not be an entirely bad idea given how many files pull in
 fs.h just for the inode definition, but don't need any of the fluff
 that goes along with it.

 The patch I posted yesterday still has 1-2 flaws (I introduced
 two circular dependancies in fs.h Ahem, frighteningly easy to do
 unless you keep generating the graphs and looking what changed)
 I'll fix it up, and post a corrected version tonight sometime.

 > I just find it much easier to work with and feel 
 > better about it when the kernel doesn't doesn't have its thumb tied to its 
 > nose.

 Nice choice of words. Quite.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
