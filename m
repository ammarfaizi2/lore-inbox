Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbVKGL44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbVKGL44 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 06:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbVKGL44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 06:56:56 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:64748 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751343AbVKGL4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 06:56:55 -0500
Date: Mon, 7 Nov 2005 12:56:50 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hfsplus: don't modify journaled volume
In-Reply-To: <Pine.LNX.4.64.0511052155270.5813@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.61.0511071253510.12843@scrub.home>
References: <Pine.LNX.4.61.0511031617090.12843@scrub.home>
 <20051104210213.1232a007.akpm@osdl.org> <Pine.LNX.4.64.0511051009090.13104@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.64.0511051333550.13104@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.61.0511052246480.12843@scrub.home>
 <Pine.LNX.4.64.0511052155270.5813@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 5 Nov 2005, Anton Altaparmakov wrote:

> > Sorry, but I had too many reports about problems with journaled volumes, 
> > so I prefer the safe solution, until we can at least replay the journal.
> 
> Yes but that would be because you leave an active journal and do changes 
> behind its back without telling the OSX HFSPlus driver that you have done 
> changes behind its back...  My suggestion was to tell the driver that you 
> have done changes behind its back so it will be happy.

This may work, but I can't find this officially documented anywhere, this 
is what the spec says: "Implementations accessing a journaled volume with 
transactions must either refuse to access the volume, or replay the 
journal to be sure the volume is consistent."
So from my side this check stays, until we can at least replay the 
journal.

bye, Roman
