Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbTDHMsE (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 08:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbTDHMsE (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 08:48:04 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:65176
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261349AbTDHMsC (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 08:48:02 -0400
Subject: Re: PATCH: jiffies is UL
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20030407174027.6f2c7b2d.akpm@digeo.com>
References: <200304080036.h380aBFH009252@hraefn.swansea.linux.org.uk>
	 <20030407174027.6f2c7b2d.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049803271.8113.20.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Apr 2003 13:01:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-04-08 at 01:40, Andrew Morton wrote:
> > -#define INITIAL_JIFFIES ((unsigned int) (-300*HZ))
> > +#define INITIAL_JIFFIES ((unsigned long) (-300*HZ))
> >  
> 
> No, this is deliberate.  It triggers a wrap from 0x00000000ffffffff to
> 0x0000000100000000 after 5 minutes uptime on 64-bit machines, which has found
> bugs.
> 
> The fix is to add a comment, so this patch stops coming out ;)

I which case it should be ((unsigned long)((unsigned int ....))

so the assignment type is right

