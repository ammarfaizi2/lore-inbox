Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315432AbSELVsc>; Sun, 12 May 2002 17:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315437AbSELVsb>; Sun, 12 May 2002 17:48:31 -0400
Received: from mailhost2.teleline.es ([195.235.113.141]:33072 "EHLO
	tsmtp10.mail.isp") by vger.kernel.org with ESMTP id <S315432AbSELVs3>;
	Sun, 12 May 2002 17:48:29 -0400
Date: Sun, 12 May 2002 23:41:53 +0200
From: Diego Calleja <DiegoCG@teleline.es>
To: Becki Minich <bminich@earthlink.net>
Cc: linux-kernel@vger.kernel.org, johnnyo@mindspring.com
Subject: Re: Reiserfs has killed my root FS!?!
Message-Id: <20020512234153.55d655d6.DiegoCG@teleline.es>
In-Reply-To: <3CDEDEA5.2020002@earthlink.net>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 May 2002 17:29:09 -0400
Becki Minich <bminich@earthlink.net> escribió:

> reiserfs: checking transaction log (device 08:12)
> attempt to access beyond end of device
> 08:12: rw=0 want=268574776 limit=8747392

I'm not an expert, but this perhaps isn't a reiserfs problem.
I'm using reiserfs and i've never had a problem. The only corruption i've seen is 
while compiling kernel. The .o file was being created, and if i shut down the computer,
at restart, when i try to compile the kernel again, gcc  says that doesn't understands the .o file
This was because when replaying the journal the file was created, but it has random data. This is normal,
because reiserfs only assures the metadata integrity, not the data.

> vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat 
> data of [1 2 0x0 SD]
> Using r5 hash to sort names
> Reiserfs version 3.6.25
> VFS: Mounted root (reiserfs filesystem) readonly.
> Warning: unable to mount devfs, err: -5
> Freeing unused kernel memory: 224k freed
> Warning: unable to open an initial console.
> Kernel panic: No init found.
> 
> If someone can get me to the point where I can just get to read my 
> filesystem read-only, so I get get all my data off of it, I would be 
> EXTREMELY GRATEFUL!  I have some very important data on that FS.  I went 
> to the reiserfs web site to discover I'd get charged $25 for asking for 
> help, so unless someone convinces me otherwise, I will be converting to 
> EXT3 when this disaster is over...
> 
> Slackware Linux 8.1b2
> Linux 2.4.18
> ReiserFS 3.6.25
> GLIBC 2.2.5
> GCC 2.95.3
> 
> Any help please?!?
> John O'Donnell
> johnnyo@mindspring.com
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
