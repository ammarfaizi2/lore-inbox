Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283288AbRLMENn>; Wed, 12 Dec 2001 23:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283287AbRLMENd>; Wed, 12 Dec 2001 23:13:33 -0500
Received: from web14914.mail.yahoo.com ([216.136.225.241]:12556 "HELO
	web14914.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S283268AbRLMENZ>; Wed, 12 Dec 2001 23:13:25 -0500
Message-ID: <20011213041323.96594.qmail@web14914.mail.yahoo.com>
Date: Wed, 12 Dec 2001 23:13:23 -0500 (EST)
From: Michael Zhu <mylinuxk@yahoo.ca>
Subject: Communication between two modules
To: linux-kernel@vger.kernel.org
Cc: nmundi@karthika.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,everyone, I have some questions about Linux file
system and block device.
 
First, you know for the block device there is a
blk_dev table which is indexed by the major number of
the block device. The register_blkdev() function is
used to insert a new entry into this blk_dev table.
How can I access to this table in my kernel module?
The reason why I want to access to this table is I
want to access some specific Block Device Driver
Descriptor so that I can access to the request queue
of that block device, such as floppy disk device. This
table is a global variable?
 
Second, whether two kernel modules can communicate
with each other or not? For example, can my own kernel
module communicate with the floppy block device? And
how? I want to intercept the read/write operations to
the floppy block device. I mean I want to hook all the
read/write operations to the floppy block device in my
kernel module.
 
Third, I know that the kernel statically allocates a
fixed number of request descriptors to handle all the
requests for block devices. There are NR_REQUEST
descriptors (usually 128) stored in the all_requests
array (This is from the book "Understanding the Linux
Kernel" by Daniel P. Bovet&Marco Cesati. P403). How
can I access this all_requests array? I need to access
the request descriptor of the floppy disk device.
 
Last one, about the ll_rw_block() function.  How can I
intercept this function in my kernel module? Can I get
the function pointer of this function in my module?
 
Any idea will be appreciated.
 
Michael

______________________________________________________ 
Send your holiday cheer with http://greetings.yahoo.ca
