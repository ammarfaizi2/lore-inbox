Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264915AbTAWT2X>; Thu, 23 Jan 2003 14:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265243AbTAWT2X>; Thu, 23 Jan 2003 14:28:23 -0500
Received: from beta.bandnet.com.br ([200.195.133.131]:62480 "EHLO
	beta.bandnet.com.br") by vger.kernel.org with ESMTP
	id <S264915AbTAWT2V>; Thu, 23 Jan 2003 14:28:21 -0500
From: "User &" <breno_silva@beta.bandnet.com.br>
To: Valdis.Kletnieks@vt.edu, User & <breno_silva@beta.bandnet.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: Expand VM 
Date: Thu, 23 Jan 2003 16:40:14 -0300
Message-Id: <20030123194014.M374@beta.bandnet.com.br>
In-Reply-To: <200301231655.h0NGtc75010414@turing-police.cc.vt.edu>
References: <20030123155627.M95099@beta.bandnet.com.br> <200301231655.h0NGtc75010414@turing-police.cc.vt.edu>
X-Mailer: Open WebMail 1.81 20021127
X-OriginatingIP: 200.215.42.52 (breno_silva)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valdis

Create a new VMA on Linux B for Linux A is easy , but i have a problem , the 
address of VMA is returned on Linux B , so the VMA created on Linux B can not 
be used for process of linux A.
The problem is "how can i return address of VMA created on LINUX B to Linux 
A , and use this space ?".

Thanks
Breno

On Thu, 23 Jan 2003 11:55:38 -0500, Valdis.Kletnieks wrote
> On Thu, 23 Jan 2003 12:56:27 -0300, User & 
> <breno_silva@beta.bandnet.com.br>  said:
> 
> > I have one idea , and this is about expand virtual memory on linux boxes 
> > connected in LAN.
> > Example: Linux A is processing come information , and need more memory , 
so 
> > with this source , Linux A could access virtual memory on Linux B in LAN.
> 
> We've seen *this* done before (remember diskless Sun3-50's?) - the /dev/swap
> file would be a large file on an NFS mount from a server.  At the 
> time, this actually made performance sense, because the old 
> 'Shoebox' drives the -50 came with were incredibly slow, and you 
> could actually do an NFS operation to a larger server (a -280 with 
> Fujitsu SuperEagle disks, for instance) faster than talking to the 
> local disk.
> 
> These days, it's probably easier and cheaper to just buy more RAM 
> and/or disk for Linux A.
> 
> > But i don´t know how translate the virtual address between Linux A and 
B , to 
> > have success in acess VM, or how to send all the process for Linux B to 
be 
> > processed.
> 
> Sending the whole process to Linux B to be processed is called "process
> migration", and is a difficult problem.  Moving the memory image of the
> process is usually pretty easy.  What is difficult is moving things like
> references to open files, file locks, and so on (what if the process 
> is actively writing to block 739 of /usr/foo/some.file, and the 
> LinuxB machine doesn't have a /usr/foo, or the permissions on 
> some.file don't match, or another process has it locked, or... ) 
> There be nasty dragons in this.
> 
> You're probably better off buying more RAM and disk for your A machine.
> -- 
> 				Valdis Kletnieks
> 				Computer Systems Senior Engineer
> 				Virginia Tech



----------------------
WebMail Bandnet.com.br

