Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263594AbTDGSSF (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 14:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbTDGSSF (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 14:18:05 -0400
Received: from findaloan-online.cc ([216.209.85.42]:21262 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S263594AbTDGSSD (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 14:18:03 -0400
Date: Mon, 7 Apr 2003 14:37:00 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Thomas Schlichter <schlicht@rumms.uni-mannheim.de>,
       linux-kernel@vger.kernel.org
Subject: Re: An idea for prefetching swapped memory...
Message-ID: <20030407183700.GB7311@mark.mielke.cc>
References: <200304071026.47557.schlicht@uni-mannheim.de> <200304072021.17080.kernel@kolivas.org> <1049712476.3e91575c2e6ae@rumms.uni-mannheim.de> <3E917BFA.4020303@aitel.hist.no> <3E9188ED.1090109@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E9188ED.1090109@nortelnetworks.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 07, 2003 at 10:19:25AM -0400, Chris Friesen wrote:
> Helge Hafting wrote:
> >"What we're going to need soon" is the best.  It isn't always predictable,
> >but sometimes.  "The block following the last we read from some 
> >file/fs-structure"
> >is often a good one though.

> With the current setup though, the memory is wasted.  It makes sense that 
> we should fill the memory up with *something* that is likely to be useful.
> 
> If I have mozilla open, start a kernel compile, and then come back half an 
> hour later, I would like to see the mozilla pages speculatively loaded back 
> into memory.
> 
> Since the system is otherwise idle, it doesn't cost anything to do this.  I 
> think its obvious that it is beneficial to swap in something, the only 
> trick is getting a decent heuristic as to what it should be.

Chris: Based on your usage patterns, how would Linux know that you were
going to be opening up Mozilla, and not that you were going to tweak the
kernel source and compile it again?

The only time memory is wasted is when you don't have enough of it, and it
gets trampled for common operations that you perform. All other times, the
memory is loaded, because it was used, which means it might be used again.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

