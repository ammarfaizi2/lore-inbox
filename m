Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132704AbRDQPVJ>; Tue, 17 Apr 2001 11:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132710AbRDQPUx>; Tue, 17 Apr 2001 11:20:53 -0400
Received: from f99.law14.hotmail.com ([64.4.21.99]:36100 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S132704AbRDQPUh>;
	Tue, 17 Apr 2001 11:20:37 -0400
X-Originating-IP: [213.64.0.142]
From: "John Nilsson" <pzycrow@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Could hd-drivers and buffer algorithm be hardware?
Date: Tue, 17 Apr 2001 17:20:31 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F99asSmz6UuEhjJ8uT600008978@hotmail.com>
X-OriginalArrivalTime: 17 Apr 2001 15:20:31.0769 (UTC) FILETIME=[F11A6090:01C0C751]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The idea is as follows.

Design a hardisk controller that would take care of all harddrive and block 
device managment and provide a virtual storage area to the OS. This way all 
the kernel would have to worry about is a virtual harddrive and how to fech 
and write data from and to it. Buffering, and read/write optimization would 
be taken care of by the controller.

The controller would have a proccessing unit, its own memory, and a chip to 
compress/decompress data.
The compression chip would filer all read and written data so that the 
actual amount of data that is read and written to disk is compressed, this 
way increasing disk space, and speed up disk read/writes.
The memory is a SDRAM DIMM that could be upgraded for more memmory, needed 
if you would want to add more physical disks or just make room for mor disk 
cache/ buffers.
The chip would take care of diskdriver issues, raid, buffering, and 
diskplacement optimization. For instance it could make a note of what files 
is usually read together and frequently, placing them close to eachother and 
on the outer tracks of the hardrives if they are big, or more generally in 
the middle of the used drivespace to optimize head movements...

>From the kernel side you would have a singel gigantic ultra fast hardrive, 
and the disk drivers would be loaded inte the chip bios on installation 
time. Further the buffering algorithms would also be loade inito the chip 
bios on installation time to decrease the mainCPU time of kernel code.


I'm just a curious computer nerd, but tell me is it a good idéa?

/John Nilsson
_________________________________________________________________________
Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com.

