Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282120AbRKWLII>; Fri, 23 Nov 2001 06:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282121AbRKWLH6>; Fri, 23 Nov 2001 06:07:58 -0500
Received: from mail.terraempresas.com.br ([200.177.96.20]:47889 "EHLO
	mail.terraempresas.com.br") by vger.kernel.org with ESMTP
	id <S282120AbRKWLHu>; Fri, 23 Nov 2001 06:07:50 -0500
Message-ID: <002801c1740f$7372f650$1300a8c0@marcelo>
From: "Marcelo Borges Ribeiro" <marcelo@datacom-telematica.com.br>
To: "Jeff Chua" <jchua@fedex.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.42.0111231034330.15987-100000@boston.corp.fedex.com>
Subject: Re: Filesize limit on SMBFS
Date: Fri, 23 Nov 2001 09:10:24 -0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have fat32 partition, but the problem isn´t the size of partition it is
8GB. The problem is that if you want to
create a cpio backup of a linux system 3.5GB (I did that to reformat a ext2
to a reiserfs) to an available fat32 space, in my case the backup size is
allways 2GB and when I tried to extract back I saw "unexpected end of file".
So I thought it was that famous kernel limitation of 2GB under any kind of
partition, but i was informed that fat has this limitation too. So the
kernel may suport files bigger than 2GB (I really don´t know, I just know
that in my case with fat32 it did not and I saw this too with some oracle
databases that could not be used when they grow and reach 2GB, may be a
library problem too).

That´s all.
----- Original Message -----
From: "Jeff Chua" <jchua@fedex.com>
To: "Andreas Dilger" <adilger@turbolabs.com>
Cc: "Marcelo Borges Ribeiro" <marcelo@datacom-telematica.com.br>; "Tyler
BIRD" <birdty@uvsc.edu>; <linux-kernel@vger.kernel.org>
Sent: Friday, November 23, 2001 12:35 AM
Subject: Re: Filesize limit on SMBFS


> On Thu, 22 Nov 2001, Andreas Dilger wrote:
>
> > VFAT does have a 2GB limit, AFAIK, but I could be wrong.
>
> Use "mkdosfs -F32" or use msdos fdisk,format to get >2GB.
>
> I'm using 3GB for VFAT partition.
>
> Jeff.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

