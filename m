Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263378AbTDGLNH (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 07:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263379AbTDGLNH (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 07:13:07 -0400
Received: from elixir.e.kth.se ([130.237.48.5]:34824 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id S263378AbTDGLNH (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 07:13:07 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: An idea for prefetching swapped memory...
References: <200304071026.47557.schlicht@uni-mannheim.de>
	<200304072021.17080.kernel@kolivas.org>
	<1049712476.3e91575c2e6ae@rumms.uni-mannheim.de>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 07 Apr 2003 13:24:41 +0200
In-Reply-To: Thomas Schlichter's message of "Mon,  7 Apr 2003 12:47:56 +0200"
Message-ID: <yw1xsmsuk0sm.fsf@nogger.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Schlichter <schlicht@rumms.uni-mannheim.de> writes:

> > This has been argued before. Why would the last swapped out pages
> > be the best to swap in? The vm subsystem has (somehow) decided
> > they're the least likely to be used again so why swap them in?
> > Alternatively how would it know which to swap in instead?  Con
> 
> What I wanted to say is that if there is free memory it should be
> filled with the pages that were in use before the memory got
> rare. And these are the pages swapped out last. The other swapped
> out pages are swapped out even longer and so will likely not be used
> in the near future... (That's what the LRU algorithm says...)

Would it be possible to track the most recently used swapped out page?
This would possibly be a good candidate for speculative loading.

-- 
Måns Rullgård
mru@users.sf.net
