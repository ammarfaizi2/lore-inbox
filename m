Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263399AbTKKHjd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 02:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264269AbTKKHjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 02:39:33 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:17540 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263399AbTKKHjb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 02:39:31 -0500
Message-ID: <3FB091C0.9050009@cyberone.com.au>
Date: Tue, 11 Nov 2003 18:37:36 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: walt <wa1ter@myrealbox.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
References: <Pine.LNX.4.44.0311102316330.980-100000@bigblue.dev.mdolabs.com>
In-Reply-To: <Pine.LNX.4.44.0311102316330.980-100000@bigblue.dev.mdolabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Davide Libenzi wrote:

>On Mon, 10 Nov 2003, walt wrote:
>
>
>>Andrea Arcangeli wrote:
>>
>>
>>>>On Mon, 10 Nov 2003, Andrea Arcangeli wrote:
>>>>
>>>The best way to fix this isn't to add locking to rsync, but to add two
>>>files inside or outside the tree, each one is a sequence number, so you
>>>fetch file1 first, then you rsync and you fetch file2, then you compare
>>>them. If they're the same, your rsync copy is coherent. It's the same
>>>locking we introduced with vgettimeofday...
>>>
>>How is this different from writing one file named LOCK while updating
>>the tree?
>>
>
>This is even simpler I believe. If you happen to fetch it, you restart the 
>rsync. Peter ?
>(maybe the name LOCK should be replaced by something more "uniq")
>
>

What happens if the the tree is updated while the client is fetching it?


