Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318286AbSHPKPw>; Fri, 16 Aug 2002 06:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318287AbSHPKPw>; Fri, 16 Aug 2002 06:15:52 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:25872
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318286AbSHPKPu>; Fri, 16 Aug 2002 06:15:50 -0400
Date: Fri, 16 Aug 2002 03:10:19 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.31 boot failure on pdc20267
In-Reply-To: <22A03733B17@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.10.10208160251460.12468-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Petr,

No d1510r0c.pdf refers to a new created device class 0x0105.
But then again you do not read or vote on the documents so why should I
expect more from you?

[root@xathy root]# lspci
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller (rev 11)
00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP Bridge00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 02)
00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 03)
00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 02)
00:08.0 Unknown mass storage controller: CMD Technology Inc: Unknown device 3112 (rev 01)
00:09.0 Ethernet controller: Intel Corp. 82543GC Gigabit Ethernet Controller (rev 02)
00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 02)
01:05.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01)
02:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB (rev 07)
02:04.0 Class 0105: Pacific Digital Corp: Unknown device 1841 (rev 40)
02:06.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 21)

Now LOOK who is STUPID NOW!
Now read the head of the document and the name of the company?

Now go look at page 26 table 14.

Some day you will learn I am an expert in my field.  I have the hardware
that document refers to and you are smoking a crack pipe.

Proper document you want, heh?  e02105r0 amendment to d1510r0c.pdf

For those who are clueless "Petr Vandrovec", e02105r0 is a direct
reference to the retired SFF-8038i document orginally put forward by
Intel.

If I did not know any better, you are becoming what I used to be.

Regards,

Andre Hedrick
LAD Storage Consulting Group


On Fri, 16 Aug 2002, Petr Vandrovec wrote:

> On 16 Aug 02 at 2:27, Andre Hedrick wrote:
> > On Fri, 16 Aug 2002, Petr Vandrovec wrote:
> > 
> > > Yes. If you'll look at d1510r0c.pdf from ATA guys, you'll find that
> > 
> > BUZZIT!
> > 
> > That is an totally new transport protocol and if you research the pci
> > device class you would know that it has nothing to do with the problem.
> > If you guys are playing with ADMA on DMA Hosts, oh my!
> 
> No. It just reveals that you have no idea what you are talking about.
> It was proven when you talked about EDD, and now it is proven again.
> Table 3 of rev 0f, page 11:
> 
> 
> Byte offset         Description              Attribute     Value
> 09h            Programming Interface Code  | See Table 4 | Defined in table 1
> 0Ah            Subclass code                 Read-only     01h - IDE
> 0Bh            Base class code               Read-only     01h - Mass Storage
> 
> and to your surprise, my IDE interface is:
> 00:1f.1 Class 0101: 8086:244b (rev 05) (prog-if 80 [Master])
> so if this device should not have Class 0101, then there is certainly
> some problem somewhere.
>  
> > The context of what is the EOT between the two HOST protocols has no
> > meaning.
> 
> Yes? Then please tell me what chapter 6, PCI Compatibility and Native
> Bus Master Adapters, pages 22-28 of rev 0c, talks about...
> 
> In rev 0f it is chapter 5, same name, PDF pages 19-26, document pages 10-17.
> EOT is back here in this revision, so actually current standard is OK,
> and Intel is misbehaving (or maybe just "extending" standard?).
> 
> And if you insist that this chapter does not describe UDMA busmastering
> programming interface, then please point me to the correct document.
> There is no other document with simillar name on the T13 web.
>                                                 Petr Vandrovec
>                                                 vandrove@vc.cvut.cz
>                                                 
> 

