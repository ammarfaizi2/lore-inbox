Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbTILQ2d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 12:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbTILQ2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 12:28:33 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:21376 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S261751AbTILQ2a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 12:28:30 -0400
Date: Fri, 12 Sep 2003 18:28:12 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: krose+linux-kernel@krose.org
Cc: ken@krwtech.com, linux-kernel@vger.kernel.org
Subject: Re: NVIDIA proprietary driver problem
Message-ID: <20030912162812.GA10942@vana.vc.cvut.cz>
References: <87u17if7eu.fsf@nausicaa.krose.org> <Pine.LNX.4.51.0309121553500.14124@dns.toxicfilms.tv> <87r82mf6j9.fsf@nausicaa.krose.org> <Pine.LNX.4.56.0309121023440.973@death>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0309121023440.973@death>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 10:29:43AM -0400, Ken Witherow wrote:
> On Fri, 12 Sep 2003, Kyle Rose wrote:
> 
> > > What motherboard is it?
> >
> > Tyan Tiger MP, dual Athlon MP 1800's.
> 
> I've got the same motherboard and processors with a GF4 MX420
> 
> I'm running 2.6.0-test5 with the 4496 drivers with the patches from
> minion.de without any problems.
> 
> Sep  9 00:06:08 death kernel: nvidia: no version magic, tainting kernel.
> Sep  9 00:06:08 death kernel: nvidia: module license 'NVIDIA' taints
> kernel.
> Sep  9 00:06:08 death kernel: 1: nvidia: loading NVIDIA Linux x86 nvidia.o
> Kernel Module  1.0-4496 Wed Jul 16 19:03:09 PDT 2003

BIOS has setting whether IRQ should be assigned to the VGA card
or not - default is not, and if you'll leave it this way, you'll get
no IRQ:

platan:~# lspci -s 0:0e.0 -vb
00:0e.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Rage XL
        Flags: bus master, stepping, medium devsel, latency 66, IRQ 255
        Memory at 51000000 (32-bit, non-prefetchable)
        I/O ports at 1000
        Memory at 50001000 (32-bit, non-prefetchable)
        Capabilities: [5c] Power Management version 2

If you'll change BIOS's setting, your Nvidia (or vsync code on matroxfb) should 
work.
							Petr Vandrovec

