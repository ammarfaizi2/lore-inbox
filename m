Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267582AbTBLPFQ>; Wed, 12 Feb 2003 10:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267581AbTBLPFQ>; Wed, 12 Feb 2003 10:05:16 -0500
Received: from compsciinn-gw.customer.ALTER.NET ([157.130.84.134]:19624 "EHLO
	picard.csi-inc.com") by vger.kernel.org with ESMTP
	id <S267259AbTBLPFN>; Wed, 12 Feb 2003 10:05:13 -0500
Message-ID: <044101c2d2a9$4fcdf980$f6de11cc@black>
From: "Mike Black" <mblack@csi-inc.com>
To: "Stephan van Hienen" <raid@a2000.nu>,
       "Peter Chubb" <peter@chubb.wattle.id.au>
Cc: <linux-kernel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
       <bernard@biesterbos.nl>, <ext2-devel@lists.sourceforge.net>
References: <Pine.LNX.4.53.0302060059210.6169@ddx.a2000.nu> <Pine.LNX.4.53.0302060123150.6169@ddx.a2000.nu> <Pine.LNX.4.53.0302060211030.6169@ddx.a2000.nu> <15937.50001.367258.485512@wombat.chubb.wattle.id.au> <Pine.LNX.4.53.0302061915390.17629@ddx.a2000.nu> <15945.31516.492846.870265@wombat.chubb.wattle.id.au> <Pine.LNX.4.53.0302121129480.13462@ddx.a2000.nu>
Subject: Re: raid5 2TB+ NO GO ?
Date: Wed, 12 Feb 2003 10:13:33 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did a 12x180G and as I recall was unable to do 13x180G as it overflowed during mke2fs.  This was a year ago though so I don't know
if that's been improved since then.

I've got 13 of these with one drive marked as a spare:
Disk /dev/sda: 255 heads, 63 sectors, 22072 cylinders
Units = cylinders of 16065 * 512 bytes

  Device Boot    Start       End    Blocks   Id  System
/dev/sda1             1     22072 177293308+  fd  Linux raid autodetect

   Number   Major   Minor   RaidDevice State
      0       8      177        0      active sync   /dev/sdl1
      1       8       17        1      active sync   /dev/sdb1
      2       8       33        2      active sync   /dev/sdc1
      3       8        1        3      active sync   /dev/sda1
      4       8       49        4      active sync   /dev/sdd1
      5       8       65        5      active sync   /dev/sde1
      6       8       81        6      active sync   /dev/sdf1
      7       8       97        7      active sync   /dev/sdg1
      8       8      113        8      active sync   /dev/sdh1
      9       8      129        9      active sync   /dev/sdi1
     10       8      145       10      active sync   /dev/sdj1
     11       8      161       11      active sync   /dev/sdk1
     12      65       49       12        /dev/sdt1

----- Original Message -----
From: "Stephan van Hienen" <raid@a2000.nu>
To: "Peter Chubb" <peter@chubb.wattle.id.au>
Cc: <linux-kernel@vger.kernel.org>; <linux-raid@vger.kernel.org>; <bernard@biesterbos.nl>; <ext2-devel@lists.sourceforge.net>
Sent: Wednesday, February 12, 2003 5:39 AM
Subject: Re: raid5 2TB+ NO GO ?


> On Wed, 12 Feb 2003, Peter Chubb wrote:
>
> > >>>>> "Stephan" == Stephan van Hienen <raid@a2000.nu> writes:
> >
> > Stephan,
> > Just noticed you're using raid5 --- I don't believe that level
> > 5 will work, as its data structures and  internal algorithms are
> > 32-bit only.  I've done no work on it to make it work (I've been
> > waiting for the rewrite in 2.5), and don't have time to do anything now.
> >
> > You could try making sector in the struct stripe_head a sector_t, but
> > I'm pretty sure you'll run into other problems.
> >
> > I only managed to get raid 0 and linear to work when I was testing.
>
> ok clear, so no raid5 for 2TB+ then :(
>
> looks like i have to remove some hd's then
>
> what will be the limit ?
>
> 13*180GB in raid5 ?
> or 12*180GB in raid5 ?
>
>     Device Size : 175823296 (167.68 GiB 180.09 GB)
>
> 13* will give me 1,97TiB but will there be an internal raid5 problem ?
> (since it will be 13*180GB to be adressed)
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-raid" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

