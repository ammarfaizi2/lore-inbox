Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265006AbUGBWeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265006AbUGBWeP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 18:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265007AbUGBWeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 18:34:15 -0400
Received: from mlf.linux.rulez.org ([192.188.244.13]:45583 "EHLO
	mlf.linux.rulez.org") by vger.kernel.org with ESMTP id S265006AbUGBWeO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 18:34:14 -0400
Date: Sat, 3 Jul 2004 00:34:12 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [Linux-NTFS-Dev] [2.6.7 BK URL] NTFS 2.1.15 - Invaliade quotas
 when (re)mounting read-write.
In-Reply-To: <Pine.LNX.4.60.0407022242380.8959@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.21.0407022357260.30622-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Jul 2004, Anton Altaparmakov wrote:
> > Hello, what happens if the occupied space would exceed the quota during
> > sync? Is the behavior consistent for all OS?
>
> Hi, I haven't got the faintest idea.  Considering we don't have any code 
> in the ntfsdriver that will change the size of a file yet...  

Shouldn't ntfstruncate do the job? Ntfsresize could be also easily
modified to break the quotas. 

> Whatever it does it certainly will be better than windows thinking the
> quotas are uptodate but that not being so.

Quotas aren't often used so read-write mount could have been just refused
until the more general things get implemented. No untested scenarios.

	Szaka

