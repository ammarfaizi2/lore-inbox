Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287418AbSACQkT>; Thu, 3 Jan 2002 11:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287414AbSACQkA>; Thu, 3 Jan 2002 11:40:00 -0500
Received: from [195.63.194.11] ([195.63.194.11]:45327 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S287409AbSACQj4>; Thu, 3 Jan 2002 11:39:56 -0500
Message-ID: <3C3486C9.8080007@evision-ventures.com>
Date: Thu, 03 Jan 2002 17:28:57 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Ion Badulescu <ion@cs.columbia.edu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [CFT] [JANITORIAL] Unbork fs.h
In-Reply-To: <200201031605.g03G57e22947@guppy.limebrokerage.com> <E16MAp4-00018b-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

>On January 3, 2002 05:05 pm, Ion Badulescu wrote:
>
>>Daniel Phillips wrote:
>>
>>>+static struct file_system_type ext2_fs = {
>>>+       owner:          THIS_MODULE,
>>>+       fs_flags:       FS_REQUIRES_DEV,
>>>+       name:           "ext2",
>>>+       read_super:     ext2_read_super,
>>>+       super_size:     sizeof(struct ext2_sb_info),
>>>+       inode_size:     sizeof(struct ext2_inode_info)
>>>+};
>>>
>>While we're at it, can we extend this model to also include details about 
>>the other filesystem data structures with (potential) private info, i.e.
>>struct dentry and struct file? ext2 might not use them, but other 
>>filesystems certainly do.
>>
>
>Hi,
>
>Could you be more specific about what you mean, please?
>
>>>-static inline struct inode * new_inode(struct super_block *sb)
>>>+static inline struct inode *new_inode (struct super_block *sb)
>>>
>>Minor issue of coding style. I'd steer away from such gratuitious changes, 
>>especially since they divert from the commonly accepted practice of having 
>>no spaces between the name of the function and its arguments.
>>
>
>That's good advice and I'm likely to adhere to it - if you can show that 
>having no spaces between the name of the function and its arguments really is 
>the accepted practice. 
>
It is trust on that. Only the silly GNU indentation style introduced 
something else. Look at the "core kernel" and
not the ugly drivers around it.


