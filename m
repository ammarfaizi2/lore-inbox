Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbVJIXkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbVJIXkw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 19:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbVJIXkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 19:40:52 -0400
Received: from [67.137.28.189] ([67.137.28.189]:28544 "EHLO vger.utah-nac.org")
	by vger.kernel.org with ESMTP id S932298AbVJIXkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 19:40:51 -0400
Message-ID: <4349961F.7060109@utah-nac.org>
Date: Sun, 09 Oct 2005 16:13:51 -0600
From: jmerkey <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix ext3 warning for unused var
References: <20051009195850.27237.90873.stgit@zion.home.lan> <Pine.LNX.4.64.0510091314200.31407@g5.osdl.org> <43497533.6090106@utah-nac.org> <20051009212916.GM7992@ftp.linux.org.uk> <43497B09.3020102@utah-nac.org> <20051009220838.GN7992@ftp.linux.org.uk>
In-Reply-To: <20051009220838.GN7992@ftp.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:

>On Sun, Oct 09, 2005 at 02:18:17PM -0600, jmerkey wrote:
>  
>
>>If they all use the same on disk formats as their basic structure,
>>    
>>
>
>ext3 and reiserfs?  No, they do not.
>
>  
>
>>fsck 
>>should not return gt > 1 due to misinterpreting reiser on-disk 
>>structures. It should say "oh not one of mine, skipping". Instead it 
>>returns an error claiming massive corruption, and halts the system. I 
>>just upgraded my wifes computer from Suse to RedHat FC4 and when it hits 
>>the reiser partitions, the whole system explodes due to fsck.ext3 
>>misrecognizing reiser partitions.
>>    
>>
>
>Since when does fsck run fsck.ext3 on filesystems that are not marked
>as ext3 in /etc/fstab?
>
>  
>
>>I had to modify rc.sysinit and blank 
>>the partitions with fdisk to get it to install. After it installed, I 
>>recreated the partitions (after writing down what they were in the first 
>>place for block #'s etc.) and disabled rc.sysinit checks. This is 
>>busted. Hans needs to fix fsck.ext3 and submit a patch or redhat does.
>>    
>>
>
>Sorry, but I doubt that Hans or anybody in RH knows how to patch 
>

---> wetware, <----

Is this the new "official" non-official slang word for Suse Linux?

Jeff


>let alone one as messed up as yours.
>-
>  
>

