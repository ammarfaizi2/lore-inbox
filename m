Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263410AbTDGMVV (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 08:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263411AbTDGMVU (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 08:21:20 -0400
Received: from ns.tasking.nl ([195.193.207.2]:60681 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S263410AbTDGMVT (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 08:21:19 -0400
Message-ID: <3E916FDA.8070809@netscape.net>
Date: Mon, 07 Apr 2003 14:32:26 +0200
From: David Zaffiro <davzaffiro@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021220 Debian/1.2.1-3
X-Accept-Language: nl, en-us
MIME-Version: 1.0
To: Thomas Schlichter <schlicht@uni-mannheim.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: An idea for prefetching swapped memory...
References: <200304071026.47557.schlicht@uni-mannheim.de>
In-Reply-To: <200304071026.47557.schlicht@uni-mannheim.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The idea was about prefetching swapped out pages when some memory is free, the 
> CPU is idle and the I/O load is low.
> 
> So this should not 'cost' much but behave better on following situation:
> (I think there are even more such situations, this one should just be an 
> example)

Wouldn't it cost almost twice as much when the user requests a different task, instead of the just 
swaped-in "last swaped-out task(s)"?!

Instead of loading this directly into a free portion of phys. memory, the 
just-swapped-in-ex-swapped-out task(s) would need to be swapped-out *again* in favour of the 
to-be-swaped-in task...

Or am I wrong here?

