Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbVKEVsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbVKEVsr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 16:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbVKEVsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 16:48:47 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:51422 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932209AbVKEVsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 16:48:46 -0500
Date: Sat, 5 Nov 2005 22:48:40 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hfsplus: don't modify journaled volume
In-Reply-To: <Pine.LNX.4.64.0511051333550.13104@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.61.0511052246480.12843@scrub.home>
References: <Pine.LNX.4.61.0511031617090.12843@scrub.home>
 <20051104210213.1232a007.akpm@osdl.org> <Pine.LNX.4.64.0511051009090.13104@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.64.0511051333550.13104@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 5 Nov 2005, Anton Altaparmakov wrote:

> > I would agree with that and further, is that not a bit draconian?  
> > HFSPlus is designed to work without the journal.  Just change the last 
> > mounted version to FSK! (0x46534b21) and everything will work as expected, 
> > i.e. fsck will run a check instead of ignoring the volume and osx will 
> > mount the volume and reinitialize the journal.  Remember older OSX 
> > versions did not support journalling so if you attached your external 
> > drive to one of those older osx boxes, you would also get non-journalled 
> > writes to a journalled volume.  It's all designed for it...
> 
> And you do not need to be worried about journal reply because you 
> already do not allow read/write mounts when the volume has not been 
> unmounted cleanly, so there really is no reason not to allow mounting 
> a volume with a journal...

Sorry, but I had too many reports about problems with journaled volumes, 
so I prefer the safe solution, until we can at least replay the journal.

bye, Roman
