Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267187AbSK3ARE>; Fri, 29 Nov 2002 19:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267190AbSK3ARE>; Fri, 29 Nov 2002 19:17:04 -0500
Received: from rrcs-midsouth-24-172-39-28.biz.rr.com ([24.172.39.28]:20230
	"EHLO maunzelectronics.com") by vger.kernel.org with ESMTP
	id <S267187AbSK3ARC>; Fri, 29 Nov 2002 19:17:02 -0500
Message-ID: <3DE8052B.F1072528@justirc.net>
Date: Fri, 29 Nov 2002 19:24:11 -0500
From: Mark Rutherford <mark@justirc.net>
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.4.20] Trouble with via 8235 [does not boot]
References: <8F01E9B6A83@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-scanner: scanned by Inflex 1.0.12.3 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wanted to ask about this but forgot....
 Nov 29 18:14:24 Darkstar kernel: PDC20276: neither IDE port enabled (BIOS)
                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

now, this works in 2.4.19, and i can use the devices.
in 2.5.44 its detected as such, didnt realise until I tried to use my zip drive, which is attached to
it.
these devices arent disabled, altho it says they are... there isnt really a 'bios' to enable them in.
it just detects the devices at boot.
im going to try to write some stuff down when it boots, as i dont have a serial cable to monitor its
activities.
but, definately interesting.


Petr Vandrovec wrote:

> On 29 Nov 02 at 18:58, Mark Rutherford wrote:
>
> > I think I have but i will let you all be the judge.
> > please find attached my .config renamed to config.txt for the sake of
> > window$
>
> Nothing strange in it...
>
> > also find attached a normal bootup as of 1 hour ago using kernel 2.5.44
> > I have tried the following:
> > re-downloaded the kernel souces in both tar/bz2 and tar/gzip formats
> > both archives were the same, natually
> > reconfigured both to no avail.
> > what I do not understand is that it does not detect the 2 devices i have
> > on the promise controller, or hda, hdb
> > it does find hdc and hdd and it does seem to detect the via 8235
> > controller as well.
> > what could possibly be wrong here?
>
> >From log you posted:
>
> > Nov 29 18:14:24 Darkstar kernel: PDC20276: IDE controller at PCI slot 00:0f.0
> > Nov 29 18:14:24 Darkstar kernel: PDC20276: chipset revision 1
> > Nov 29 18:14:24 Darkstar kernel: PDC20276: not 100%% native mode: will probe irqs later
> > Nov 29 18:14:24 Darkstar kernel: PDC20276: neither IDE port enabled (BIOS)
>                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > Nov 29 18:14:24 Darkstar kernel: VP_IDE: IDE controller at PCI slot 00:11.1
> > Nov 29 18:14:24 Darkstar kernel: VP_IDE: chipset revision 6
> > Nov 29 18:14:24 Darkstar kernel: VP_IDE: not 100%% native mode: will probe irqs later
> > Nov 29 18:14:24 Darkstar kernel: VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
> > Nov 29 18:14:24 Darkstar kernel: hda: setmax LBA 156250080, native 156250000
> > Nov 29 18:14:24 Darkstar kernel: hda: 156250000 sectors (80000 MB)
> > w/2048KiB Cache, CHS=9726/255/63, UDMA(100)
> > Nov 29 18:14:24 Darkstar kernel:  hda: hda1
> > Nov 29 18:14:24 Darkstar kernel: hdb: 26564832 sectors (13601 MB)
> > w/2048KiB Cache, CHS=1653/255/63, UDMA(66)
> > Nov 29 18:14:24 Darkstar kernel:  hdb: hdb1 hdb2
> > Nov 29 18:14:24 Darkstar kernel: Uniform CD-ROM driver Revision: 3.12
>
> It looks to me like that 2.5.44 also believes that you have
> two HDDs connected to VIA, and none to Promise. Did not just
> 2.4.20 swapped hda/hdb with hdc/hdd?
>
> It would be really handy if you could write down logs from 2.4.20. Or
> capture them with serial console.
>
> You can also boot 2.5.x, look at which address your via lives, and
> then use ide0=... parameters. I believe that via should be configured
> for primary IDE, so try booting 2.4.20 with ' ide0=0x1f0,0x3f6,14'.
>                                             Petr Vandrovec
>                                             vandrove@vc.cvut.cz
>

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

