Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265768AbUH0Oq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265768AbUH0Oq6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 10:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbUH0Oq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 10:46:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24040 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265691AbUH0Oq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 10:46:28 -0400
Date: Fri, 27 Aug 2004 10:45:13 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Hans Reiser <reiser@namesys.com>
cc: David Masover <ninja@slaphack.com>, Linus Torvalds <torvalds@osdl.org>,
       Diego Calleja <diegocg@teleline.es>, <jamie@shareable.org>,
       <christophe@saout.de>, <vda@port.imtp.ilyichevsk.odessa.ua>,
       <christer@weinigel.se>, <spam@tnonline.net>, <akpm@osdl.org>,
       <wichert@wiggy.net>, <jra@samba.org>, <hch@lst.de>,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <flx@namesys.com>, <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <412EEB75.1030401@namesys.com>
Message-ID: <Pine.LNX.4.44.0408271043090.10272-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2004, Hans Reiser wrote:

> Why are you guys even considering going to any pain at all to distort 
> semantics for the sake of backup?  tar is easy, we'll fix it and send in 
> a patch. 

It's not as easy as you make it out, and not just because
there are a few dozen backup programs that need fixing.

The problem is more fundamental than that.  Some of the
file streams proposed need to be backed up, while others
are alternative presentations of the file, which should
not be backed up.

Currently I see no way to distinguish between the stuff
that should be backed up and the stuff that shouldn't.

That problem needs to be resolved before we can even start
thinking about fixing archivers...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

