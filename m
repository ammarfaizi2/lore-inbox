Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266663AbUIOBrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266663AbUIOBrk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 21:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266627AbUIOBrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 21:47:40 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:46041 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S266749AbUIOBrV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 21:47:21 -0400
Date: Tue, 14 Sep 2004 19:47:11 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Anton Blanchard <anton@samba.org>,
       Linux kernel <linux-kernel@vger.kernel.org>, paulus@samba.org
Subject: Re: offtopic: how to break huge patch into smaller independent patches?
Message-ID: <20040915014711.GA30607@schnapps.adilger.int>
Mail-Followup-To: Chris Friesen <cfriesen@nortelnetworks.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Anton Blanchard <anton@samba.org>,
	Linux kernel <linux-kernel@vger.kernel.org>, paulus@samba.org
References: <41474B15.8040302@nortelnetworks.com> <20040915002023.GD5615@krispykreme> <119340000.1095209242@flay> <414799D1.7050609@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <414799D1.7050609@nortelnetworks.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 14, 2004  19:24 -0600, Chris Friesen wrote:
> >If the changes are in fairly independant files, just vi'ing the diff is
> >normally very effective. If they're all intertangled, then starting again
> >from scratch is prob easier ;-)
> 
> Unfortunately I've got over 550 files being changed, in probably about 50 
> conceptual areas.

Start with the smallest logical change(s), possibly just extracting them
from the big diff with vi.  Assuming you have a decent diff format (-up
is what I find the most useful) you should just be able to copy the
original patch, delete all the hunks that are unrelated, and you are left
with logical change.

Now that you have it as a separate patch, apply it to the reference tree
and rediff to get a reduced-size combined patch.  For some changes that
stomp on overlapping lines of code you don't have much hope but to recreate
them by hand, but hopefully those are in relatively few areas.

Consider using a source-control tool next time ;-/.  

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/

