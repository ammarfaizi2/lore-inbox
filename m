Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272155AbRHVWiB>; Wed, 22 Aug 2001 18:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272153AbRHVWhv>; Wed, 22 Aug 2001 18:37:51 -0400
Received: from mail.myrio.com ([63.109.146.2]:6909 "HELO smtp1.myrio.com")
	by vger.kernel.org with SMTP id <S272121AbRHVWhj>;
	Wed, 22 Aug 2001 18:37:39 -0400
Message-ID: <D52B19A7284D32459CF20D579C4B0C0211C9DB@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'tegeran@home.com'" <tegeran@home.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, mikpe@csd.uu.se
Cc: linux-kernel@vger.kernel.org, ionut@cs.columbia.edu
Subject: RE: [PATCH,RFC] make ide-scsi more selective
Date: Wed, 22 Aug 2001 15:37:23 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Here's an end-user perspective for you... I just spent 2 days 
> trying to 
> figure out how to use my CD-RW drive to read when using 
> ide-scsi, before 
> I finnaly realized that I had to do it by disabling ATAPI CD 
> support and 
> enabling SCSI CD support..

Also note:

The SCSI-CD driver is also required if you want any kind of
reasonable performance for cdparanoia (the music CD ripper),
even for perfectly ordinary CD or DVD drives.  This took me
a couple tries last weekend, and I even knew what the problem
was.

Is there _any_ hardware where the ide-cd driver works better
than ide-scsi emulation?

If not, I suppose the only reason to keep it around is so 
people don't need to compile all the SCSI support just for 
ordinary access to ISO-9660 cds with an IDE CDROM.

In the meantime, perhaps the kernel configuration help could 
mention this little gotcha?  And maybe distributions should 
make ide-scsi the default?  At least CD ripping would work 
"out of the box" like that.

Torrey Hoffman
torrey.hoffman@myrio.com
