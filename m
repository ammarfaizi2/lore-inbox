Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131886AbRCXXhv>; Sat, 24 Mar 2001 18:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131887AbRCXXhn>; Sat, 24 Mar 2001 18:37:43 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:13814 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S131886AbRCXXhc>; Sat, 24 Mar 2001 18:37:32 -0500
Message-Id: <l0313031db6e2def84b96@[192.168.239.101]>
In-Reply-To: <Pine.LNX.4.33.0103242307520.570-100000@mikeg.weiden.de>
In-Reply-To: <3ABCE547.DD5E78B9@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 24 Mar 2001 23:35:07 +0000
To: Mike Galbraith <mikeg@wen-online.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: [PATCH] Prevent OOM from killing init
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> While my post didn't give an exact formula, I was quite clear on the
>>fact that
>> the system is allowing the caches to overrun memory and cause oom problems.
>
>Yes.  A testcase would be good.  It's not happening to everybody nor is
>it happening under all loads.  (if it were, it'd be long dead)
>
>> I'm more than happy to test patches, and I would even be willing to suggest
>> some algorithms that might help, but I don't know where to stick them in the
>> code.  Most of the people who have been griping are in a similar position.
>
>First step toward killing the critter is to lure him onto open ground.
>Once there.. well, I've seen some pretty fancy shooting on this list.

My patch already fixes OOM problems caused by overgrown caches/buffers, by
making sure OOM is not triggered until these buffers have been cannibalised
down to freepages.high.  If balancing problems still exist, then they
should be retuned with my patch (or something very like it) in hand, to
separate one problem from the other.  AFAIK, balancing should now be a
performance issue rather than a stability issue.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----


