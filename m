Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293538AbSCCJXu>; Sun, 3 Mar 2002 04:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293534AbSCCJXl>; Sun, 3 Mar 2002 04:23:41 -0500
Received: from relay04.valueweb.net ([216.219.253.238]:51722 "EHLO
	relay04.valueweb.net") by vger.kernel.org with ESMTP
	id <S293538AbSCCJX1>; Sun, 3 Mar 2002 04:23:27 -0500
Content-Type: text/plain; charset=US-ASCII
From: Craig Christophel <merlin@transgeek.com>
To: linux-kernel@vger.kernel.org
Subject: Quota patches for 2.5
Date: Sun, 3 Mar 2002 04:23:45 -0500
X-Mailer: KMail [version 1.3.1]
Cc: jack@suse.cz, Alexander Viro <viro@math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020303092308Z293039-31668+14@thor.valueweb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Included in the following 13 emails are Jan Kara's current quota patches 
forward ported to 2.5.6-pre2. They comprise a rewrite of the quota system 
allowing for quota plugins much like filesystem plugins and a new quota 
structure.  He will have to comment on the stability, but they look good from 
where I sit.

	He origionally has 12 patches which are included, and I added one patch to 
change sync_dquot_dev to sync_dquot_all and fix all of the references to 
dquot->dq_dev as Al Viro is getting rid of kdev_t in the places where this 
was to be used.  Also fixed are some compile errors created by me misspelling 
on the cut/paste portion.  

	From Jan's comments: the patches I ported from all compile cleanly and run 
reasonably.  There is also a compatibility interface as one of the patches.  

	These are a beginning of a threaded quota system, in keeping with the desire 
to remove the BKL from as much of the FS as possible.

	The patches to create a threaded quota system are not included, but the 
quota system needs to be updated before any work on threading can be done 
within reason.  

	Al and Jan, please comment as you feel neccesary/inclined, and anyone else 
as you wish.

	Craig.
