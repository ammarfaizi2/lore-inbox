Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287863AbSATV3B>; Sun, 20 Jan 2002 16:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287833AbSATV2x>; Sun, 20 Jan 2002 16:28:53 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:37130 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S287279AbSATV2s>; Sun, 20 Jan 2002 16:28:48 -0500
Message-ID: <3C4B35AB.4040801@namesys.com>
Date: Mon, 21 Jan 2002 00:24:59 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>
CC: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <Pine.LNX.4.33.0201201247270.6499-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:

>On Sun, 20 Jan 2002, Hans Reiser wrote:
>
>>Write clustering is one thing it achieves.   When we flush a slum, the 
>>
>
>sure, that's fine.  when the VM tells you to write a page,
>you're free to write *more*, but you certainly must give back
>that particular page.  afaicr, this was the conclusion 
>of the long-ago thread that you're referring to.
>
>regards, mark hahn.
>
>
>
This is bad for use with internal nodes.  It simplifies version 4 a 
bunch to assume that if a node is in cache, its parent is also.  Not 
sure what to do about it, maybe we need to copy the node.  Surely we 
don't want to copy it unless it is a DMA related page cleaning.

Hans


