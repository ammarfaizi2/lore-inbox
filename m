Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262734AbTDGO2C (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 10:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbTDGO2C (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 10:28:02 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:5586 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262734AbTDGO2B (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 10:28:01 -0400
Date: Mon, 7 Apr 2003 16:39:11 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Thomas Schlichter <schlicht@rumms.uni-mannheim.de>,
       linux-kernel@vger.kernel.org
Subject: Re: An idea for prefetching swapped memory...
Message-ID: <20030407143911.GI22630@wohnheim.fh-wedel.de>
References: <200304071026.47557.schlicht@uni-mannheim.de> <200304072021.17080.kernel@kolivas.org> <1049712476.3e91575c2e6ae@rumms.uni-mannheim.de> <3E917BFA.4020303@aitel.hist.no> <3E9188ED.1090109@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E9188ED.1090109@nortelnetworks.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 April 2003 10:19:25 -0400, Chris Friesen wrote:
> 
> With the current setup though, the memory is wasted.  It makes sense that 
> we should fill the memory up with *something* that is likely to be useful.
> 
> If I have mozilla open, start a kernel compile, and then come back half an 
> hour later, I would like to see the mozilla pages speculatively loaded back 
> into memory.
> 
> Since the system is otherwise idle, it doesn't cost anything to do this.

In the scenario above, it costs you a lot. The memory is completely
used, else mozilla wouldn't get swapped out. If you swap it back in
and get rid of fs cache, the next kernel (compile|grep|whatever) will
be slower.

And even in the original scenario, it will be expensive, depending on
your machine. On a notebook, it costs you battery power, which is a
limited resource, *for sure*. You *may* save user time, which *may* be
a limited resource, but not always.

But sure, it is a fun project to hack on, just go ahead and show the
numbers. :)

> I think its obvious that it is beneficial to swap in something, the only 
> trick is getting a decent heuristic as to what it should be.

And when it should be done. ;)

Jörn

-- 
There's nothing better for promoting creativity in a medium than
making an audience feel "Hmm ­ I could do better than that!"
-- Douglas Adams in a slashdot interview
