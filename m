Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132763AbRDQQ44>; Tue, 17 Apr 2001 12:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132762AbRDQQ4i>; Tue, 17 Apr 2001 12:56:38 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:13318 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S132760AbRDQQ4c> convert rfc822-to-8bit; Tue, 17 Apr 2001 12:56:32 -0400
Date: Tue, 17 Apr 2001 18:56:24 +0200 (CEST)
From: Tomas Telensky <ttel5535@ss1000.ms.mff.cuni.cz>
Reply-To: ttel5535@artax.karlin.mff.cuni.cz
To: John Nilsson <pzycrow@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Could hd-drivers and buffer algorithm be hardware?
In-Reply-To: <F99asSmz6UuEhjJ8uT600008978@hotmail.com>
Message-ID: <Pine.LNX.4.21.0104171847340.15511-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Apr 2001, John Nilsson wrote:

> The idea is as follows.
> 
> Design a hardisk controller that would take care of all harddrive and block 
> device managment and provide a virtual storage area to the OS. This way all 
> the kernel would have to worry about is a virtual harddrive and how to fech 
> and write data from and to it. Buffering, and read/write optimization would 
> be taken care of by the controller.
> 
> The controller would have a proccessing unit, its own memory, and a chip to 
> compress/decompress data.
> The compression chip would filer all read and written data so that the 
> actual amount of data that is read and written to disk is compressed, this 
> way increasing disk space, and speed up disk read/writes.
> The memory is a SDRAM DIMM that could be upgraded for more memmory, needed 
> if you would want to add more physical disks or just make room for mor disk 
> cache/ buffers.
> The chip would take care of diskdriver issues, raid, buffering, and 
> diskplacement optimization. For instance it could make a note of what files 
> is usually read together and frequently, placing them close to eachother and 
> on the outer tracks of the hardrives if they are big, or more generally in 
> the middle of the used drivespace to optimize head movements...
> 
> >From the kernel side you would have a singel gigantic ultra fast hardrive, 
> and the disk drivers would be loaded inte the chip bios on installation 
> time. Further the buffering algorithms would also be loade inito the chip 
> bios on installation time to decrease the mainCPU time of kernel code.
> 
> 
> I'm just a curious computer nerd, but tell me is it a good idéa?

I don't think. The expensive RAM would not be efficiently used. OTOH, the
cheap HDD need not to be compressed, how would you recover the data? You
also mix in the filesystem layer (relocating files), it would be hardly
possible.

  Tomas Telensky

> 
> /John Nilsson
> _________________________________________________________________________
> Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

