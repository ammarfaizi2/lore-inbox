Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268592AbUIXI2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268592AbUIXI2r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 04:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268593AbUIXI2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 04:28:47 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:5753 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268592AbUIXI2V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 04:28:21 -0400
From: tabris <tabris@tabris.net>
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: undecoded slave?
Date: Fri, 24 Sep 2004 04:24:44 -0400
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org
References: <200409222357.39492.tabris@tabris.net> <200409231630.49153.tabris@tabris.net> <200409240209.13884.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200409240209.13884.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200409240424.46754.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 23 September 2004 8:09 pm, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 23 September 2004 22:30, tabris wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > On Thursday 23 September 2004 7:14 am, Bartlomiej Zolnierkiewicz 
wrote:
> > > [ use linux-ide@vger.kernel.org for ATA stuff ]
> > >
> > > On Thursday 23 September 2004 05:57, tabris wrote:
> > > > Probing IDE interface ide3...
> > > > hdg: Maxtor 4D060H3, ATA DISK drive
> > > > hdh: Maxtor 4D060H3, ATA DISK drive
> > > > ide-probe: ignoring undecoded slave
> > > >
> > > > Booted 2.6.9-rc2-mm2, and I no longer have an hdh. the error
> > > > above seems to be the only [stated] reason why.
> > >
> > > Please send hdparm -I output for both drives.
> >
> > As you can see, both drives are the same brand/size/model.
> > Both are connected to the PDC20265 on my ASUS A7V266-E motherboard.
> >
> > /dev/hdg:
> >
> > ATA device, with non-removable media
> >         Model Number:       Maxtor 4D060H3
> >         Serial Number:      D3000000
> >         Firmware Revision:  DAK019K0
>
> Thanks.
> It seems we will need to add this Serial Number to "undecoded slave"
> fixup.
>
> Please also send /proc/ide/hd?/identify to exclude kernel/hdparm
> parsing bug.

	Just so this is clear, these results are from running 
2.6.8-rc1-mm1+idefix2, as it is what I am using (and that the other 
version doesn't let me use hdh)


[root@tabriel root]# cat /proc/ide/hdg/identify
0040 3fff c837 0010 0000 0000 003f 0000
0000 0000 4433 3030 3030 3030 2020 2020
2020 2020 2020 2020 0003 1000 0039 4441
4b30 3139 4b30 4d61 7874 6f72 2034 4430
3630 4833 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8010
0000 2f00 4000 0200 0000 0007 ffff 0001
003f ffc1 003e 0110 1f30 0728 0000 0007
0003 0078 0078 0078 0078 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
007e 0018 7c69 4f09 4003 7c69 0c01 4003
207f 0000 0000 0000 0000 603b c000 0000
0000 0000 0000 0000 1f30 0728 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 63a5
[root@tabriel root]# cat /proc/ide/hdh/identify
0040 3fff c837 0010 0000 0000 003f 0000
0000 0000 4433 3030 3030 3030 2020 2020
2020 2020 2020 2020 0003 1000 0039 4441
4830 3137 4b30 4d61 7874 6f72 2034 4430
3630 4833 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8010
0000 2f00 4000 0200 0000 0007 3fff 0010
003f fc10 00fb 0110 1f30 0728 0000 0007
0003 0078 0078 0078 0078 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
007e 0018 7c69 4b09 4003 7c69 0801 4003
203f 0000 0000 0000 0000 6b00 c000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 06a5
[root@tabriel root]#


- -- 
Even if you're on the right track, you'll get run over if you just sit 
there.
		-- Will Rogers
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBU9nN1U5ZaPMbKQcRAr8VAKCkyQMrWbHG2PzEkuhl+yCtgn/UlACeKbj4
anRB/dhqaAfkqNSt7UwzdSk=
=fstO
-----END PGP SIGNATURE-----
