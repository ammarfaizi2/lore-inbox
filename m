Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316531AbSE0J1z>; Mon, 27 May 2002 05:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316532AbSE0J1z>; Mon, 27 May 2002 05:27:55 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:23790 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S316531AbSE0J1w>; Mon, 27 May 2002 05:27:52 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15601.64501.570227.377633@wombat.chubb.wattle.id.au>
Date: Mon, 27 May 2002 19:27:17 +1000
To: David Gibson <hermes@gibson.dropbear.id.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jt@hpl.hp.com,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Orinoco Wireless driver bugs in 2.5.17
In-Reply-To: <385229951@toto.iv>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
X-Face: .slVUC18R`%{j(W3ztQe~*ATzet;h`*Wv33MZ]*M,}9AP<`+C=U)c#NzI5vK!0^d#6:<_`a
 {#.<}~(T^aJ~]-.C'p~saJ7qZXP-$AY==]7,9?WVSH5sQ}g3,8j>u%@f$/Z6,WR7*E~BFY.Yjw,H6<
 F.cEDj2$S:kO2+-5<]afj@kC!:uw\(<>lVpk)lPZs+2(=?=D/TZPG+P9LDN#1RRUPxdX
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David Gibson <hermes@gibson.dropbear.id.au> writes:

David> On Wed, May 22, 2002 at 07:24:37PM +0100, Alan Cox wrote:
>> > Alan, > Could you be more precise and point out which kernel
>> start > failing ?
>> 
>> Certainly in 2.4.18 (and I've seen a pile of other similar
>> reports).

David> Ah, bugger.

FWIW, with 2.4.17 the orinoco driver in the Compaq PCI bridge works.

In 2.4.18 it does not.  I see no interrupts for the device in
/proc/interrupts.

This is from v2.4.17:
May 27 11:49:20 wombat kernel: Linux Kernel Card Services 3.1.22
May 27 11:49:20 wombat kernel:   options:  [pci] [cardbus] [pm]
May 27 11:49:20 wombat kernel: Yenta IRQ list 0000, PCI irq17
May 27 11:49:20 wombat kernel: Socket status: 10000011
May 27 11:49:20 wombat kernel: cs: IO port probe 0x0c00-0x0cff: clean.
May 27 11:49:20 wombat kernel: cs: IO port probe 0x0800-0x08ff: clean.
May 27 11:49:20 wombat kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x290-
0x297 0x3f0-0x3ff 0x4d0-0x4d7
May 27 11:49:20 wombat kernel: cs: IO port probe 0x0a00-0x0aff: clean.
May 27 11:49:20 wombat kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
May 27 11:49:21 wombat kernel: hermes.c: 3 Oct 2001 David Gibson <hermes@gibson.dropbear.id.au>
dropbear.id.au>
May 27 11:49:21 wombat kernel: orinoco.c 0.08a (David Gibson <hermes@gibson.dropbear.id.au> and others)
May 27 11:49:21 wombat kernel: orinoco_cs.c 0.08a (David Gibson <hermes@gibson.dropbear.id.au> and others)
May 27 11:49:21 wombat kernel: eth1: Station identity 001f:0001:0006:0010
May 27 11:49:21 wombat kernel: eth1: Looks like a Lucent/Agere firmware version 6.16
May 27 11:49:21 wombat kernel: eth1: Ad-hoc demo mode supported.
May 27 11:49:21 wombat kernel: eth1: IEEE standard IBSS ad-hoc mode supported.
May 27 11:49:21 wombat kernel: eth1: WEP supported, "128"-bit key.
May 27 11:49:21 wombat kernel: eth1: MAC address 00:02:A5:2E:10:BA
May 27 11:49:21 wombat kernel: eth1: Station name "HERMES I"
May 27 11:49:21 wombat kernel: eth1: ready
May 27 11:49:21 wombat kernel: eth1: index 0x01: Vcc 5.0, irq 17, io 0x0100-0x013f

