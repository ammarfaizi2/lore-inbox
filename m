Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283771AbRL1W0D>; Fri, 28 Dec 2001 17:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283724AbRL1WZn>; Fri, 28 Dec 2001 17:25:43 -0500
Received: from [195.63.194.11] ([195.63.194.11]:37899 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S282805AbRL1WZb>; Fri, 28 Dec 2001 17:25:31 -0500
Message-ID: <3C2CEEB5.1080801@evision-ventures.com>
Date: Fri, 28 Dec 2001 23:14:13 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andre Hedrick <andre@linux-ide.org>, Keith Owens <kaos@ocs.com.au>,
        kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: your mail
In-Reply-To: <Pine.LNX.4.33.0112271025590.1052-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>(Right now you can see this in block_ioctl.c - while only a few of the
>ioctl's have been converted, you get the idea. I'm actually surprised that
>nobody seems to have commented on that part).
>

That was just too obvious, at least for me... However I don't see why 
you just don't start killing of constructs like:

swtch  (ioctrl)

    BLASH:
BLAHHH:
 BLASHH:
 BLAASS:
     BLAH:
    default:
            return -ENOVAL;
}

There are ton' s of them out there in the block drivers..

