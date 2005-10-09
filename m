Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbVJJAOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbVJJAOt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 20:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbVJJAOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 20:14:49 -0400
Received: from [67.137.28.189] ([67.137.28.189]:30592 "EHLO vger.utah-nac.org")
	by vger.kernel.org with ESMTP id S932308AbVJJAOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 20:14:49 -0400
Message-ID: <43499E10.8060502@utah-nac.org>
Date: Sun, 09 Oct 2005 16:47:44 -0600
From: jmerkey <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
Cc: Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix ext3 warning for unused var
References: <20051009195850.27237.90873.stgit@zion.home.lan> <Pine.LNX.4.64.0510091314200.31407@g5.osdl.org> <43497533.6090106@utah-nac.org> <20051009212916.GM7992@ftp.linux.org.uk> <43497B09.3020102@utah-nac.org>            <20051009220838.GN7992@ftp.linux.org.uk> <200510092358.j99NwlQj021703@turing-police.cc.vt.edu>
In-Reply-To: <200510092358.j99NwlQj021703@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

>On Sun, 09 Oct 2005 23:08:38 BST, Al Viro said:
>
>  
>
>>Since when does fsck run fsck.ext3 on filesystems that are not marked
>>as ext3 in /etc/fstab?
>>    
>>
>
>Part of the problem is that if a partition is formatted with mkfs.ext3,
>it gets an ext3 magic number scribbled at a known offset into the partition.
>If you then reformat it with mkfs.reiserfs, that scribbles a different
>magic number elsewhere on the partition, but leaves the ext3 magic number
>intact.  As a result, if you forget to update /etc/fstab, fsck.ext3 checks
>for its magic number, finds it, concludes it's probably an ext3, and then
>discovers that everything is totally scrogged.....
>
>Yes, it's pilot error, but it's definitely hitting your feet with much larger
>caliber rounds than you would have expected... :)
>  
>

Yep.   Needs to get fixed because when you upgrade from a reiserfs 
system and try to keep the reiserfs partitions and add a new hard drive 
(+1) to
an existing system, you run the risk of corrupting resiferfs partitions. 

Jeff


