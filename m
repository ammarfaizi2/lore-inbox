Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263400AbTDGMbt (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 08:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263403AbTDGMbs (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 08:31:48 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:30645 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263400AbTDGMbr (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 08:31:47 -0400
Date: Mon, 7 Apr 2003 14:43:12 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Zaffiro <davzaffiro@netscape.net>
Cc: Thomas Schlichter <schlicht@uni-mannheim.de>, linux-kernel@vger.kernel.org
Subject: Re: An idea for prefetching swapped memory...
Message-ID: <20030407124311.GD22630@wohnheim.fh-wedel.de>
References: <200304071026.47557.schlicht@uni-mannheim.de> <3E916FDA.8070809@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E916FDA.8070809@netscape.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 April 2003 14:32:26 +0200, David Zaffiro wrote:
> 
> >The idea was about prefetching swapped out pages when some memory is free, 
> >the CPU is idle and the I/O load is low.
> >
> >So this should not 'cost' much but behave better on following situation:
> >(I think there are even more such situations, this one should just be an 
> >example)
> 
> Wouldn't it cost almost twice as much when the user requests a different 
> task, instead of the just swaped-in "last swaped-out task(s)"?!
> 
> Instead of loading this directly into a free portion of phys. memory, the 
> just-swapped-in-ex-swapped-out task(s) would need to be swapped-out *again* 
> in favour of the to-be-swaped-in task...
> 
> Or am I wrong here?

Partially. If done right, the swapout would simply free those pages.
The information is already on the disk and unchanged, after all.

Jörn

-- 
If you're willing to restrict the flexibility of your approach,
you can almost always do something better.
-- John Carmack
