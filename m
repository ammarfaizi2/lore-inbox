Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbVJIVUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbVJIVUj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 17:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbVJIVUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 17:20:39 -0400
Received: from [67.137.28.189] ([67.137.28.189]:25984 "EHLO vger.utah-nac.org")
	by vger.kernel.org with ESMTP id S932290AbVJIVUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 17:20:39 -0400
Message-ID: <43497533.6090106@utah-nac.org>
Date: Sun, 09 Oct 2005 13:53:23 -0600
From: jmerkey <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix ext3 warning for unused var
References: <20051009195850.27237.90873.stgit@zion.home.lan> <Pine.LNX.4.64.0510091314200.31407@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510091314200.31407@g5.osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Sun, 9 Oct 2005, Paolo 'Blaisorblade' Giarrusso wrote:
>  
>
>>Can please someone merge this? It's the 3rd time I send it.
>>    
>>
>
>I don't like #ifdef's in code. 
>
>You could just have split up the quota-specific stuff into a function of 
>their own: "ext3_show_quota_options()". The patch might have been larger, 
>but it would actually clean up the code rather than make it uglier.
>
>Warnings are not a reason for ugly code.
>
>		Linus
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Someone needs to fix fsck.ext3 while they are at it so it doesn't barf 
when reading from reisferfs filesystems and return a command return of > 
2 during scanning of parttions during bootup. This looks like some sort 
of anti-competitive crap and it doesn't belong in fsck.ext3 since 
reiserfs is in the kernel.

J
