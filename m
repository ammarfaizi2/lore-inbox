Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbUB1JO1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 04:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbUB1JO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 04:14:26 -0500
Received: from [213.140.2.58] ([213.140.2.58]:26503 "EHLO
	ms004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S261151AbUB1JN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 04:13:59 -0500
From: Paolo Ornati <ornati@fastwebnet.it>
To: Rik van Riel <riel@redhat.com>
Subject: Re: 2.6.x: iowait problem while burning a CD
Date: Sat, 28 Feb 2004 10:14:16 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0402271915590.1747-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0402271915590.1747-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qvFQAG0c0lGgeSz"
Message-Id: <200402281014.19842.ornati@fastwebnet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_qvFQAG0c0lGgeSz
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 28 February 2004 01:18, Rik van Riel wrote:
> On Fri, 27 Feb 2004, Paolo Ornati wrote:
> > trying to burn a CD "on the fly" I have noticed a strange thing. During
> > the burning "iowait" remains enough low (~3%, MAX 10%) but, after a
> > little time, it suddenly and quickly goes up to 80-90%: in this
> > condition MKFS seems unable to fill the FIFO buffer as quickly as the
> > CD-writer writes
> >
> > Any ideas?
>
> At that point, mkisofs is probably running into a bazillion
> small files, in subdirectories all over the place.
>
> Because a disk seek + track read takes 10ms, it's simply not
> possible to read more than maybe 100 of these small files a
> second, so mkisofs can't keep up.

No... mkfs is reading only ONE big file ( ~ 700 MB )!

And my system shouldn't be so slow:

CPU: AMD Duron 750
RAM: 128 MB PC100
HD: 7200 RPM udma 4
=46ile System: ResiserFS

The last time I wrote a CD I got this:

___________________________________________________________________________
System
=2D----------------------
K3b Version: 0.11.5
KDE Version: 3.1.4
QT Version:  3.2.1

cdrecord
=2D----------------------
scsidev: '/dev/hdc'
devname: '/dev/hdc'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Cdrecord 2.00.3 (i686-pc-linux-gnu) Copyright (C) 1995-2002 J=F6rg Schilling
TOC Type: 1 =3D CD-ROM
Using libscg version 'schily-0.7'
Driveropts: 'burnfree'
atapi: 1
Device type    : Removable CD-ROM
Version        : 0
Response Format: 2
Capabilities   :=20
Vendor_info    : 'HL-DT-ST'
Identifikation : 'CD-RW GCE-8400B '
Revision       : '1.03'
Device seems to be: Generic mmc CD-RW.
Using generic SCSI-3/mmc CD-R driver (mmc_cdr).
Driver flags   : MMC-2 SWABAUDIO BURNFREE=20
Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RAW/R96R
Drive buf size : 1962752 =3D 1916 KB
=46IFO size      : 4194304 =3D 4096 KB
Track 01: data   700 MB       =20
Total size:      804 MB (79:41.01) =3D 358576 sectors
Lout start:      804 MB (79:43/01) =3D 358576 sectors
Current Secsize: 2048
ATIP info from disk:
  Indicated writing power: 4
  Is not unrestricted
  Is not erasable
  Disk sub type: Medium Type A, high Beta category (A+) (3)
  ATIP start of lead in:  -11849 (97:24/01)
  ATIP start of lead out: 359847 (79:59/72)
Disk type:    Long strategy type (Cyanine, AZO or similar)
Manuf. index: 25
Manufacturer: Taiyo Yuden Company Limited
Blocks total: 359847 Blocks current: 359847 Blocks remaining: 1271
Starting to write CD/DVD at speed 32 in real SAO mode for single session.
Last chance to quit, starting real write in 2 seconds.
   1 seconds.
   0 seconds. Operation starts.
Waiting for reader process to fill input buffer ... input buffer ready.
BURN-Free is OFF.
Turning BURN-Free on
Performing OPC...
Sending CUE sheet...
/usr/bin/cdrecord: WARNING: Drive returns wrong startsec (0) using -150
Writing pregap for track 1 at -150
Starting new track at sector: 0
Track 01:    0 of  700 MB written.
Track 01:    1 of  700 MB written (fifo  96%) [buf  98%]   2.4x.
Track 01:    2 of  700 MB written (fifo 100%) [buf  99%]   0.8x.
Track 01:    3 of  700 MB written (fifo 100%) [buf  99%]  20.8x.
Track 01:    4 of  700 MB written (fifo 100%) [buf  99%]  20.2x.
Track 01:    5 of  700 MB written (fifo  98%) [buf  99%]  20.9x.
Track 01:    6 of  700 MB written (fifo 100%) [buf  99%]  20.2x.
Track 01:    7 of  700 MB written (fifo 100%) [buf  99%]  21.0x.
Track 01:    8 of  700 MB written (fifo 100%) [buf  99%]  20.4x.
Track 01:    9 of  700 MB written (fifo 100%) [buf  99%]  21.0x.
Track 01:   10 of  700 MB written (fifo 100%) [buf  99%]  20.4x.
Track 01:   11 of  700 MB written (fifo  98%) [buf  99%]  21.1x.
Track 01:   12 of  700 MB written (fifo 100%) [buf  99%]  20.5x.
Track 01:   13 of  700 MB written (fifo 100%) [buf  99%]  21.2x.
Track 01:   14 of  700 MB written (fifo 100%) [buf  99%]  20.6x.
Track 01:   15 of  700 MB written (fifo 100%) [buf  99%]  21.3x.
Track 01:   16 of  700 MB written (fifo 100%) [buf  99%]  20.7x.
Track 01:   17 of  700 MB written (fifo 100%) [buf  99%]  21.4x.
Track 01:   18 of  700 MB written (fifo  98%) [buf  99%]  20.8x.
Track 01:   19 of  700 MB written (fifo 100%) [buf  99%]  21.5x.
Track 01:   20 of  700 MB written (fifo 100%) [buf  99%]  20.8x.
Track 01:   21 of  700 MB written (fifo 100%) [buf  99%]   3.7x.
Track 01:   22 of  700 MB written (fifo 100%) [buf  99%]  16.2x.

[....]	OK

Track 01:  169 of  700 MB written (fifo  96%) [buf  99%]  16.3x.		<---- ;-(
Track 01:  170 of  700 MB written (fifo  79%) [buf  99%]  16.8x.
Track 01:  171 of  700 MB written (fifo  65%) [buf  99%]  16.3x.
Track 01:  172 of  700 MB written (fifo  50%) [buf  99%]  16.8x.
Track 01:  173 of  700 MB written (fifo  26%) [buf  99%]  16.2x.
Track 01:  174 of  700 MB written (fifo  17%) [buf  99%]  16.7x.
Track 01:  175 of  700 MB written (fifo   4%) [buf  99%]  16.2x.
Track 01:  176 of  700 MB written (fifo   1%) [buf  35%]   7.4x.
Track 01:  177 of  700 MB written (fifo   1%) [buf  82%]   7.9x.
Track 01:  178 of  700 MB written (fifo  14%) [buf  99%]   6.2x.
Track 01:  179 of  700 MB written (fifo   1%) [buf  95%]  14.8x.
Track 01:  180 of  700 MB written (fifo   1%) [buf  56%]   9.5x.
Track 01:  181 of  700 MB written (fifo   4%) [buf  69%]   7.2x.
Track 01:  182 of  700 MB written (fifo  31%) [buf  99%]   6.1x.
Track 01:  183 of  700 MB written (fifo  32%) [buf  99%]  16.1x.
Track 01:  184 of  700 MB written (fifo  31%) [buf  99%]  16.6x.
Track 01:  185 of  700 MB written (fifo  32%) [buf  99%]  16.0x.
Track 01:  186 of  700 MB written (fifo  31%) [buf  99%]  16.5x.
Track 01:  187 of  700 MB written (fifo  26%) [buf  99%]  16.0x.
Track 01:  188 of  700 MB written (fifo  29%) [buf  99%]  16.5x.
Track 01:  189 of  700 MB written (fifo  26%) [buf  99%]  17.0x.
Track 01:  190 of  700 MB written (fifo  23%) [buf  99%]  16.4x.
Track 01:  191 of  700 MB written (fifo  23%) [buf  99%]  17.0x.
Track 01:  192 of  700 MB written (fifo  26%) [buf  99%]  16.4x.
Track 01:  193 of  700 MB written (fifo  31%) [buf  99%]  16.9x.
Track 01:  194 of  700 MB written (fifo  26%) [buf  99%]  16.4x.
Track 01:  195 of  700 MB written (fifo  31%) [buf  99%]  16.9x.
Track 01:  196 of  700 MB written (fifo  29%) [buf  99%]  16.3x.
Track 01:  197 of  700 MB written (fifo  28%) [buf  99%]  16.9x.
Track 01:  198 of  700 MB written (fifo  23%) [buf  99%]  16.3x.
Track 01:  199 of  700 MB written (fifo  23%) [buf  99%]  16.8x.
Track 01:  200 of  700 MB written (fifo  23%) [buf  99%]  16.3x.
Track 01:  201 of  700 MB written (fifo  20%) [buf  99%]  16.8x.
Track 01:  202 of  700 MB written (fifo  17%) [buf  99%]  16.3x.
Track 01:  203 of  700 MB written (fifo  14%) [buf  99%]  16.8x.
Track 01:  204 of  700 MB written (fifo  14%) [buf  99%]  16.2x.
Track 01:  205 of  700 MB written (fifo   7%) [buf  99%]  16.7x.
Track 01:  206 of  700 MB written (fifo   1%) [buf  99%]  16.2x.
Track 01:  207 of  700 MB written (fifo   7%) [buf  70%]  10.7x.
Track 01:  208 of  700 MB written (fifo   1%) [buf  75%]  17.7x.
Track 01:  209 of  700 MB written (fifo   4%) [buf  57%]  12.3x.
Track 01:  210 of  700 MB written (fifo   1%) [buf  51%]  14.7x.
Track 01:  211 of  700 MB written (fifo   4%) [buf  40%]  12.2x.
Track 01:  212 of  700 MB written (fifo  46%) [buf  93%]   6.1x.
Track 01:  213 of  700 MB written (fifo  40%) [buf  99%]  19.0x.
Track 01:  214 of  700 MB written (fifo  40%) [buf  99%]  16.1x.
Track 01:  215 of  700 MB written (fifo  37%) [buf  99%]  16.6x.
Track 01:  216 of  700 MB written (fifo  32%) [buf  99%]  16.0x.
Track 01:  217 of  700 MB written (fifo  31%) [buf  99%]  16.5x.
Track 01:  218 of  700 MB written (fifo  29%) [buf  99%]  16.0x.
Track 01:  219 of  700 MB written (fifo  26%) [buf  99%]  16.5x.
Track 01:  220 of  700 MB written (fifo  23%) [buf  99%]  17.0x.
Track 01:  221 of  700 MB written (fifo  23%) [buf  99%]  16.4x.
Track 01:  222 of  700 MB written (fifo  37%) [buf  99%]  16.9x.
Track 01:  223 of  700 MB written (fifo  62%) [buf  99%]  16.4x.
Track 01:  224 of  700 MB written (fifo  68%) [buf  99%]  16.9x.
Track 01:  225 of  700 MB written (fifo  75%) [buf  99%]  16.4x.
Track 01:  226 of  700 MB written (fifo  82%) [buf  99%]  16.9x.
Track 01:  227 of  700 MB written (fifo  90%) [buf  99%]  16.3x.
Track 01:  228 of  700 MB written (fifo  95%) [buf  99%]  16.9x.
Track 01:  229 of  700 MB written (fifo 100%) [buf  99%]  16.3x.

[....]	OK

Track 01:  314 of  700 MB written (fifo  96%) [buf  99%]  16.4x..		<---- ;-(
Track 01:  315 of  700 MB written (fifo  95%) [buf  99%]  17.0x.
Track 01:  316 of  700 MB written (fifo  93%) [buf  99%]  16.4x.
Track 01:  317 of  700 MB written (fifo  92%) [buf  99%]  16.9x.
Track 01:  318 of  700 MB written (fifo  87%) [buf  99%]  16.4x.
Track 01:  319 of  700 MB written (fifo  82%) [buf  99%]  16.9x.
Track 01:  320 of  700 MB written (fifo  78%) [buf  99%]  16.3x.
Track 01:  321 of  700 MB written (fifo  71%) [buf  99%]  16.9x.
Track 01:  322 of  700 MB written (fifo  71%) [buf  99%]  16.3x.
Track 01:  323 of  700 MB written (fifo  62%) [buf  99%]  16.8x.
Track 01:  324 of  700 MB written (fifo  59%) [buf  99%]  16.3x.
Track 01:  325 of  700 MB written (fifo  46%) [buf  99%]  16.8x.
Track 01:  326 of  700 MB written (fifo  32%) [buf  99%]  16.3x.
Track 01:  327 of  700 MB written (fifo  25%) [buf  99%]  16.8x.
Track 01:  328 of  700 MB written (fifo  10%) [buf  99%]  16.2x.
Track 01:  329 of  700 MB written (fifo  10%) [buf  99%]  16.7x.
Track 01:  330 of  700 MB written (fifo  26%) [buf  99%]  16.2x.
Track 01:  331 of  700 MB written (fifo  40%) [buf  99%]  16.7x.
Track 01:  332 of  700 MB written (fifo  53%) [buf  99%]  16.2x.
Track 01:  333 of  700 MB written (fifo  65%) [buf  99%]  16.7x.
Track 01:  334 of  700 MB written (fifo  78%) [buf  99%]  16.1x.
Track 01:  335 of  700 MB written (fifo  98%) [buf  99%]  16.6x.
Track 01:  336 of  700 MB written (fifo 100%) [buf  99%]  16.1x.

[...]	OK

Track 01:  343 of  700 MB written (fifo  90%) [buf  99%]  16.5x..		<---- ;-(
Track 01:  344 of  700 MB written (fifo  78%) [buf  99%]  17.0x.
Track 01:  345 of  700 MB written (fifo  65%) [buf  99%]  16.4x.
Track 01:  346 of  700 MB written (fifo  56%) [buf  99%]  17.0x.
Track 01:  347 of  700 MB written (fifo  42%) [buf  99%]  16.4x.
Track 01:  348 of  700 MB written (fifo  31%) [buf  99%]  16.9x.
Track 01:  349 of  700 MB written (fifo  17%) [buf  99%]  16.4x.
Track 01:  350 of  700 MB written (fifo   4%) [buf  99%]  16.9x.
Track 01:  351 of  700 MB written (fifo   4%) [buf  48%]   8.4x.
Track 01:  352 of  700 MB written (fifo   4%) [buf  60%]   8.6x.
Track 01:  353 of  700 MB written (fifo  20%) [buf  99%]   6.3x.
Track 01:  354 of  700 MB written (fifo  10%) [buf  99%]  16.8x.
Track 01:  355 of  700 MB written (fifo   4%) [buf  99%]  16.3x.
Track 01:  356 of  700 MB written (fifo   1%) [buf  81%]  12.3x.
Track 01:  357 of  700 MB written (fifo   1%) [buf  55%]  11.0x.
Track 01:  358 of  700 MB written (fifo   1%) [buf  79%]  10.7x.
Track 01:  359 of  700 MB written (fifo  20%) [buf  99%]   6.1x.
Track 01:  360 of  700 MB written (fifo  17%) [buf  99%]  16.7x.
Track 01:  361 of  700 MB written (fifo   7%) [buf  99%]  16.2x.
Track 01:  362 of  700 MB written (fifo   1%) [buf  99%]  16.7x.
Track 01:  363 of  700 MB written (fifo   4%) [buf  84%]  12.6x.
Track 01:  364 of  700 MB written (fifo   1%) [buf  45%]   9.5x.
Track 01:  365 of  700 MB written (fifo   1%) [buf  69%]  10.8x.
Track 01:  366 of  700 MB written (fifo  28%) [buf  99%]   5.8x.
Track 01:  367 of  700 MB written (fifo  26%) [buf  99%]  16.1x.
Track 01:  368 of  700 MB written (fifo  25%) [buf  99%]  16.6x.
Track 01:  369 of  700 MB written (fifo  29%) [buf  99%]  16.1x.
Track 01:  370 of  700 MB written (fifo  31%) [buf  99%]  16.6x.
Track 01:  371 of  700 MB written (fifo  29%) [buf  99%]  16.0x.
Track 01:  372 of  700 MB written (fifo  25%) [buf  99%]  16.5x.
Track 01:  373 of  700 MB written (fifo  32%) [buf  99%]  16.0x.
Track 01:  374 of  700 MB written (fifo  26%) [buf  99%]  16.5x.
Track 01:  375 of  700 MB written (fifo  40%) [buf  99%]  17.0x.
Track 01:  376 of  700 MB written (fifo  48%) [buf  99%]  16.4x.
Track 01:  377 of  700 MB written (fifo  56%) [buf  99%]  16.9x.
Track 01:  378 of  700 MB written (fifo  71%) [buf  99%]  16.4x.
Track 01:  379 of  700 MB written (fifo  78%) [buf  99%]  16.9x.
Track 01:  380 of  700 MB written (fifo  87%) [buf  99%]  16.4x.
Track 01:  381 of  700 MB written (fifo  98%) [buf  99%]  16.9x.
Track 01:  382 of  700 MB written (fifo 100%) [buf  99%]  16.3x.

[...]	OK

Track 01:  437 of  700 MB written (fifo  98%) [buf  99%]  17.0x..		<---- ;-(
Track 01:  438 of  700 MB written (fifo  96%) [buf  99%]  16.4x.
Track 01:  439 of  700 MB written (fifo  85%) [buf  99%]  17.0x.
Track 01:  440 of  700 MB written (fifo  90%) [buf  99%]  16.4x.
Track 01:  441 of  700 MB written (fifo  78%) [buf  99%]  16.9x.
Track 01:  442 of  700 MB written (fifo  78%) [buf  99%]  16.4x.
Track 01:  443 of  700 MB written (fifo  71%) [buf  99%]  16.9x.
Track 01:  444 of  700 MB written (fifo  68%) [buf  99%]  16.4x.
Track 01:  445 of  700 MB written (fifo  62%) [buf  99%]  16.8x.
Track 01:  446 of  700 MB written (fifo  53%) [buf  99%]  16.3x.
Track 01:  447 of  700 MB written (fifo  50%) [buf  99%]  16.8x.
Track 01:  448 of  700 MB written (fifo  42%) [buf  99%]  16.3x.
Track 01:  449 of  700 MB written (fifo  40%) [buf  99%]  16.8x.
Track 01:  450 of  700 MB written (fifo  45%) [buf  99%]  16.2x.
Track 01:  451 of  700 MB written (fifo  51%) [buf  99%]  16.7x.
Track 01:  452 of  700 MB written (fifo  65%) [buf  99%]  16.2x.
Track 01:  453 of  700 MB written (fifo  76%) [buf  99%]  16.7x.
Track 01:  454 of  700 MB written (fifo  90%) [buf  99%]  16.2x.
Track 01:  455 of  700 MB written (fifo 100%) [buf  99%]  16.7x.

[....]	OK

Track 01:  490 of  700 MB written (fifo  98%) [buf  99%]  16.6x..		<---- ;-(
Track 01:  491 of  700 MB written (fifo  98%) [buf  99%]  16.1x.
Track 01:  492 of  700 MB written (fifo  98%) [buf  99%]  16.6x.
Track 01:  493 of  700 MB written (fifo  95%) [buf  99%]  16.1x.
Track 01:  494 of  700 MB written (fifo  89%) [buf  99%]  16.6x.
Track 01:  495 of  700 MB written (fifo  84%) [buf  99%]  16.0x.
Track 01:  496 of  700 MB written (fifo  81%) [buf  99%]  16.5x.
Track 01:  497 of  700 MB written (fifo  71%) [buf  99%]  16.0x.
Track 01:  498 of  700 MB written (fifo  71%) [buf  99%]  16.5x.
Track 01:  499 of  700 MB written (fifo  62%) [buf  99%]  17.0x.
Track 01:  500 of  700 MB written (fifo  59%) [buf  99%]  16.4x.
Track 01:  501 of  700 MB written (fifo  53%) [buf  99%]  16.9x.
Track 01:  502 of  700 MB written (fifo  48%) [buf  99%]  16.4x.
Track 01:  503 of  700 MB written (fifo  46%) [buf  99%]  16.9x.
Track 01:  504 of  700 MB written (fifo  48%) [buf  99%]  16.4x.
Track 01:  505 of  700 MB written (fifo  50%) [buf  99%]  16.9x.
Track 01:  506 of  700 MB written (fifo  45%) [buf  99%]  16.4x.
Track 01:  507 of  700 MB written (fifo  43%) [buf  99%]  16.9x.
Track 01:  508 of  700 MB written (fifo  39%) [buf  99%]  16.3x.
Track 01:  509 of  700 MB written (fifo  37%) [buf  99%]  16.8x.
Track 01:  510 of  700 MB written (fifo  32%) [buf  99%]  16.3x.
Track 01:  511 of  700 MB written (fifo  31%) [buf  99%]  16.8x.
Track 01:  512 of  700 MB written (fifo  26%) [buf  99%]  16.3x.
Track 01:  513 of  700 MB written (fifo  28%) [buf  99%]  16.8x.
Track 01:  514 of  700 MB written (fifo  26%) [buf  99%]  16.2x.
Track 01:  515 of  700 MB written (fifo  31%) [buf  99%]  16.7x.
Track 01:  516 of  700 MB written (fifo  32%) [buf  99%]  16.2x.
Track 01:  517 of  700 MB written (fifo  31%) [buf  99%]  16.7x.
Track 01:  518 of  700 MB written (fifo  29%) [buf  99%]  16.2x.
Track 01:  519 of  700 MB written (fifo  28%) [buf  99%]  16.7x.
Track 01:  520 of  700 MB written (fifo  23%) [buf  99%]  16.1x.
Track 01:  521 of  700 MB written (fifo  28%) [buf  99%]  16.6x.
Track 01:  522 of  700 MB written (fifo  29%) [buf  99%]  16.1x.
Track 01:  523 of  700 MB written (fifo  34%) [buf  99%]  16.6x.
Track 01:  524 of  700 MB written (fifo  40%) [buf  99%]  16.1x.
Track 01:  525 of  700 MB written (fifo  43%) [buf  99%]  16.6x.
Track 01:  526 of  700 MB written (fifo  46%) [buf  99%]  16.0x.
Track 01:  527 of  700 MB written (fifo  50%) [buf  99%]  16.5x.
Track 01:  528 of  700 MB written (fifo  59%) [buf  99%]  16.0x.
Track 01:  529 of  700 MB written (fifo  71%) [buf  99%]  16.5x.
Track 01:  530 of  700 MB written (fifo  81%) [buf  99%]  17.0x.
Track 01:  531 of  700 MB written (fifo  93%) [buf  99%]  16.4x.

[.......................]

Writing  time:  327.622s
Average write speed  14.8x.
Min drive buffer fill was 35%
=46ixating...
=46ixating time:   11.906s
/usr/bin/cdrecord: fifo had 11567 puts and 11567 gets.
/usr/bin/cdrecord: fifo was 320 times empty and 5909 times full, min fill=20
was 0%.
BURN-Free was 11 times used.
___________________________________________________________________________


=46ULL LOG is attached.
As I have already said, every time the buffer goes down I see iowait go up=
=20
to high values (70%, 80%, 90%).

All it works well if I make the ISO image before the writing process.

Bye

=2D-=20
	Paolo Ornati
	Linux v2.6.3

--Boundary-00=_qvFQAG0c0lGgeSz
Content-Type: application/x-gzip;
  name="burning.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="burning.txt.gz"

H4sICPtYQEACA2J1cm5pbmcudHh0AKSdW3MbuXLH3/kp8LIlu7KicL+wyg+2bG98dr3eyNrjSlKp
UxQ5kpmVSIVDeVfng+c5GJLi0AAFNvJXnbOWyOnGbxqXRk8DmM+P7aq5G5we/hn8rK7Y35tlO1vM
R4wPhRiawc9v3/WfqaEY6sG/XfafxI/kUAwGk+mymSyW02d1t5N2Nm2+jdjJWfzn7Ot0cjKIv8zH
d813n3XXXT20I3Yq2Wq8vGlW619vH+bdv4Mv4+V8Nr8ZsU/3zZxdPbKTrZITNmvZQ/xu1cxXEW18
y8bzKZsvVqx9uL9fLFfNdDj4ZTZ/+Iu1N2y6nH1rluxbf2dmKN3gfHsbTA45Hyr2Yma9Pb2fnN52
gqc384eX7Hxx/7ic3XxdsRfnL5kIwZxKziX72/8ub9jnydfZbbz4ZnD56ZxdPt7HuxPsFTt/e3rx
6ePg9zZ+xW5nV+3k5qlwdtJ2Qo+nfOhOBm/XYIv7VTTBydXDcn69bJqTwXg1vp9FVYO3zbfZpGGr
qJnFnxG7aO4W38ZXt81TGdu6YdufWJODi6a9X8zbhr1fLO/G0aJycD6+H1/NbmerWdOur4py8+li
+Y/Z/HqxkTv5119O316efr48GXyYdla9nv0x7mzbfdcV9oX9dP7u1GvO37CTWMi32V7B8Rox5Ork
ibhtmruWrRbsKprkp2beLGcTdnc3WWN/GW5Nc7P94vP55w+n6uzp+6f6ehE/+Edsay+HW0Ox69vx
zeYGPn48jw3l85fXb17//vbDJ/bm94tf31+8e8cGn58aALtbTJto2MvXn9hvr89/fnfJPsdf4//P
LoL97emXC3bx+svZhbCbf7tvtr9cbIplVw/XrJ39s4nFimClMzLWsQhR4uc3g/cf3n/afLs1hBZB
K67jJZqH9SWXy/HkD8bFiE1jzcaLHOfs45unOhtcLlaxAXc6RptPfBSP379wYaSjWcXLqEwZb5yN
hp2sFst28MviIbb12GdWB2TU2UGZ84flMtYs+9xMNoVJrv3g9eWH39i6HVwvF3dsOmv/GA0Y+zCf
zibjzox/LmO7ibV1v/izWcb7675s133tYb5s2lWswXhZ/2mzHLddE42fvI3KYo+8WrfgWGnNdPZw
t+4o7PWP7GvsV+xNE03SFXSzWD6yF6//5SV7oV5G2TXX+g7Z4prdNuNppIw3eyqE14G9CG4kdXej
h6+N9okd3QSv3dooJpw5+XKwJtrQxJ9fFvG+4h10xT9uutmL88dxHFiaH9nr//jEFstYL3ez2/Hy
5eDjeP5wPYwQ0+avaDuz+WA8WT0sO7tcjmePC/bvD7HzxFHj7n48f2S/RNnONm9uF5M/uv4QK3pH
tf1wsqmV9ONlczeebUY/IZ0YfO7urquG2Km6GulGgLO3f3/LxrEd3DexnpSMbFEutqWunXetn12v
b2B+c9t1ybbrsHFYHLcrNvk6nncjy4L9z8Ns9ePGeJ36tfymgKhNdo1nMZ+2w2jlOLbt/8V3f3Xj
83IzWKz1xO+/jDeNpgOIKqex894vF5PI0JV5HYfNqP4+tuHYua7jl8Ph8PsPOqHH4aDr16fv46jY
jfif3r8fDi4f1k6B9d8s5oPfmmUs6a77/NNv51HZ4HMc4Lo/z39/x9qvTbPqPjx7aJdnV7P52ZMH
G7Evry9+/fDrTyO26evLJlbnvI0W2DSN7m6aCXvBX7KH9Zh1KgwffHnqEsvmZny/vsnVupOLrjrW
l+zqa978uf2yq6l1V+xG6X5QWJsyNtunYaEzfvRrw+8vEQcuYS+uZ934HewPL9l/dsMUC/6H/4pX
y6H+K1Egn1cgOO8VhLUCPvSpAlWjQB5QoCsVyFSBKdnA5wpCqsCiBK5KQRy7UwW+kiCrxgASCA4S
CFFVC2IoUgWyksCkClSlDdJqFLUt0aYKTCWBShXUtkSXKqhtiVk1+srOlHZnUdsS02qUHBxQpKga
0lRmRFnVEoXNGpJUlQoyAl2pIO1M0lQqSJuytCiBQwk8ShBAAsUrFaSDqhKVCtK+oCRKoFCCupbo
coLalpiOSMqiBA4lqG2J6QRDBZBAc5BA17bE1DNpiRIolKB2TEz9gjYogUUJHErgUYIAujbDQddm
BEogUQKFEmiUwICuzVjQtRmHEniUIIAEloMEVoDO1UrQuVqFEmiUwIDO1VrQtVmHEniUIICuzXGQ
wAmUQKIECiXQoGtzBnRtzqIEDiXwKEEACTwHXZsXoGvzaOzs0djZa5TAoARo7OzR2NmjsbNHY+fA
QYIgUAI0dg5o7Bw0SmBQAjR2DmjsHDxKAMbO8RrMtQkuUAKJEoCxs+AaJTAoARg7C+5QAo8SBJBA
cJBAgLGzEGDsLIRCCTRKYFACixKAsbMQYOwsBBg7CwnGzkIKlECiBGDsLEo5ljzTlTtXUZ1jyQgs
5t6FBGNnIcHYWUgwdhYKjJ2FEiiBRAkUSqBRAjB2FgqMnYVyKIFHCcDYWVTnWFKC6hxLRgDGzkKD
sbPQGiUwKIFFCRxKAMbOQoOxszBg7CyMQAkkSqBQAjB2FgaMnUV1jiUjcCgBGDsLg8bOFo2dLRo7
WzR2rs6xZARo7GzR2Lk6x5IRoLGzRWPnUo7lu3WqzxGUcizMheMEpRwLs4ZAUGiJzBBsUMqxMGmP
u7ZSjiV+e9y1lXIsjGkCgS0pEDsFyqyX1rmsM5VyLPsKvNwqSJtyKccSXW+6uO/ALQQaQVjfgtBZ
NZZyLPsKjF0ThGxYL+VY9mvBhq0N0lso5ViYErkNUu9cyrEwJY+791KOJSc44N5LOZaDBKlrK+VY
DhJkteAqe2NGUGqJMhAIQhVB7t5LORYm1XHXVsqxHFBwgEBWGjEjUJXVmI4HpRwLjcCgBLayHaSO
JRRboicQ+Mp2kBGESgXJmCg5xwgkL7ZETiCQlb4xI1A1juUQga5UIFMFRe983L1LTvTOzxM4GoHj
awU8J/A0Ame2A0qmINB8o3FrBTKrRkH1zmLr3lMCQfTOmm8JUiOWcixM741I6rB3lqUcS1dsUo0h
HZVlKcdyQMEBguKY6I66dyks5t5lKcdCce9S1HrnjCBUOpaUQHLMuUopMPcupaysxpAqKLVEKwkE
pZZoPYGg1BKdIRCUWqKXBIJSSwzHY2cpizuqDIEAzDtLBeadpRIogUQJFEqgUQIw7ywVmHeW1TmW
jMCjBODuAanB3QNSg3lnqcG8s6zOsWQEGiUwKIFFCRz2aFxW51hS51qdY0kJqnMsKUFljiV37wbM
O8vKHMsBAo0SGOzBtDQWJXAoAZh3lgZcASEtmHeWFsw7y+ocS0agUAKNEhiUAMw7SwvmnWV1jiUj
CCCBA3cPSCdQAjDvLB2Yd5ZOowQGJbAogUMJPOhcq/expM7VgzvvpRcogQSdqwfzztJrlMCgBGDe
WXqHEniUAI2dizmWQHiCEdDYOaCxc0Bj54DGzsGgBBYlQGPngMbOAYydFQdjZ8UFSiBRAjB2VhyM
nRU3KIFFCRxK4FECMHZWAoydlRAogUQJwNhZFXMs4XjeWRVzLPlj4QMEpSfbQREIik+2jz8aV8Uc
i3cEgoA9nFfFHIvzRx2LKuZYnCAQyEoFGUFtjsWnCkot0QQCgSEmLJ8lqM32ZQTFFRCGQFBcFUZw
baUcy0EFqWtTHFvcp0o5loNJ24yguD5REQhU5QrJjEBX9sbUtSlTOdlOXZsCY2elwNhZKY8SgLsH
lAZjZ6XB2FlpiRKoypxrRlDXEnPnWsqxHOwLqWsr5Vi6paHHCUpjopYEAo8tbFM6VC6pSgkMr1xu
nBIY6lqczenGPieQxKW2fKsg7UxG1axLY7lrM7rSsaSuzdSu2c4IiKvCvDi8pEoZ4ppts1nUlZ0t
rAx1VVg4vKxMmVBZC+mgWsqxUFbOKysq1+alztXKyrV5GYGitQOvt9WYNuVSjmWfQJvD69aVNTQF
9qka06Zsbc1CV2ZyBbVrtrN24CsnmpkRQ+WyspSguI+FsHJeFfexEBa2qeI+lkM2SNuBU9jiPuU0
trROFfexaEL0XtzHov1x11bcx2LscddW3MdyKG7MCELlZDslKO5joUTvXmCPxpUH887Kgzvvldco
AZh3Vt6iBA4l8CgBmHdWAcw7qyBQAokSKJRAowQGJUBj54DGzgGNnQMYO2sO7rzXXKAEEiUAT63T
HNx5r7lBCcBT6zQH886ag3lnzcGd91qAO++1ECiBRAkUSqBRAjDvrAWYd9bCoQQeJQBXQGgJ7h7Q
Esw7awnmnbVUKIFGCQxKYFECMO+sJZh31hI8tU4r8NQ6rQRKIFEC8NQ6rcAT37UyKIFFCVxV3Ji7
d+Wx3LtWxbzz8dy71rwyQZESaIFF71rLSgUZgcIy31rX7u3LCAyW+dblHMvxXee6mGMhHOmiizkW
LQkEoTLrmxIUcyzaHHcsxRyLOf5gWhdzLJZCUGyJlkCgK3tjRgDGztqAuwe0cSgBGDtrg8bOFo2d
LRo7WzR2tgol0CgBGjtb8NQ6bR1KAJ5apy0aO1fuY8kJHBo7OzR2dmjs7NDY2aGxs7MoARo7OzR2
dmjs7NHY2QuUQKIEaOzs0djZo7GzR2Nn71ACjxKgsXP1PpbUtYXabF9GIFECVXmQRkZQmif6QCAo
RSxeH3euxbPC/PFjbXTxrLBDUVtGUJt3zghCVdSWOVdTPCvs0HplnSoQlWFfSBVILPtvimeFaUsg
0CiBqYxcMwJbGTdmBMX1iZRaKK5PPL5u3RTPCjt0vFHi2kzxrDDCunVTPCvs0GKejKD2/MSMQFWe
HZgRaGzduhG15ye6VEHt7oGMwKEEtWeFZQShshZSAll7fqJIFYhKApsqkNjCNlPcx6I0gQA8tc6U
97EoAoGtHNZT1yZrnyeaVIGv9I0ZQcDcuynuY8lnKLl7L+5jIWxLMwrceW8UGDsbBcbOBn3nvVEW
JXAogUcJwNjZaDB2Nug7742ujVgyAlWpICPQlVs0MwJTucgzdW269vzE1LUVcyyHElUZQTFiUQSC
2jExJSjmWCgExRyLOx65mmKOxRFcWznHQiHQKIGprIWMoNQSrSMQuMp8Y+pYTK13Tp1rcR+LIUww
LAcJivtYcgW5c7US2xhnbN0u0wMEGiWozTunrq24j4XyBKO4j+WQgozAY3u+jQ3Y/gXjOEjgRKWC
1LU5iWX/TXEfCyH7b4r7WLQhEIA7742rjVhS11bcx6KOb4wzrnYFREYQsH3vpriPRRGi9+I+FooN
yu9jIcTOxfexUCLX4vtYtCUQ1LbEjKB2LU5GUBs7ZwS+UkHqWIrvYzlUC6lzLeZYDilICYo5FkVw
78UcS/4QJneuoXZvX+rayu9jIbi2Yo6F8EIXU34fC+HBdDHHQtj3boKvfBNIRhAqdxsnjsVycOe9
LeZY9rcrr3fei2yrruXU/c58+x4OkypQxG3r+vB7umwxx7JnA2efIyDud/Z825kyAuLOeye3BDpV
QNx5b+3hl5lY6vtYjH+OgPi2NCOfIaC+j0XrZwio72Px8plqLL+PRR09wsEKhTlXKzTmXK0wKIHF
JhhW1Gb7MgJfOc3LCGrniYlrs8Ucy6FpXtqQZO08MSOQlc41I1CYe7fFHAvBvdtijkURHEv5rDBD
IHDYS22s9NjBOlbWtsSUoJhjodhAgXlnq8C8s1UKe1+bVRp7X5stnhUmKAQWO1jHFvex7Csw2zlS
psDTpnn+Oe+sQs2hMlJk3llz7IWwVgvsWBuriSc0bd6WdsC9a1X1PleX1YImnovjw5Yg9UyaeEKT
F89Uo7aVM9WMgNgSrdsqyGzgq2aqLicgvrfPPk3z0oZkiPNEt+4LUmaujXpWmOPPERBbotNbG6Qt
sZhjYSo9H8nkt6BrTis70A4M8Q2SxjxHQIxYNg0p1kI6zSufFbZng6e+kPpG6llhVj3TEg31DZL+
GQLLq2ohJ7DUU+ueTupKx0TqWWHaPtMSraoMujICTZxkqe1JXZkNTNUUx+e3YLHFfbaYYyEs7rPF
HIvSBILat+qmI5IDT62zxRwL4Vhc68BT66yjPsVR276Q+kZHHBONPnx2oKW+8373Rtm0JZZzLDw/
tS4jcNjCNuvQ2Lk6x5ISlHMsxxf32XKO5Xju3RZzLIcWOKbVWMyxSEUg0JUhT0ZgqrpzHr0XcyyH
niunnamYYxGEyNX7ygfTGUGomq3njiVQvXPYHkaaNuVAjFiceMa9B+I8UZvnCIhjolHPxAvFHEvm
XOOIlFZjMKBrK+ZYCPvebTHHQsh821Cb7csIAra80HHs1LrLxWp8y64eV03Lls14erbVMGJOaWVV
jMnOdr+xF8r4LtvfNpPVYtm+HA6+xMtn8xvGVrO7ZnOI/tBK2Q5ef2uW45tmTdSw9r5pprv8yMfZ
nE2Xs28Ni2jXzZJdz25v2Z/jtms2g/ezv8adzuFwuPv9SX3XkAO37eDsoV2eXc3mZ5PpspksltMR
W9/y1/E0XtMtbbl/WLVsPH/686ZZtcNnxdZlS74upmXN3f3qcS1rAg/bD68fbm9/ZHcRfUfLfxgO
3vx+8evp+2XTrD8RYnv1Q9tMh4PBUzFssriL+kaD08M/ORg7/cZuYjU1nb5Xkk2bb6/O4n/Ovk4n
G3O+UpKdTseLjSmXi/tV++rqYTm/7mBOm/+OddR9vxqz01U7+2fzalN5LTtlg8HdH7N2cd0+y7O5
dsAYH8YhnU0X8+ZH1rQRZhyr83o2n7Vf2ZdYp++bKyZNbGoj5UbRWJJzvRaL3pAkptWIu14sdlua
mBhx04sZSxTj35UWw3CCWCwq/o/3Yl7TxIQemT2TBE8sLYykfxKLI7ckipnvxKQliqlolV5MBbpJ
VC9miK3E+JEOvZj1ZDEuezEviGJ2JG0vFv05TcyMuH4Sk0PBiWJ6pEIvFqdzNDE1UqoXi2ElTUyO
lO3FjCCLSdOLWapJxEjtiblAFOsK7MWCIovpXVNWQ+7IYnEE3olJokl02LOkGipDFzO9mKabpO84
amgVvbQ9MefIYnwPMoj/h5gecqpJYu8WvZjwdDHZiylFFhOhF9NUH+DicNKLWU4urfcBeug0ubR9
k3hPF9tVtxlySRbrBzwzFHSTyNCLKU4WE7IX01ST2JFxvZihm6SvADN0klya3jOJt3SxnUliHM7J
Yv2gYMmTpygmZS9Gnjzt+7cY5wqymNC9mKGbRPhezNFNwvcgvaKXxnuxQB3wzN6cyxEnT2sxvScm
Db002YupQC9N9WJG0cVsL2bpJlGuF6NOnvT+fNKRJ09daTuT+CGnm0SqXkzSTSJdL6boJumbsidP
nrrS9u7N0k3S9zdPnjxFsb7jePLkqStt13ECefLUlaZ6McnpYq4XI0+e9kOjMNSeLiZ7MSvpYrYX
c5YutmfJwOliT5YUfMg1WUy7Xkz4esgopugm0boX03STKN+LWbpJdrOgLj1CN8nOm3av8qGbZBeI
dW+CoptkN8XunpjSTbIbJ6OYoptEiV5MK3ppthczdJPIPZM4ukmk7sU8vXfvRuXukV2giz31bhHj
brpJhOvFpKOXxnsx8uQplmZ7MUM3yS5Y6d6LRTfJznVEMU83Cd8rLdBNInY9QA0F3STc92KywiSi
F1N0k+w8ThQzFSaRvZilm2TnhKOYrzDJ3r0Fukl2T55EjLvpvXsXGnWLiui9e+fyu/VYjvzIdue7
u7Vw/P86O4MeN44jjN73V8zRPjA73V3VXa2bL4GNRIETJEJuAVeibWZXS4WkHCu/Pr22NVVEHKC/
z4AEGbtvH1XmkG9matfzmDpWZR4zx9r8dWUNk+x5HtueXOO8u85jxbEMjKQ6VoSyyfxItnOcl5ua
wEiyY21+JNs1vIF1YCTbgVPn4yna6nw8lVBBdT6eSki1cd6tlK3Oj2Q77XvZbgFGUhyz+aN7ux/w
cvs/zWPZsTQ/Ek+1cd7dKdt0PN3aFBhJcqzNj8Rbuc3HUwnR2+bjKdpsPp6izebjqfg1hYEJMBJx
TJWy1U7ZDBhJcqwDI9mOtz591+jGNs67hbIVYCSrYzr/gufnOOO8u1I2mx+Jnz6M827BbXmdj6dg
G1gGRiKOlUrZgHiKNiCetrPFgQHxFG1APLktIfHktoTEU06OAfG0XWgcmDTKBsRTtAHxFG02f3Rv
lzVfvjuhELZx3t0oW5l/D9jOuwcGxFO0aadsrVA2IJ62iwO5IPHktoLEU7TlTtmAeIo2IJ62awoD
A+Ip2oB4ijYgntLnCsoyf9co2mRy5eZ/bEA8RZvOv+Btl1kGVo2yWab+bh0Yyfa2qEg8bVfVBgbE
k7/gjfNuI17MFYondQyIp2gzphQUiSd/765QPIljOVO2UimbdMqGxFOwIfEUbD0Rtja/clP8mvnA
UqdspVA2JJ6KYzVRtqbEW35D4slfFAyKp9Wx1CgbEE/+gmdIPEUbEE/RRsWTQfG02ToUT82xJJQN
2FeONiSegk0rZWsrZTOhbN1wW1mReNoOnIEh8RRssuJ/t4Eh8WSOVaNsSDwFGxNPJUHxZI5loWxA
PEWbJspWicQeWOv4WcfAeiFseX7lJiT2wDIwkuxYUcoGxFO0VWAkq2OtUTYgntxWkHjabpMPDIin
aAPiKdqAeIo2IJ6iDbhrtN1dHxgQT24TJJ7cJvMrN7e2slI2IJ62FYCBqVG2limbVcKm8/vK0aZI
PEUb8s1ewSbASMQxIJ6iDYinaAPiKdqAeHJbReJpW90YGBBP0QbEU7RpoWxAPEWbJcrWlbC1+X3l
4utEA8uFsgErN9EGxFO0VaVsQDxtW0gDA+LJbYbEk9sMiadoA+Jp2+ca2HQ8ZV+VGhgQT9E2fdfo
1gbEk9v6fDxFW0dWbqJteuXm1jYdT9m3xwY2vXJza5uOp1ubGf5UlnV+XznYBobEU7CVlbIJMJLm
2HQ83dpapmxWCVuaj6doS/PxlH3rb2DZKJtkyqZK2dpK2aZXbrLvhg6sN8KW5/eVoy3P7yvf2kqn
bFooW22UzYCRiGNdCVuZj6doK/PxFEdS5uPp1qaJslWlbA04uotjnTlwZD6eok3mV25ubUWIkQgU
T9mxmikbEk9hJH0lbDq/rxxtOh9PtzYknoJNKvEfQKF4CjYknoLNmAOnQvGUHUuVsiHxFGwilE0b
ZWuZshnzglfnV26irc3vK0dbm99XvrVJIibZoHhKjtVO2ZB4CjYknrbzAIPiKTmGxFOwAfG0fc/K
wIB4iljlRmIrZevMSDoST27r8ys3t7ZSKZuulK0KZUPiKdh6xp/Kus7vK4fDdGCZeFscWBHKJkbZ
mHgaGBNPA2PiSRMUT+oYE08DQ+Ip2EQpm3bK1ohrCgMz4mxR8/zKTbTl+X3lWyx3/FLEwKTgF3UG
hsRTsDVuJKaUDYmnzVageGqO5UbZhLjMMjBVylY7ZbNM2Tpz4AgUT+JYJs4DBlaMsmmmbJV5WxQk
nqKtMyPR+X3l+CAViqdgK5Wy6UrZqlA2JJ6SY504gdYKxVNyLK+UDYmnYBPiPGBgNVE2JJ6CzTph
a/MrN9HW5veVb20lUTZRClNuJI0biTEjMSieVseAeNpOjQaGxFOwSaFs2igbEE/RZkLZOnECrR2J
p+1HTAwsV8omK4WpUFg1CgPiKY6kEyOp6/y+crANLAtlA+Ip2oB4ijYgnqINufLUHAPiyW0JiSe3
JSSeoq1UCgPuGsUHWQtla9xIeiJsGVm5cVue31e+tZVC2YB42n5czcCAeIq2ppTNmGdJQeLJbQWJ
p2gricJEKUy5kbRCYcDKjWOCxJM/lQWKp2DLRtmAlZto00rZ2krZgHjyp7LM7ytHTOf3lW8xJJ4C
hsSTOqZC2ZB4CjYknsQxJJ42W4XiSRxD4inYkHgKNmDlJmLAyk18kMaNBFi5cVtDVm7c1ub3lW9t
RSkbEk/FMSSegq01ytaZZ4lB8RSwxIzEoHgKNmmUrXIjQeIp2Iw5ujsUT8UxYOVm+1l/AwNWbqIN
WLmJGLCvHDFg5SZiRoykrci+8mZrK7KvHG3ZKBsST8GGxFOwIfEUbMaNBImnDUvIXaOI5UphslKY
Ekf3wGqjMMsU1okXvJahlZuAAfvKPsmM7CtHmybKVrmRtE7ZOvMsKVA8ZceQeAq2ohQmnXqQlRtJ
40bSmfcAgeIpOwas3Gw/OXdgJVM2qRRWVwprQmHGjESRfWW3KRRPwVZWyobEU7ApNxIkngJmzEgq
FE+rY8Bdo+1HTrcKxVOwIfEUMGDlJj5IYOUm2oB4ijZg5cZtDYkntzVkXzliwL5yxLRQGBBPETNu
JJ0ZiSHxFDEknlbHSqNsSDwFW+VG0jplA1Zu3NaReIoYsHITsSIUBuwrR6xyIwFWbiLWiZHYiuwr
bz+a31YknqINiKdok0rZKjeSJhRmzEgSEk8+koTcNYo2IJ6iTYSyASs30dYSZQPiKdqAlRvHMhRP
AcuNwoQZSYbiKdhqp2zGjaQT7wFWoHgyx7JSWOkUpoXCaqMw40YCrNxs/wsTEyiezDFg5SbaSqVs
wL5ytFWhbMDKTcQ68x6gyL5yxPJKYUUoDImn5ljlRtK4kXRmJBWKp+ZYapSNiqcKxVPAtFNYKxRm
zIHTkJWbiCWlsNwpTAqFIfHUHGvcSIBv9oo2Kp6Miyfj4smgeAqYMiMxKJ6CzTJl68zR3aF4ao5l
oWzFKJtmCqvcSGylbEg8fV7M6iuyr7zZ+grFkzmGxFOw6UrZqlA2Jp76CsXTZktUPA0MWLmJtiIU
JkY9yJooW1PKZsxIMrJy47YMxVOwlURhohSm3EiQeAqYMSMpUDwFLCmF5U5hUihMuZE0biQmFNaZ
9wCB4ilgwMqNv1EJsnITbSqUrXIjQeIp2DrztqjIvnLEslAYE09dqXjqCsVTwIwbCXPlqVcuniqy
chMxKp4qdeVpYJV5W6zIyk20deLUqDdk5cZtDYqnYCuFskmjbFQ8NS6eGhdPxsWTUVeeukHxFDBR
CmOuPHWjrjwNjLlr1DuychMx5spT78jKTcQkU5hyI2nMC16H4inYOj6Sv56u+6flet4/X5721+Pp
ebnuH54Oy+X4n8OrZf314+fT28fz8d33h2V/vZ6PDx+vh8vy8Gn8/mp8yf7rZ707ng9vr6fzp88f
Wu++3V9/CF/xi58/8OWr8SDuXu9/Wh7Oj8vlw/7tYfl4GY+wrOt6V9S01eXw0/XwfL0s/z4fr+NP
yxdtXZfXD1/e3b1/PF5O312Wt6f3++d3r+52v/3P3f3Hy/n+4fh8/xnYff/xOH4777+77j6cji9f
ffdmeXN6+kda0rL78fR0OVyXZffV+PXt+PVh/Lp8uhzfLX/85k9/+/vnz9i9/E0c2F0O/3o+vfz7
5XS+LvfX9x/uH98ddv/c/7gfD/D+sTz8pfz560/7342PLLvzsvvhOD78dLz89id/dXr9h28efvnk
p2U3Hvru6fDj4WnJ4xGNcf5/8uvfv3n88Ivm7u6/2P5NoYpXAQA=

--Boundary-00=_qvFQAG0c0lGgeSz--

