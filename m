Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278584AbRJXPeD>; Wed, 24 Oct 2001 11:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278587AbRJXPdy>; Wed, 24 Oct 2001 11:33:54 -0400
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:46723 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S278583AbRJXPdr>; Wed, 24 Oct 2001 11:33:47 -0400
Date: Wed, 24 Oct 2001 16:34:13 +0100 (BST)
From: James Sutherland <jas88@cam.ac.uk>
X-X-Sender: <jas88@yellow.csi.cam.ac.uk>
To: Jan Kara <jack@suse.cz>
cc: Neil Brown <neilb@cse.unsw.edu.au>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: RFC - tree quotas for Linux (2.4.12, ext2)
In-Reply-To: <20011024171658.B10075@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.SOL.4.33.0110241633000.24809-100000@yellow.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Oct 2001, Jan Kara wrote:

>   But how do you solve the following: mv <dir> <some_other_dir>
> The parent changes. You need to go through all the subdirs of <dir> and change
> the TID. This is really hard to get right and to avoid deadlocks
> and races... At least it seems to me so.

Provided you are tracking the total size in each directory, it's just a
matter of subtracting dir's size from the old parent, and adding it to the
new parent. (With suitable checks beforehand to avoid a result which
exceeds quota.)


James.
-- 
"Our attitude with TCP/IP is, `Hey, we'll do it, but don't make a big
system, because we can't fix it if it breaks -- nobody can.'"

"TCP/IP is OK if you've got a little informal club, and it doesn't make
any difference if it takes a while to fix it."
		-- Ken Olson, in Digital News, 1988

