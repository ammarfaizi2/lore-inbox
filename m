Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265335AbSKAIvJ>; Fri, 1 Nov 2002 03:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265369AbSKAIvJ>; Fri, 1 Nov 2002 03:51:09 -0500
Received: from c-66-176-164-150.se.client2.attbi.com ([66.176.164.150]:19636
	"EHLO schizo.psychosis.com") by vger.kernel.org with ESMTP
	id <S265335AbSKAIvI>; Fri, 1 Nov 2002 03:51:08 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: 2.5.45: initrd broken?
Date: Fri, 1 Nov 2002 03:57:28 -0500
User-Agent: KMail/1.4.2
Cc: Kernel List <linux-kernel@vger.kernel.org>
References: <20021031170340.GA18058@bytesex.org> <Pine.GSO.4.21.0210311148190.16688-100000@weyl.math.psu.edu> <20021031192155.GA19825@bytesex.org>
In-Reply-To: <20021031192155.GA19825@bytesex.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211010357.28964.dcinege@psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 October 2002 14:21, Gerd Knorr wrote:
> > > 2.5.45 doesn't boot for me.  I'm using a initrd to load some modules.

Yep broken here too...it's one/some of the changes in rd.c

It's dying in my code with 
	close(in_fd); 
in_fd of course being the /dev/initrd area.

> f7dcd820 Call Trace:
>  [<c0144583>] sync_blockdev+0x33/0x50

I start out with 
	initrd_release+0x79/0x80

But initrd_release() in rd.c hasen't changed since 2.5.44?
(Should it have??)




-- 
The time is now 22:48 (Totalitarian)  -  http://www.ccops.org/

