Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265346AbTFUVX3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 17:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265361AbTFUVX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 17:23:29 -0400
Received: from twinlark.arctic.org ([168.75.98.6]:24998 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S265346AbTFUVXS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 17:23:18 -0400
Date: Sat, 21 Jun 2003 14:37:20 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.72 won't boot with keyboard plugged in
Message-ID: <Pine.LNX.4.53.0306211430280.26771@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1269302882-749807815-1056231440=:26771"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1269302882-749807815-1056231440=:26771
Content-Type: TEXT/PLAIN; charset=US-ASCII

i've got a system which boots to this point:

...
Uniform CD-ROM driver Revision: 3.12
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
atkbd.c: frame/parity error: 02
atkbd.c: frame/parity error: 02
atkbd.c: frame/parity error: 02
atkbd.c: frame/parity error: 02

that message repeats dozens of times then it gets into a crash oops loop,
printing oops after oops after oops, which i'm not sure contain any useful
data, but i've included the first oops below.

the system boots fine if i unplug the keyboard & mouse.

any ideas?

i attached the non-comments portion of the config.

-dean

<1>Unable to handle kernel NULL pointer dereference at virtual address 0000005c
 printing eip:
c011367d
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c011367d>]    Not tainted
EFLAGS: 00010013
EIP is at do_page_fault+0x3d/0x3f4
eax: dde3e000   ebx: 00000000   ecx: 0000007b   edx: 0000007b
esi: 00000000   edi: 0000005c   ebp: dde8a028   esp: dde3e094
ds: 007b   es: 007b   ss: 0068
Process  (pid: -571573688, threadinfo=dde3c000 task=ddee79cc)
Stack: c14d2304 00000032 00000001 000041ed 00000003 00000000 00000000 00000000
       00000000 00000000 3e25f0bc 0d394db0 3e25f0bc 0d394db0 3e25f0bc 0d394db0
       0000000c 00001000 00000000 00000000 00000000 00000001 00000000 dde3e0f0
Call Trace:
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c01a9774>] pci_release_dev+0x0/0xc
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c01a9774>] pci_release_dev+0x0/0xc
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4
 [<c0113640>] do_page_fault+0x0/0x3f4
 [<c01090d9>] error_code+0x2d/0x38
 [<c011367d>] do_page_fault+0x3d/0x3f4


--1269302882-749807815-1056231440=:26771
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="config.trim"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.53.0306211437200.26771@twinlark.arctic.org>
Content-Description: 
Content-Disposition: attachment; filename="config.trim"

Q09ORklHX1g4Nj15DQpDT05GSUdfTU1VPXkNCkNPTkZJR19VSUQxNj15DQpD
T05GSUdfR0VORVJJQ19JU0FfRE1BPXkNCkNPTkZJR19FWFBFUklNRU5UQUw9
eQ0KQ09ORklHX1NXQVA9eQ0KQ09ORklHX1NZU1ZJUEM9eQ0KQ09ORklHX1NZ
U0NUTD15DQpDT05GSUdfTE9HX0JVRl9TSElGVD0xNA0KQ09ORklHX0ZVVEVY
PXkNCkNPTkZJR19FUE9MTD15DQpDT05GSUdfTU9EVUxFUz15DQpDT05GSUdf
TU9EVUxFX1VOTE9BRD15DQpDT05GSUdfTU9EVUxFX0ZPUkNFX1VOTE9BRD15
DQpDT05GSUdfT0JTT0xFVEVfTU9EUEFSTT15DQpDT05GSUdfS01PRD15DQpD
T05GSUdfWDg2X1BDPXkNCkNPTkZJR19NMzg2PXkNCkNPTkZJR19YODZfTDFf
Q0FDSEVfU0hJRlQ9NA0KQ09ORklHX1JXU0VNX0dFTkVSSUNfU1BJTkxPQ0s9
eQ0KQ09ORklHX1g4Nl9QUFJPX0ZFTkNFPXkNCkNPTkZJR19YODZfRjAwRl9C
VUc9eQ0KQ09ORklHX1g4Nl9NQ0U9eQ0KQ09ORklHX1g4Nl9NU1I9eQ0KQ09O
RklHX1g4Nl9DUFVJRD15DQpDT05GSUdfRUREPXkNCkNPTkZJR19OT0hJR0hN
RU09eQ0KQ09ORklHX01UUlI9eQ0KQ09ORklHX1BDST15DQpDT05GSUdfUENJ
X0dPQU5ZPXkNCkNPTkZJR19QQ0lfQklPUz15DQpDT05GSUdfUENJX0RJUkVD
VD15DQpDT05GSUdfUENJX05BTUVTPXkNCkNPTkZJR19JU0E9eQ0KQ09ORklH
X0hPVFBMVUc9eQ0KQ09ORklHX1BDTUNJQT15DQpDT05GSUdfUENNQ0lBX1BS
T0JFPXkNCkNPTkZJR19LQ09SRV9FTEY9eQ0KQ09ORklHX0JJTkZNVF9BT1VU
PXkNCkNPTkZJR19CSU5GTVRfRUxGPXkNCkNPTkZJR19CSU5GTVRfTUlTQz15
DQpDT05GSUdfUE5QPXkNCkNPTkZJR19QTlBfTkFNRVM9eQ0KQ09ORklHX0JM
S19ERVZfRkQ9eQ0KQ09ORklHX0xCRD15DQpDT05GSUdfSURFPXkNCkNPTkZJ
R19CTEtfREVWX0lERT15DQpDT05GSUdfQkxLX0RFVl9JREVESVNLPXkNCkNP
TkZJR19JREVESVNLX01VTFRJX01PREU9eQ0KQ09ORklHX0JMS19ERVZfSURF
Q0Q9eQ0KQ09ORklHX0JMS19ERVZfQ01ENjQwPXkNCkNPTkZJR19CTEtfREVW
X0lERVBDST15DQpDT05GSUdfQkxLX0RFVl9HRU5FUklDPXkNCkNPTkZJR19J
REVQQ0lfU0hBUkVfSVJRPXkNCkNPTkZJR19CTEtfREVWX0lERURNQV9QQ0k9
eQ0KQ09ORklHX0lERURNQV9QQ0lfQVVUTz15DQpDT05GSUdfQkxLX0RFVl9J
REVETUE9eQ0KQ09ORklHX0JMS19ERVZfQURNQT15DQpDT05GSUdfQkxLX0RF
Vl9BTEkxNVgzPXkNCkNPTkZJR19CTEtfREVWX1BJSVg9eQ0KQ09ORklHX0JM
S19ERVZfUloxMDAwPXkNCkNPTkZJR19JREVETUFfQVVUTz15DQpDT05GSUdf
QkxLX0RFVl9JREVfTU9ERVM9eQ0KQ09ORklHX05FVD15DQpDT05GSUdfUEFD
S0VUPXkNCkNPTkZJR19VTklYPXkNCkNPTkZJR19JTkVUPXkNCkNPTkZJR19J
UF9NVUxUSUNBU1Q9eQ0KQ09ORklHX0lQVjZfU0NUUF9fPXkNCkNPTkZJR19O
RVRERVZJQ0VTPXkNCkNPTkZJR19EVU1NWT1tDQpDT05GSUdfTkVUX0VUSEVS
TkVUPXkNCkNPTkZJR19ORVRfVFVMSVA9eQ0KQ09ORklHX0RNOTEwMj15DQpD
T05GSUdfTkVUX1BDST15DQpDT05GSUdfRTEwMD15DQpDT05GSUdfTkVUX1BD
TUNJQT15DQpDT05GSUdfUENNQ0lBX1BDTkVUPXkNCkNPTkZJR19JTlBVVD15
DQpDT05GSUdfSU5QVVRfTU9VU0VERVY9eQ0KQ09ORklHX0lOUFVUX01PVVNF
REVWX1BTQVVYPXkNCkNPTkZJR19JTlBVVF9NT1VTRURFVl9TQ1JFRU5fWD0x
MDI0DQpDT05GSUdfSU5QVVRfTU9VU0VERVZfU0NSRUVOX1k9NzY4DQpDT05G
SUdfU09VTkRfR0FNRVBPUlQ9eQ0KQ09ORklHX1NFUklPPXkNCkNPTkZJR19T
RVJJT19JODA0Mj15DQpDT05GSUdfSU5QVVRfS0VZQk9BUkQ9eQ0KQ09ORklH
X0tFWUJPQVJEX0FUS0JEPXkNCkNPTkZJR19JTlBVVF9NT1VTRT15DQpDT05G
SUdfTU9VU0VfUFMyPXkNCkNPTkZJR19WVD15DQpDT05GSUdfVlRfQ09OU09M
RT15DQpDT05GSUdfSFdfQ09OU09MRT15DQpDT05GSUdfU0VSSUFMXzgyNTA9
eQ0KQ09ORklHX1NFUklBTF84MjUwX0NPTlNPTEU9eQ0KQ09ORklHX1NFUklB
TF84MjUwX0VYVEVOREVEPXkNCkNPTkZJR19TRVJJQUxfODI1MF9TSEFSRV9J
UlE9eQ0KQ09ORklHX1NFUklBTF9DT1JFPXkNCkNPTkZJR19TRVJJQUxfQ09S
RV9DT05TT0xFPXkNCkNPTkZJR19VTklYOThfUFRZUz15DQpDT05GSUdfVU5J
WDk4X1BUWV9DT1VOVD0yNTYNCkNPTkZJR19FWFQyX0ZTPXkNCkNPTkZJR19F
WFQyX0ZTX1hBVFRSPXkNCkNPTkZJR19FWFQzX0ZTPXkNCkNPTkZJR19FWFQz
X0ZTX1hBVFRSPXkNCkNPTkZJR19FWFQzX0ZTX1BPU0lYX0FDTD15DQpDT05G
SUdfSkJEPXkNCkNPTkZJR19GU19NQkNBQ0hFPXkNCkNPTkZJR19GU19QT1NJ
WF9BQ0w9eQ0KQ09ORklHX0lTTzk2NjBfRlM9eQ0KQ09ORklHX0pPTElFVD15
DQpDT05GSUdfVURGX0ZTPXkNCkNPTkZJR19GQVRfRlM9eQ0KQ09ORklHX01T
RE9TX0ZTPXkNCkNPTkZJR19WRkFUX0ZTPXkNCkNPTkZJR19QUk9DX0ZTPXkN
CkNPTkZJR19ERVZQVFNfRlM9eQ0KQ09ORklHX1RNUEZTPXkNCkNPTkZJR19S
QU1GUz15DQpDT05GSUdfTVNET1NfUEFSVElUSU9OPXkNCkNPTkZJR19OTFM9
eQ0KQ09ORklHX05MU19ERUZBVUxUPSJpc284ODU5LTEiDQpDT05GSUdfTkxT
X0NPREVQQUdFXzQzNz15DQpDT05GSUdfTkxTX0lTTzg4NTlfMT15DQpDT05G
SUdfVkdBX0NPTlNPTEU9eQ0KQ09ORklHX0RVTU1ZX0NPTlNPTEU9eQ0KQ09O
RklHX0tBTExTWU1TPXkNCkNPTkZJR19YODZfQklPU19SRUJPT1Q9eQ0K

--1269302882-749807815-1056231440=:26771--
