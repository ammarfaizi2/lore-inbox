Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269237AbUHZR75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269237AbUHZR75 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 13:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269233AbUHZR7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 13:59:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:11495 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269312AbUHZRnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 13:43:32 -0400
Date: Thu, 26 Aug 2004 10:32:46 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Rik van Riel <riel@redhat.com>, Diego Calleja <diegocg@teleline.es>,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, spam@tnonline.net, akpm@osdl.org,
       wichert@wiggy.net, jra@samba.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040826172703.GR5733@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0408261030350.2304@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408261315240.27909-100000@chimarrao.boston.redhat.com>
 <Pine.LNX.4.58.0408261019580.2304@ppc970.osdl.org> <20040826172703.GR5733@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Aug 2004, Jamie Lokier wrote:
> Linus Torvalds wrote:
> > 
> > No no. The stream you get from a directory is totally _independent_ of the 
> > contents of the directory. Anything else would be pointless.
> 
> Surely it depends on the directory?

Well, you _could_ make it do a "tar", but what's the point? That really 
doesn't add any value as far as user space is concerned.

Think of it this way: if the directory and the "default stream" associated 
with it aren't independent, then user space already has the information, 
and the stream is pointless. In fact, the stream is _worse_ than 
pointless, because it hides the fact that there is no independent 
information.

See my point? 

		Linus
