Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290063AbSAKSoS>; Fri, 11 Jan 2002 13:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290064AbSAKSoJ>; Fri, 11 Jan 2002 13:44:09 -0500
Received: from host25.actarg.com ([209.180.91.25]:52405 "EHLO tao.actarg.com")
	by vger.kernel.org with ESMTP id <S290063AbSAKSn6>;
	Fri, 11 Jan 2002 13:43:58 -0500
Message-ID: <3C3F3267.7050103@actarg.com>
Date: Fri, 11 Jan 2002 11:43:51 -0700
From: Kyle <kyle@actarg.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: chaffee@cs.berkeley.edu
Subject: Hard lock when mounting loopback file
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a digital camera flash card that is locking up my machine (stock 
redhat 7.2 w/2.4.9-13 kernel).

I can mount the card, but as soon as I browse the filesystem, the 
machine locks hard.  I successfully copied the file system from the raw 
device to a file and tried mounting it as:

mount -o loop flash.img /mnt/flash

and it still locks up the machine just as before.  This makes me think 
it has nothing to do with the USB reader or the SCSI emulation, etc.

My guess is I have a corrupt filesystem on the flash that the filesystem 
handler (vfat) is intolerant of (all my other flash cards work fine).  

This seems like a possible kernel bug to me.  I'm not much of a kernel 
expert but I have a copy of the offending image if anyone wants to or 
can look at it.  (ftp://actarg.com/pub/misc/flash.img)  Is there someone 
that knows how to figure out if the driver can spit out a harmless 
message about filesystem corruption rather than taking the whole kernel 
down?

Kyle Bateman


