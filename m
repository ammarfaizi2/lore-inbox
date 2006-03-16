Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932713AbWCPUNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932713AbWCPUNV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 15:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932716AbWCPUNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 15:13:21 -0500
Received: from smtp.uaf.edu ([137.229.34.30]:27148 "EHLO smtp.uaf.edu")
	by vger.kernel.org with ESMTP id S932713AbWCPUNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 15:13:20 -0500
From: Joshua Kugler <joshua.kugler@uaf.edu>
Organization: UAF Center for Distance Education - IT
To: linux-kernel@vger.kernel.org
Subject: Re: Bug in 2.6.16-rc6 RAID size reporting
Date: Thu, 16 Mar 2006 11:13:10 -0900
User-Agent: KMail/1.7.2
References: <200603151248.29893.joshua.kugler@uaf.edu> <17432.58799.147308.149539@cse.unsw.edu.au>
In-Reply-To: <17432.58799.147308.149539@cse.unsw.edu.au>
Cc: Neil Brown <neilb@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603161113.10555.joshua.kugler@uaf.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 March 2006 19:12, Neil Brown wrote:
> On Wednesday March 15, joshua.kugler@uaf.edu wrote:
> > Started fine, syncing at 43000K/sec or so.  Came in this morning,
> > and /proc/mdstat had this to report:
> >
> > Personalities : [raid1]
> > md1 : active raid1 etherd/e1.0[1] etherd/e0.0[0]
> >       5469958900 blocks super 1.0 [2/2] [UU]
> >       [==========================================================>] 
> > resync =292.8% (3440402688/1174991604) finish=785.8min speed=43043K/sec
> >
> > You'll notice that it says 5469958900 blocks, but 3440402688/1174991604
> > done.
>
> Hmmm. there is sever bitrot in that code.  The following patch might
> help.

I'll wait until the patch is in the official tree.  I am trying to patch rc6, 
but it seems you've made a lot of changes to your version of md.c:

patching file md.c
Hunk #1 succeeded at 4038 (offset -338 lines).
Hunk #2 succeeded at 4057 (offset -338 lines).
Hunk #3 FAILED at 4081.
1 out of 3 hunks FAILED -- saving rejects to file md.c.rej

Thanks for the fix, though.  Hope to see it in the tree soon.

j----- k-----

-- 
Joshua Kugler                 PGP Key: http://pgp.mit.edu/
CDE System Administrator             ID 0xDB26D7CE
http://distance.uaf.edu/
