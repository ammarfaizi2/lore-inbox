Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282125AbRKWMBe>; Fri, 23 Nov 2001 07:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282127AbRKWMBZ>; Fri, 23 Nov 2001 07:01:25 -0500
Received: from mx5.sac.fedex.com ([199.81.194.37]:14084 "EHLO
	mx5.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S282125AbRKWMBK> convert rfc822-to-8bit; Fri, 23 Nov 2001 07:01:10 -0500
Date: Fri, 23 Nov 2001 20:00:53 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Marcelo Borges Ribeiro <marcelo@datacom-telematica.com.br>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Filesize limit on SMBFS
In-Reply-To: <002801c1740f$7372f650$1300a8c0@marcelo>
Message-ID: <Pine.LNX.4.42.0111231956350.1162-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 11/23/2001
 08:01:05 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 11/23/2001
 08:01:08 PM,
	Serialize complete at 11/23/2001 08:01:08 PM
Content-Transfer-Encoding: 8BIT
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You may want to try using glibc 2.2.x, but then you may fail to compile
many other codes. I tried it once, and managed to get >2GB file, but had
to revert back to 2.1.3 because 2.2.x broke compiling other codes.
That was a few months back.


Thanks,
Jeff
[ jchua@fedex.com ]

On Fri, 23 Nov 2001, Marcelo Borges Ribeiro wrote:

> I have fat32 partition, but the problem isn´t the size of partition it is
> 8GB. The problem is that if you want to
> create a cpio backup of a linux system 3.5GB (I did that to reformat a ext2
> to a reiserfs) to an available fat32 space, in my case the backup size is
> allways 2GB and when I tried to extract back I saw "unexpected end of file".
> So I thought it was that famous kernel limitation of 2GB under any kind of
> partition, but i was informed that fat has this limitation too. So the
> kernel may suport files bigger than 2GB (I really don´t know, I just know
> that in my case with fat32 it did not and I saw this too with some oracle
> databases that could not be used when they grow and reach 2GB, may be a
> library problem too).
>
> That´s all.
> ----- Original Message -----
> From: "Jeff Chua" <jchua@fedex.com>
> To: "Andreas Dilger" <adilger@turbolabs.com>
> Cc: "Marcelo Borges Ribeiro" <marcelo@datacom-telematica.com.br>; "Tyler
> BIRD" <birdty@uvsc.edu>; <linux-kernel@vger.kernel.org>
> Sent: Friday, November 23, 2001 12:35 AM
> Subject: Re: Filesize limit on SMBFS
>
>
> > On Thu, 22 Nov 2001, Andreas Dilger wrote:
> >
> > > VFAT does have a 2GB limit, AFAIK, but I could be wrong.
> >
> > Use "mkdosfs -F32" or use msdos fdisk,format to get >2GB.
> >
> > I'm using 3GB for VFAT partition.
> >
> > Jeff.
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>

