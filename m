Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262396AbVGFUxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbVGFUxK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 16:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbVGFUtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:49:10 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:34309 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S262535AbVGFUrZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 16:47:25 -0400
Message-ID: <42CC4369.3070005@slaphack.com>
Date: Wed, 06 Jul 2005 15:47:37 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
Cc: Hubert Chan <hubert@uhoreg.ca>,
       "Alexander G. M. Smith" <agmsmith@rogers.com>, ross.biro@gmail.com,
       vonbrand@inf.utfsm.cl, mrmacman_g4@mac.com, Valdis.Kletnieks@vt.edu,
       ltd@cisco.com, gmaxwell@gmail.com, jgarzik@pobox.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       zam@namesys.com, vs@thebsh.namesys.com, ndiller@namesys.com,
       vitaly@thebsh.namesys.com
Subject: Re: reiser4 plugins
References: <42CB1E12.2090005@namesys.com> <1740726161-BeMail@cr593174-a> <87hdf8zqca.fsf@evinrude.uhoreg.ca> <42CB7DE0.4050200@namesys.com> <42CBD7F6.2050203@slaphack.com> <42CC1DEE.7030502@namesys.com>
In-Reply-To: <42CC1DEE.7030502@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> David Masover wrote:
> 
> 
>>And, once we start talking about applications, /meta will be more
>>readily supported (as in, some apps will go through a pathname and
>>stop when they get to a file, and then there's tar).  On apps which
>>don't have direct support for /meta, you'd be navigating to the file
>>in question and then manually typing '...' into the dialog, so I don't
>>see why typing '...' at the end is better than typing '/meta' or
>>'/meta/vfs' at the beginning.
> 
> 
> Performance.  If you type it at the end, and you already have done the
> lookup of the filename, then you can go from the file to one of its
> methods, instead of a complete new traversal of another tree under /meta

Only, it's a different view of the same tree.  That may not matter 
performance-wise, though.

Also, for performance-critical applications, the /meta tree is pretty 
easy -- it becomes more like /meta/inode/some_inode_number/.

There's also the chroot issue, though.

>>That said, I'm still not entirely sure how we get /meta/vfs to work
>>other than adding a '...' sort of delimiter anyway.
>>
>>
>>>>And a question: is it feasible to store, for each inode, its parent(s),
>>>>instead of just the hard link count?
>>>>
>>>>
>>>
>>>Ooh, now that is an interesting old idea I haven't considered in 20
>>>years.... makes fsck more robust too....
>>
>>
>>Doesn't it make directory operations slower, too?
> 
> 
> Not sure.  It consumes space though.
> 
> 
>>And, will it require a format change?
>>
> 
> Yes, but we have plugins now, so.....

So, will the format change happen at mount time?  Will it need a special 
mount flag?  Will I need to use debugfs or some other offline tool?


