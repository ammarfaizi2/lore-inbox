Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266033AbUALDZW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 22:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266037AbUALDZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 22:25:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:38124 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266033AbUALDZU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 22:25:20 -0500
Date: Sun, 11 Jan 2004 18:58:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Thomas Winischhofer <thomas@winischhofer.net>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jsimmons@infradead.org
Subject: Re: 2.6.1-mm1: drivers/video/sis/sis_main.c link error
In-Reply-To: <3FFF79E5.5010401@winischhofer.net>
Message-ID: <Pine.LNX.4.58.0401111502380.1825@evo.osdl.org>
References: <20040109014003.3d925e54.akpm@osdl.org> <20040109233714.GL1440@fs.tum.de>
 <3FFF79E5.5010401@winischhofer.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 10 Jan 2004, Thomas Winischhofer wrote:
> 
> The whole framebuffer stuff in 2.6 is ancient. (Look at the file dates.)

Note that the fb stuff is ancient because it's basically not maintained as 
far as I'm concerned.

I occasionally get huge drops from James, and they invariably break stuff. 
Which means that I often decide (espcially when trying to stabilize 
things) that I just can't _afford_ to apply the fr*gging patches. Because 
by past experience applying one of the big "everything changes" patches 
tends to break more things that it fixes.

I'm sorry, but this i show it is.  The fbcon people have been changing 
interfaces faster than they have been fixing bugs in the code. Together 
with the fact that most of the development seems to happen in outside 
trees, and nobody ever sends me fixes relative to the released tree, this 
makes for a pretty bad situation.

I really think that development should happen in the regular tree, or at 
least be synched up in reasonable chunks THAT DO NOT BREAK everything.

I realize that some fb developers seem to disagree with me, but the fact 
is, the way things are done now, fb will _always_ be broken. Most people 
for whom the standard kernel works will never test the fb development 
trees, so those trees will never get any amount of reasonable testing. As 
a result, they WILL be buggy, and synching with them WILL be painful as 
hell.

There is a d*mn good reason for why development should happen
incrementally, and in the standard trees, and not in some outside tree. 
For one: testing. For another: figuring out when things break in a timely 
manner.

		Linus
