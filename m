Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266250AbSLODsV>; Sat, 14 Dec 2002 22:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266256AbSLODsV>; Sat, 14 Dec 2002 22:48:21 -0500
Received: from rrcs-midsouth-24-172-39-28.biz.rr.com ([24.172.39.28]:64263
	"EHLO maunzelectronics.com") by vger.kernel.org with ESMTP
	id <S266250AbSLODsT>; Sat, 14 Dec 2002 22:48:19 -0500
Message-ID: <3DFBFD61.1B367CD2@justirc.net>
Date: Sat, 14 Dec 2002 22:56:17 -0500
From: Mark Rutherford <mark@justirc.net>
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [2.4.20] via82cxxx goes postal and locks system, no full duplex(?)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-scanner: scanned by Inflex 1.0.12.3 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get a lot of errors, sometimes it locks the system, sometimes it does
not.
one of them is as follows:
via_audio: ignoring drain playback error -11
via_audio: ignoring drain playback error -11
via_audio: ignoring drain playback error -11

now this causes no problem because when its happening I hear no change
in the audio, so I basically ignored this error.
I started getting this error, and after this error is logged the box
sometimes deadlocks:

Assertion failed! chan->is_active ==
sg_active(chan->iobase),via82cxxx_audio.c,via_chan_maybe_start,line=1198

this error repeats several times and is the same.
ive got a 50/50 chance of deadlocking at this point.

this is the second failure in getting a via board to work.
I also have a kt400/8235 machine that has no driver, so im really
screwed :(
2 machines both with via sound, both act crazy.
I also have no full duplex, at least I cant find out if this is the
case.
I can play a game, and the game only. if i run something like teamspeak,
or an mp3 player the seconf application will crash, or lock up.
this often triggers the errors above.
I understand this is a full duplex issue.
as long as I do not load 2 apps that use sound, im okay.
I have had to rid KDE of its sound daemon to avoid crashing.
I hope someone has an idea.

lspci info:
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
(rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 1a)
00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 1a)
00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
40)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686
AC97 Audio Controller (rev 50)
00:0a.0 Ethernet controller: Linksys Network Everywhere Fast Ethernet
10/100 model NC100 (rev 11)
01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev
01)

from dmesg:
ac97_codec: AC97 Audio codec, id: 0x414c:0x4710 (ALC200/200P)
via82cxxx: board #1 at 0xDC00, IRQ 10


--
Regards,
Mark Rutherford
mark@justirc.net


File: Mark Rutherford.ASC
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: PGPfreeware 7.0.3 for non-commercial use <http://www.pgp.com>

mQGiBDqwRnsRBADTpKKSKAcphYdcVTvBpEFFNK1eL4dQ/pBwK4NimeoAA9ISD04L
Mv/CqH5g9D1wzXEhRBhbFZnmfoTPFEWH4Gjr4KIPdsXkTEfoJ2j55qksHWMkE10A
K8gZlI3Ovuf8BbIabfXmjf+XtId3F4+7+og4mc7EAkatYbbl/5pR0Niy3wCg/+I/
LUQPYGloF829jXaOW7C+tG8D/RZt8lAL/Z1NfGsQYZlE1X+Gcqf0J6HaMosnVuah
1zAbgUHCIvNq+TOC+0KydEvbs7tAq6m+Q4zQZaqEsMwufTCWxzh+v3thRBLIuT5E
jsTi4djkrdG3TTeAszymO/YEXQMg4Tq2hMiyeWlyTmH4C6enMu0zJMIu4OEef7+W
KpYhBACYnukDVI8Vnw1J5KaiCZYvERhj4cr3BTk7oeYxIRH1x5S6NXK0+uVcpusa
a8ZU4zcxvHh0k3iR8HIZcNh30eXbMF/J5pW9gorJuPwCC5Q7b+gUVaeec+1X+Wmt
2k8RAq9RtriUdrmVN5QcPBLFd4hOHQcWDcuyhmiFp68LFvxLSLQrTWFyayBSdXRo
ZXJmb3JkIDxNYXJrMjAwMEBiZWxsYXRsYW50aWMubmV0PokAWAQQEQIAGAUCOrBG
ewgLAwkIBwIBCgIZAQUbAwAAAAAKCRAudCWX7QO6ULcaAJwIsYHeAp6FC5OVWSOo
qc8O87kvBgCgz1cLgVXYcSlDWEeE32PFYb6akuy5Ag0EOrBGexAIAPZCV7cIfwgX
cqK61qlC8wXo+VMROU+28W65Szgg2gGnVqMU6Y9AVfPQB8bLQ6mUrfdMZIZJ+AyD
vWXpF9Sh01D49Vlf3HZSTz09jdvOmeFXklnN/biudE/F/Ha8g8VHMGHOfMlm/xX5
u/2RXscBqtNbno2gpXI61Brwv0YAWCvl9Ij9WE5J280gtJ3kkQc2azNsOA1FHQ98
iLMcfFstjvbzySPAQ/ClWxiNjrtVjLhdONM0/XwXV0OjHRhs3jMhLLUq/zzhsSlA
GBGNfISnCnLWhsQDGcgHKXrKlQzZlp+r0ApQmwJG0wg9ZqRdQZ+cfL2JSyIZJrqr
ol7DVekyCzsAAgIIAO5Bt3XOgo2GPNOCuLv6A6mRxPxwwVsYEMmVAIp/c5nluBMi
Tu4iQU5f3U9UqZMcFKyLr1Vh0bpO6RB6L/5tXWSRY2Yly9Ofg/e0Npgebkdd8GXE
+IuEDI4lr1kbO70hlxFUPKSOQRjSmmVKNhUAiXEFQ7OtB9k5GECsHrD6qxR6r/ny
XMBK2g2UUSh17Gx/pqH+XwXJ67DEQmF8hcnyiN9E3WQ5w3bIbKwFCaHF+tJbVnUd
XxszxQYrsb6Feo0FVdCD+VVPQGesv34CrnKuED/mF/WoI8a3eYCMiY03IQgW514X
JX+Jnmk9RFbTg75NdXIKDqKpB3wq39n3JmWRZG+JAEwEGBECAAwFAjqwRnsFGwwA
AAAACgkQLnQll+0DulAfjgCfbVxiUtJbpXPn6gVJlnlIzur1yvgAnjh/9bdLsSrd
cUaN07NL7N9NjgG1
=hpbN
-----END PGP PUBLIC KEY BLOCK-----

