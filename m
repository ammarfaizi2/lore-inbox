Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263398AbTDGMfR (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 08:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263401AbTDGMfR (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 08:35:17 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:40911 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S263398AbTDGMep (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 08:34:45 -0400
From: Thomas Schlichter <schlicht@rumms.uni-mannheim.de>
Message-ID: <1049719564.3e91730c5097c@rumms.uni-mannheim.de>
Date: Mon,  7 Apr 2003 14:46:04 +0200
To: =?iso-8859-1?B?TeVucyBSdWxsZ+VyZA==?= <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: An idea for prefetching swapped memory...
References: <200304071026.47557.schlicht@uni-mannheim.de> <200304072021.17080.kernel@kolivas.org> <1049712476.3e91575c2e6ae@rumms.uni-mannheim.de> <yw1xsmsuk0sm.fsf@nogger.e.kth.se>
In-Reply-To: <yw1xsmsuk0sm.fsf@nogger.e.kth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Måns Rullgård <mru@users.sourceforge.net>:

> Thomas Schlichter <schlicht@rumms.uni-mannheim.de> writes:
> > What I wanted to say is that if there is free memory it should be
> > filled with the pages that were in use before the memory got
> > rare. And these are the pages swapped out last. The other swapped
> > out pages are swapped out even longer and so will likely not be used
> > in the near future... (That's what the LRU algorithm says...)
> 
> Would it be possible to track the most recently used swapped out page?
> This would possibly be a good candidate for speculative loading.

Well, I think the 'more recently used swapped out' order relation is equivalent
to the 'later swapped out' order relation if the kswapd uses the LRU algorithm.
(if it does not, it has its reasons and we should respect them by simply using
the 'later swapped out' order...)

But I am not familiar with the linux swapping management so I don't know if it
tracks this order in any structure. Perhaps there is a kind of 'last used
timestamp' for each page and so for the swapped pages, too, wich could be used
for my purpose. But as I sayed, I don't know...

I hope there is anybody out there who can help me with this question...

Thanks 
   Thomas
