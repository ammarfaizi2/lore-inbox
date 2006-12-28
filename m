Return-Path: <linux-kernel-owner+w=401wt.eu-S1754992AbWL1VKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754992AbWL1VKX (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 16:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWL1VKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 16:10:23 -0500
Received: from [139.30.44.16] ([139.30.44.16]:5115 "EHLO
	gockel.physik3.uni-rostock.de" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754993AbWL1VKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 16:10:22 -0500
Date: Thu, 28 Dec 2006 22:10:20 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Randy Dunlap <randy.dunlap@oracle.com>
cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] remove 556 unneeded #includes of sched.h
In-Reply-To: <20061228125805.2edc0a2b.randy.dunlap@oracle.com>
Message-ID: <Pine.LNX.4.63.0612282203580.20531@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.63.0612282059160.8356@gockel.physik3.uni-rostock.de>
 <20061228124644.4e1ed32b.akpm@osdl.org> <20061228125805.2edc0a2b.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2006, Randy Dunlap wrote:

> I'm half done with a patch to remove includes of smp_lock.h.
> For the files that I have patched, I checked each source file
> for all interfaces in smp_lock.h to verify that none of them
> are used, so the #include is just waste.

Yes, that's what I also did. And then I checked for all interfaces in all 
headers included indirectly through sched.h and not already included in 
the respective source file to see whether any of these includes are needed 
to keep the file compilable (although this time, amazingly few includes 
had to be added back - only 5 for all 556)

Maybe I should have taken a look at my original patch descripions from 
last year, I admit the current one isn't very illuminating.

Tim
