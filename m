Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbUL2My3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbUL2My3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 07:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbUL2My3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 07:54:29 -0500
Received: from [143.247.20.203] ([143.247.20.203]:10112 "EHLO
	cgx-mail.capitalgenomix.com") by vger.kernel.org with ESMTP
	id S261307AbUL2MyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 07:54:22 -0500
Message-ID: <41D2A8FC.7080604@capitalgenomix.com>
Date: Wed, 29 Dec 2004 07:54:20 -0500
From: "Fao, Sean" <sean.fao@capitalgenomix.com>
User-Agent: Mozilla Thunderbird 1.0RC1 (Windows/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vladimir Saveliev <vs@namesys.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Filesystem/kernel bug?
References: <41D02F54.8070107@capitalgenomix.com>	 <41D16500.9070903@capitalgenomix.com> <1104251242.3568.30.camel@tribesman.namesys.com>
In-Reply-To: <1104251242.3568.30.camel@tribesman.namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Saveliev wrote:

>Hello
>
>On Tue, 2004-12-28 at 16:52, Fao, Sean wrote:
>  
>
>>Update:
>>
>>I found these events --and many similar-- in my log file.
>>
>>Dec 26 17:55:43 cgx-mail ReiserFS: warning: is_tree_node: node level 0 
>>does not match to the expected one 1
>>Dec 26 17:55:43 cgx-mail ReiserFS: sda3: warning: vs-5150: 
>>search_by_key: invalid format found in block 13706028. Fsck?
>>Dec 26 17:55:43 cgx-mail ReiserFS: sda3: warning: vs-13070: 
>>reiserfs_read_locked_inode: i/o failure occurred trying to find stat 
>>data of [30749 74887 0x0 SD]
>>Dec 26 17:55:43 cgx-mail ReiserFS: warning: is_tree_node: node level 0 
>>does not match to the expected one 1
>>Dec 26 17:55:43 cgx-mail ReiserFS: sda3: warning: vs-5150: 
>>search_by_key: invalid format found in block 13706028. Fsck?
>>Dec 26 17:55:43 cgx-mail ReiserFS: sda3: warning: vs-13070: 
>>reiserfs_read_locked_inode: i/o failure occurred trying to find stat 
>>data of [30749 74888 0x0 SD]
>>Dec 26 17:55:43 cgx-mail ReiserFS: warning: is_tree_node: node level 0 
>>does not match to the expected one 1
>>Dec 26 17:55:43 cgx-mail ReiserFS: sda3: warning: vs-5150: 
>>search_by_key: invalid format found in block 13706028. Fsck?
>>Dec 26 17:55:43 cgx-mail ReiserFS: sda3: warning: vs-13070: 
>>reiserfs_read_locked_inode: i/o failure occurred trying to find stat 
>>data of [30749 74888 0x0 SD]
>>
>>Does this shed any new light?  Does it look like I might have a 
>>corrupted file system?
>>
>>    
>>
>
>Yes. Please try to reiserfsck your filesystem. Latest reiserfsck can be
>obtained from
>ftp://ftp.namesys.com/pub/reiserfsprogs/reiserfsprogs-3.6.19.tar.gz.
>  
>

Vladimir,

Thank you much for your response.  This is a production email server so 
I had to wait for an appropriate time to shut the system down.

Just a quick summary of what happened.  After rebooting the sever and 
booting from a CD, I ran reiserfsck, which found no corruption in the 
file system.  I then manually checked the directory structure and 
everything looked fine.  I'm not what was wrong, but a reboot apparently 
corrected whatever it was.

I've noticed a couple of patches for reiserfs in the past month or so on 
the LKML.  I'll check after I send this message to see if I can find the 
answer for myself, but, are there any major reiserfs bug fixes related 
to the Linux kernel, which have been corrected since 2.6.9 that I should 
know about?  Also, I'm using a 3ware 8000 series SATA controller, if 
that's at all relevant.

Thanks again for your help,

-- 
Sean
