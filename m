Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290728AbSAYSDR>; Fri, 25 Jan 2002 13:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290758AbSAYSDC>; Fri, 25 Jan 2002 13:03:02 -0500
Received: from skiathos.physics.auth.gr ([155.207.123.3]:62197 "EHLO
	skiathos.physics.auth.gr") by vger.kernel.org with ESMTP
	id <S290728AbSAYSCu>; Fri, 25 Jan 2002 13:02:50 -0500
Date: Fri, 25 Jan 2002 20:02:43 +0200 (EET)
From: Liakakis Kostas <kostas@skiathos.physics.auth.gr>
To: Lionel Bouton <Lionel.Bouton@inet6.fr>
cc: linux-kernel@vger.kernel.org,
        Liakakis Kostas <kostas@skiathos.physics.auth.gr>
Subject: Re: [PATCH RFC] SiS 2.4 IDE driver update (+= ATA16|ATA33|ATA100)
In-Reply-To: <20020125172155.A11517@bouton.inet6-interne.fr>
Message-ID: <Pine.GSO.4.21.0201251942130.19355-200000@skiathos.physics.auth.gr>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1903590565-1011981763=:19355"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1903590565-1011981763=:19355
Content-Type: TEXT/PLAIN; charset=US-ASCII


Well, success :-)
Stock 2.4.17 doesn't hang any more :-)

One question though, hdparm -i/I says my drive is udma2 (UDMA/33 isnt it?)
capable. Why don't I get it on boot? (or is my chipset UDMA/33 capable?).
hdparm -X66 /dev/hda hangs the machine completely. Same with 65 and 64.
The debug messages that appear when I do so say:

sis5513_tune_chipset start, changed registers: none 
sis5513_tune_chipset ,drive 0, speed 66
sis5513_tune_chipset end, changed registers: none

Attached is the boot time debug info.

Thanks,

-K.


---559023410-1903590565-1011981763=:19355
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=dmesg
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.21.0201252002430.19355@skiathos.physics.auth.gr>
Content-Description: 
Content-Disposition: attachment; filename=dmesg

aWRlOiBBc3N1bWluZyAzM01IeiBzeXN0ZW0gYnVzIHNwZWVkIGZvciBQSU8g
bW9kZXM7IG92ZXJyaWRlIHdpdGggaWRlYnVzPXh4DQpTSVM1NTEzOiBJREUg
Y29udHJvbGxlciBvbiBQQ0kgYnVzIDAwIGRldiAwOQ0KUENJOiBBc3NpZ25l
ZCBJUlEgMTQgZm9yIGRldmljZSAwMDowMS4xDQpTSVM1NTEzOiBjaGlwc2V0
IHJldmlzaW9uIDIwOA0KU0lTNTUxMzogbm90IDEwMCUgbmF0aXZlIG1vZGU6
IHdpbGwgcHJvYmUgaXJxcyBsYXRlcg0KU0lTNTUxMyBwY2lfaW5pdF9zaXM1
NTEzIHN0YXJ0DQpTSVM1NTEzIGR1bXA6DQogICAgICAgICAgICAgIDB4MDow
eDM5IDB4MToweDEwIDB4MjoweDEzIDB4MzoweDU1IDB4NDoweDcgMHg1OjB4
MCAweDY6MHgwIDB4NzoweDAgMHg4OjB4ZDAgMHg5OjB4OGEgMHhhOjB4MSAw
eGI6MHgxIDB4YzoweDAgMHhkOjB4NDAgMHhlOjB4ODAgMHhmOjB4MA0KICAg
ICAgICAgICAgICAweDEwOjB4ZjEgMHgxMToweDEgMHgxMjoweDAgMHgxMzow
eDAgMHgxNDoweGY1IDB4MTU6MHgzIDB4MTY6MHgwIDB4MTc6MHgwIDB4MTg6
MHg3MSAweDE5OjB4MSAweDFhOjB4MCAweDFiOjB4MCAweDFjOjB4NzUgMHgx
ZDoweDMgMHgxZToweDAgMHgxZjoweDANCiAgICAgICAgICAgICAgMHgyMDow
eDEgMHgyMToweDQwIDB4MjI6MHgwIDB4MjM6MHgwIDB4MjQ6MHgwIDB4MjU6
MHgwIDB4MjY6MHgwIDB4Mjc6MHgwIDB4Mjg6MHgwIDB4Mjk6MHgwIDB4MmE6
MHgwIDB4MmI6MHgwIDB4MmM6MHgwIDB4MmQ6MHgwIDB4MmU6MHgwIDB4MmY6
MHgwDQogICAgICAgICAgICAgIDB4MzA6MHgwIDB4MzE6MHgwIDB4MzI6MHgw
IDB4MzM6MHgwIDB4MzQ6MHgwIDB4MzU6MHgwIDB4MzY6MHgwIDB4Mzc6MHgw
IDB4Mzg6MHgwIDB4Mzk6MHgwIDB4M2E6MHgwIDB4M2I6MHgwIDB4M2M6MHhl
IDB4M2Q6MHgxIDB4M2U6MHgwIDB4M2Y6MHgwDQogICAgICAgICAgICAgIDB4
NDA6MHgxIDB4NDE6MHhhMyAweDQyOjB4MCAweDQzOjB4MCAweDQ0OjB4MCAw
eDQ1OjB4MCAweDQ2OjB4MCAweDQ3OjB4MCAweDQ4OjB4MCAweDQ5OjB4NyAw
eDRhOjB4YTYgMHg0YjoweGZmIDB4NGM6MHgwIDB4NGQ6MHgyIDB4NGU6MHgw
IDB4NGY6MHgyDQpTaVM1NTEzDQpTSVM1NTEzOiBwY2lfaW5pdF9zaXM1NTEz
IGVuZCwgY2hhbmdlZCByZWdpc3RlcnM6DQpub25lDQogICAgaWRlMDogQk0t
RE1BIGF0IDB4NDAwMC0weDQwMDcsIEJJT1Mgc2V0dGluZ3M6IGhkYTpwaW8s
IGhkYjpwaW8NCiAgICBpZGUxOiBCTS1ETUEgYXQgMHg0MDA4LTB4NDAwZiwg
QklPUyBzZXR0aW5nczogaGRjOnBpbywgaGRkOnBpbw0KaGRhOiBTVDM0MzIx
QSwgQVRBIERJU0sgZHJpdmUNCmlkZTAgYXQgMHgxZjAtMHgxZjcsMHgzZjYg
b24gaXJxIDE0DQpoZGE6IDg0MDQ4MzAgc2VjdG9ycyAoNDMwMyBNQikgdy8x
MjhLaUIgQ2FjaGUsIENIUz01MjMvMjU1LzYzDQpQYXJ0aXRpb24gY2hlY2s6
DQo=
---559023410-1903590565-1011981763=:19355--
