Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261336AbRE2RCw>; Tue, 29 May 2001 13:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261547AbRE2RBg>; Tue, 29 May 2001 13:01:36 -0400
Received: from zeus.kernel.org ([209.10.41.242]:47020 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261509AbRE2Q7S>;
	Tue, 29 May 2001 12:59:18 -0400
From: mdaljeet@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org
cc: kraxel@bytesex.org
Message-ID: <CA256A5B.00548719.00@d73mta01.au.ibm.com>
Date: Tue, 29 May 2001 19:34:18 +0530
Subject: query regarding 'map_user_kiobuf'
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using linux kernel version 2.4.2 on Intel PC.

I have been trying my luck for over a week regarding usage of
'map_user_kiobuf' for doing a DMA into a memory area that belongs to user
space.

Actually my requirement is that I want to do DMA into a user space memory
area. What I have done through suggestions is that allocate memory in user
space. I pass user space buffer address to a kernel module.
Inside the kernel module, I use 'map_user_kiobuf' passing user space buffer
address to it.

After using the 'map_user_kiobuf', I observed the followiing:

1. 'kiobuf->maplist[0]->virtual' contains a different virtual address than
the user space buffer address
2. But these two addresses are mapped as when i write something using the
address 'kiobuf->maplist[0]->virtual' inside the kernel, I see the same
data in the user space buffer in my application.
3. I use the 'virt_to_phys' operation to the virtual address
'kiobuf->maplist[0]->virtual' to get the physical address.
4. I use this physical address for DMA operations.

Now, using this information I do a DMA from card to system memory. What I
have noticed is that DMA happens somewhere else in the system memory. I am
not able to execute most of the commands (ls, chmod, cat, clear etc) after
my user program exits.

Am I doing the steps 3 and 4 above right?

Regards,
Daljeet.


