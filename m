Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269814AbUH0AD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269814AbUH0AD4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 20:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269827AbUH0ABe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 20:01:34 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:39107 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S269761AbUHZX55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 19:57:57 -0400
Date: Fri, 27 Aug 2004 00:57:56 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org
Subject: maintaining DRM and using bitkeeper..
Message-ID: <Pine.LNX.4.58.0408270043170.25111@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Okay I want to ask other groups of developers how they are maintaining
subsystems away from linux-kernel list and how they get things merged?

The biggest problem we are facing with the DRM is getting things tested
before submitting them to Linus as the last thing we want to happen is to
destabilise the DRM code in the kernel, the two testing paths are
a) DRM CVS, this gets picked up in DRI snapshots and tested quite heavily
- this is by far the most successful testing path for the DRM
b) the -mm tree is more useful for picking out non-x86 (sparc usually)
users,

At the moment I put patches into the BK CVS first, we stabilise them, I
take the CVS changes and patch them into bitkeeper, Andrew picks them up,
we find more bugs I fix em in bitkeeper and put em back in CVS, now
however the bk tree hasn't got a unique patch for a fix, it has a bunch of
changesets that are the initial patch plus the fixes for it,

Now if I submit to Linus via the -bk tree I'm screwed when he either a)
rejects an idea in the tree or b) doesn't respond at all, as I can't just
have him pull up the changesets that matter as a lot of them have been
crossed over by core kernel cleanup patches and bk is getting very shirty
with me about undo and excluding things...if I submit patches to Linus and
he puts them into his tree then I'll be continually dumping my bk trees
and starting again - it takes most of an evening to clone a tree to my
machine at home and I have time to work on this 2 or 3 evenings.. so
should I abandon bk and go it the old way, this means I submit every patch
to Linus and the DRM doesn't stay stable, (if we had 2.7 I would be happy
with this but we don't so .. :-(

So I'm asking is there a better way, considering at this stage I'm not
*trusted*, the DRM is an unholy mess and I'm the only one stupid enough to
step up and do anything about it ... (you should see the DRM in CVS at the
moment it is so much easier to work with without a lot of macros,
unfortunately it won't go into the kernel anytime soon....)

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

