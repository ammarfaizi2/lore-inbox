Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312511AbSDARdE>; Mon, 1 Apr 2002 12:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312524AbSDARcz>; Mon, 1 Apr 2002 12:32:55 -0500
Received: from mailer3.bham.ac.uk ([147.188.128.54]:53898 "EHLO
	mailer3.bham.ac.uk") by vger.kernel.org with ESMTP
	id <S312511AbSDARco>; Mon, 1 Apr 2002 12:32:44 -0500
Date: Mon, 1 Apr 2002 18:32:29 +0100 (BST)
From: Mark Cooke <mpc@star.sr.bham.ac.uk>
X-X-Sender: mpc@pc24.sr.bham.ac.uk
To: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>
cc: LinuxKernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.17 with VT8367 [KT266] crashes on heavy ide load
 togeter
In-Reply-To: <3CA88BC0.2000603@2gen.com>
Message-ID: <Pine.LNX.4.44.0204011810380.16203-300000@pc24.sr.bham.ac.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-581273324-1017682349=:16203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-581273324-1017682349=:16203
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Mon, 1 Apr 2002, David Härdeman wrote:

> Date: Mon, 01 Apr 2002 18:33:04 +0200
> From: David Härdeman <david@2gen.com>
> To: Mark Cooke <mpc@star.sr.bham.ac.uk>
> Cc: LinuxKernel <linux-kernel@vger.kernel.org>
> Subject: Re: Kernel 2.4.17 with VT8367 [KT266] crashes on heavy ide load
>     togeter
> 
> Mark Cooke wrote:
> 
> > If I run a simultaneous one on hdc and hde, the combined rate tops 
> > out at 50MB again.  Hence, the limitation isn't the raid card.  Or at 
> > least I'd be exceedingly surprised.
> 
> The bugs that exist in VIA chipsets and Barracuda drives have already 
> exceedingly surprised me many, many times :-)

Agreed.

> I have done some dumping on the via chipset and this what I've come up 
> with is available (in a cooked format) at:
> http://www.student.nada.kth.se/~i99_hnd/via/
> 
> I hope that this is useful in some way for you?.

Yes.  It's interesting that comparing the differences in north bridge
registers between windows unpatched, and the latest 1.05 raid patch is
just register 0xb7 changing.  Perhaps I'll be 'brave/foolish' and just
twiddle it with setpci after backing up.  Do you have documentation 
for these registers ?  I've been kicking through via's site looking 
for chipset datasheets to no avail.

I toasted one of my raid disks trying to get Win98se installed over
the weekend to do similar testing here.  Didn't like the size of the
disk I tried to install it to, and I ended up with a zapped partition
table and who knows what else.  Thankfully the software raid 5 coped
perfectly (thanks guys!) and the system was back after the rebuild
time.

I've a spare (small) disk to try this with my system today or
tomorrow.  Which ABit bios are you using on that test system currently
?  I put the newest ABios bios (7P vs 65)  on my system (KT7A-RAID
v1.3)  and it appears to have gained me about 3-4MB/sec over the PCI
bus. (54MB/sec vs 50MB/sec)

Attached files are my raw pci data for 00:0 and 00:1, for your 
reference.  It's different enough to your data that it's not easy
to compare though.

Cheers,

Mark

-- 
+-------------------------------------------------------------------------+
Mark Cooke                  The views expressed above are mine and are not
Systems Programmer          necessarily representative of university policy
University Of Birmingham    URL: http://www.sr.bham.ac.uk/~mpc/
+-------------------------------------------------------------------------+

--8323328-581273324-1017682349=:16203
Content-Type: TEXT/plain; name="linux-dev0-7P.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0204011832290.16203@pc24.sr.bham.ac.uk>
Content-Description: 
Content-Disposition: attachment; filename="linux-dev0-7P.txt"

IyBsc3BjaSAteHh4IC1zIDAwOjANCjAwOjAwLjAgSG9zdCBicmlkZ2U6IFZJ
QSBUZWNobm9sb2dpZXMsIEluYy4gVlQ4MzYzLzgzNjUgW0tUMTMzL0tNMTMz
XSAocmV2IDAzKQ0KMDA6IDA2IDExIDA1IDAzIDA2IDAwIDEwIGEyIDAzIDAw
IDAwIDA2IDAwIDA4IDAwIDAwDQoxMDogMDggMDAgMDAgYzAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDANCjIwOiAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCA3YiAxNCAwMSBhNA0KMzA6IDAwIDAw
IDAwIDAwIGEwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwDQo0
MDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDANCjUwOiAxNyBhMyA2YiBiNCA0NyAwOSAyMCAyMCA4OCAwMCAwOCAx
MCAxOCAyMCAyMCAyMA0KNjA6IDBmIGFhIDAyIDIwIDUxIDUxIDUxIDAxIDQ1
IDBjIDQzIDBmIDA4IDVmIDAwIDAwDQo3MDogZGEgODggY2MgMGMgMGUgODAg
ZDIgMDAgMDEgYjQgMTkgMDIgMDAgMDAgMDAgMDANCjgwOiAwZiA0NCAwMCAw
MCAwMCAwMCAwMCAwMCAwMyAwMCAwYyAxMiAwMCAwMCAwMCAwMA0KOTA6IDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDMyIDAwIDAw
DQphMDogMDIgYzAgMjAgMDAgMDMgMDIgMDAgMWYgMDIgMDEgMDAgMDAgNmYg
MTIgMDAgMDANCmIwOiBjOSBlZiA5OCA3NCAzMCBlZSA4MCAwNyA2NyAwMCAw
MCAwMCAwMCAwMCAwMCAwMA0KYzA6IDAxIDAwIDAyIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwDQpkMDogMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDANCmUwOiAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMA0KZjA6
IDAwIDAwIDAwIDAwIDAwIDAzIDA0IDExIDIyIDAwIDAwIDAwIDAwIDgwIDkx
IDA2DQo=
--8323328-581273324-1017682349=:16203
Content-Type: TEXT/plain; name="linux-dev1-7P.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0204011832291.16203@pc24.sr.bham.ac.uk>
Content-Description: 
Content-Disposition: attachment; filename="linux-dev1-7P.txt"

IyBsc3BjaSAteHh4IC1zIDAwOjENCjAwOjAxLjAgUENJIGJyaWRnZTogVklB
IFRlY2hub2xvZ2llcywgSW5jLiBWVDgzNjMvODM2NSBbS1QxMzMvS00xMzMg
QUdQXQ0KMDA6IDA2IDExIDA1IDgzIDA3IDAwIDMwIGEyIDAwIDAwIDA0IDA2
IDAwIDAwIDAxIDAwDQoxMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDEgMDEgMDAgZjAgMDAgMDAgMDANCjIwOiAwMCBkOCBmMCBkOSAwMCBkMCBm
MCBkNyAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMA0KMzA6IDAwIDAwIDAwIDAw
IDgwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDBjIDAwDQo0MDogY2Ig
Y2QgMDggNDQgMjUgNzIgMDUgODMgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAN
CjUwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMA0KNjA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwDQo3MDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDANCjgwOiAwMSAwMCAwMiAwMiAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMA0KOTA6IDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwDQphMDog
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDANCmIwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMA0KYzA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwDQpkMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDANCmUwOiAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMA0KZjA6IDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwDQo=
--8323328-581273324-1017682349=:16203--
