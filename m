Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271141AbRHOLK6>; Wed, 15 Aug 2001 07:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271140AbRHOLKl>; Wed, 15 Aug 2001 07:10:41 -0400
Received: from rom.cscaper.com ([216.19.195.129]:65156 "HELO mail.cscaper.com")
	by vger.kernel.org with SMTP id <S271139AbRHOLK2>;
	Wed, 15 Aug 2001 07:10:28 -0400
Subject: 4.7GB DVD-RAM geometry wrong?
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
From: "Joseph N. Hall" <joseph@5sigma.com>
Ccc: 
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Wed, 15 Aug 2001 04:10 -0700
X-mailer: Mailer from Hell v1.0
Message-Id: <20010815111030Z271139-761+1405@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know if I'm doing this the right way or not.  I did spend an hour
or three googling for "linux dvd-ram" and the like, and all I came up with
was a bunch of 2.2-specific stuff, until I found a usenet posting that
said in effect "you can write to /dev/scd0".  So I gave that a try
and it worked.  Sort of.

I have a Panasonic DVD-RAM, LF-D201 (SCSI 4.7/9.4GB).  I put in a
4.7GB type II cartridge (that's a single-sided disk), did 'mkfs 
/dev/scd0' and then mounted it, and ... I have a 2.2GB disk!

It works fine but my ignorant assumption is that it is using the
geometry for the older 2.2gb media.  Firing up cfdisk -z:

                                  cfdisk 2.10f

                             Disk Drive: /dev/scd0
                             Size: 2290384896 bytes
              Heads: 255   Sectors per Track: 63   Cylinders: 278

I am new to the world of DVD-RAM so I don't know off the top of my head
what the correct geometry is.  But this ain't it!

So nevermind the problems of creating partitions on the device.  Why
isn't the raw device the right size?

I'm a non-subscriber so please cc: me.

[root@talker src]# uname -a
Linux talker 2.4.8 #2 SMP Tue Aug 14 02:37:03 MST 2001 i686 unknown

  -joseph

