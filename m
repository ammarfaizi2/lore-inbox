Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129854AbRBBU4U>; Fri, 2 Feb 2001 15:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129876AbRBBU4K>; Fri, 2 Feb 2001 15:56:10 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:22024 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129854AbRBBUzx>; Fri, 2 Feb 2001 15:55:53 -0500
Date: Fri, 02 Feb 2001 15:55:43 -0500
From: Chris Mason <mason@suse.com>
To: newsreader@mediaone.net, linux-kernel@vger.kernel.org
Subject: Re: did 2.4 messed up lilo?
Message-ID: <786060000.981147343@tiny>
In-Reply-To: <20010202153618.A653@dragon.universe>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, February 02, 2001 03:36:18 PM -0500 newsreader@mediaone.net
wrote:

> I'm not sure whether this problem is related
> to 2.4 kernel.
> 

I suspect it is a reiserfs problem, and that you are using lilo older than
21.6.  Are you mounting /boot with -o notail?

Regardless, I'm willing to bet upgrading to lilo 21.6 will solve this.  It
calls an ioctl reiserfs provides to unpack small files, and I've seen it
fix this exact problem on one of my devel boxes (no lilo prompt, append
lines in lilo.conf ignored).

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
