Return-Path: <linux-kernel-owner+w=401wt.eu-S1751561AbXAHOqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbXAHOqn (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 09:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbXAHOqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 09:46:43 -0500
Received: from relais.videotron.ca ([24.201.245.36]:58188 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbXAHOqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 09:46:42 -0500
Date: Mon, 08 Jan 2007 09:46:41 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: How git affects kernel.org performance
In-reply-to: <20070107203120.GA4970@spearce.org>
X-X-Sender: nico@xanadu.home
To: "Shawn O. Pearce" <spearce@spearce.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, "H. Peter Anvin" <hpa@zytor.com>,
       git@vger.kernel.org, nigel@nigel.suspend2.net,
       "J.H." <warthog9@kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>, webmaster@kernel.org
Message-id: <Pine.LNX.4.64.0701080943191.4964@xanadu.home>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20061216094421.416a271e.randy.dunlap@oracle.com>
 <20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com>
 <1166297434.26330.34.camel@localhost.localdomain>
 <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com>
 <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com>
 <45A083F2.5000000@zytor.com> <m3odpazxit.fsf@defiant.localdomain>
 <20070107203120.GA4970@spearce.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2007, Shawn O. Pearce wrote:

> Krzysztof Halasa <khc@pm.waw.pl> wrote:
> > Hmm... Perhaps it should be possible to push git updates as a pack
> > file only? I mean, the pack file would stay packed = never individual
> > files and never 256 directories?
> 
> Latest Git does this.  If the server is later than 1.4.3.3 then
> the receive-pack process can actually store the pack file rather
> than unpacking it into loose objects.  The downside is that it will
> copy any missing base objects onto the end of a thin pack to make
> it not-thin.

No.  There are no thin packs for pushes.  And IMHO it should stay that 
way exactly to avoid this little inconvenience on servers.

The fetch case is a different story of course.


Nicolas
