Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262497AbULOVM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbULOVM5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 16:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbULOVM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 16:12:57 -0500
Received: from bay14-f13.bay14.hotmail.com ([64.4.49.13]:30274 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262497AbULOVMy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 16:12:54 -0500
Message-ID: <BAY14-F1340F1BEA5470EBDE3DD2095AD0@phx.gbl>
X-Originating-IP: [80.15.132.11]
X-Originating-Email: [tonyosborne_a@hotmail.com]
From: "tony osborne" <tonyosborne_a@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: tonyosborne_a@hotmail.com
Subject: OS I/O operations concepts
Date: Wed, 15 Dec 2004 21:10:03 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 15 Dec 2004 21:11:01.0474 (UTC) FILETIME=[947E3420:01C4E2EA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I wish to be personally CC'ed the answers/comments posted to the list in 
response to this post

I have some questions regarding the I/O file operations efficiency.

1-)
Consider I/O operations involving the disk. Assume that I write periodically 
one Byte in the file after executing one processing block of code. Does this 
mean that at each of these periods, that only Byte will be stored in the 
disk despite its slow access time, or instead it will be stored in the 
memory buffer (of what size?) first then moved into the disk once the buffer 
is full?

What about the disk bitmap and the one loaded into the memory. Will this be 
updated at each Byte write operation? This will slow down extremely the 
system speed.

Should the programmer force the second option (by using BufferOutputStream 
as in java) or is it done automatically by the JVM or OS?

(I am taking Java only as an example, same hold for C++ and othe r 
languages)


I have read also that writing and reading should be done on chunks of 256 
(512,1024) bytes since the disk sector is of this size. Should I specify 
explicitly the buffer size or will it be handled automatically by the JVM or 
OS?

Say I have a stream of X bytes, should write it into the disk per once, or 
instead repetitively on X/256 bytes size ?


2-)
I/O controller privileges

Does the I/O controller (once the device driver installed) full privileges 
as the main CPU when on kernel mode?

will the driver code be loaded at the top of the kernel code adress space on 
the memory?


3-)   asyncronous I/O operations

i am looking for good tutorial on how asynchrnous I/O operations is 
implemented by OS?
will there be re-ordering of the code sequence execution


is Java system.in.read (system.out.println) synchronous or asynchronous I/O 
Op


thanks for your assistance

_________________________________________________________________
Express yourself with cool new emoticons http://www.msn.co.uk/specials/myemo

