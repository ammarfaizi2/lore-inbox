Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267189AbRGPFRD>; Mon, 16 Jul 2001 01:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267194AbRGPFQw>; Mon, 16 Jul 2001 01:16:52 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:55050 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S267189AbRGPFQj>;
	Mon, 16 Jul 2001 01:16:39 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200107160516.f6G5Gew324783@saturn.cs.uml.edu>
Subject: Re: Duplicate '..' in /lib
To: adam@eax.com (Adam)
Date: Mon, 16 Jul 2001 01:16:40 -0400 (EDT)
Cc: alex.buell@tahallah.demon.co.uk (Alex Buell),
        linux-kernel@vger.kernel.org (Mailing List - Linux Kernel)
In-Reply-To: <Pine.LNX.4.33.0107160009260.25850-100000@eax.student.umd.edu> from "Adam" at Jul 16, 2001 12:11:39 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam writes:

>> /lib
>>    4 drwxr-xr-x   19 root     root         4096 Jun  9 16:06 ..
>>    4 -rw-rw-r--    1 root     root           27 Jun  9 15:55 ..
>>
>> How can I get rid of this? I'm on kernel 2.2.19, running on sparc-linux.
>
> first it is not a pair directories, but a directory and a file.
> 
> second, are you sure both of the mare just ".." for example

I don't think so! Look at the "4" on the left. If that is the
inode number from "ls -lia /lib", his disk is seriously messed up.
The inode number for "/lib/.." should be 2, and an inode may not
be shared between a file and a directory.

