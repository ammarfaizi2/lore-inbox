Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263486AbTIBERR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 00:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263484AbTIBERR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 00:17:17 -0400
Received: from crete.csd.uch.gr ([147.52.16.2]:64671 "EHLO crete.csd.uch.gr")
	by vger.kernel.org with ESMTP id S263493AbTIBERM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 00:17:12 -0400
Organization: 
Date: Tue, 2 Sep 2003 07:14:01 +0300 (EEST)
From: Panagiotis Papadakos <papadako@csd.uoc.gr>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: IOMEGA ZIP 100 ATAPI problems with 2.6
In-Reply-To: <20030901200530.64ad6fb9.akpm@osdl.org>
Message-ID: <Pine.GSO.4.53.0309020713030.9408@oneiro.csd.uch.gr>
References: <Pine.GSO.4.53.0308310037230.27956@oneiro.csd.uch.gr>
 <3F515301.4040305@sbcglobal.net> <3F532C67.6070904@sbcglobal.net>
 <Pine.GSO.4.53.0309020539380.9075@oneiro.csd.uch.gr> <20030901200530.64ad6fb9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here it is...

EIP: 0060:[<c024030d>] Not tainted VLI
....
EIP is at ide_insl+0xd/0x20
....
Call Trace:
[<c02406ad>] ata_input_data+0x5d/0xb0
[<c024007e>] atapi_input_bytes+0x39/0x80
[<c024f204>] idefloppy_input_buffers+0x84/0x110
[<c024f8a2>] ide_intr+0xbc/0x140
[<c024f690>] idefloppy_pc_intr+0x/0x2d0
[<c010c4aa>] handle_IRQ_event+0x3a/0x70
[<c010c7ae>] do_IRQ+0x6e/0xe0
[<c0107000>] _stext+0x0/0x30
[<c02f8534>] common_interrupt+0x18/0x20
[<c0107000>] _stext+0x0/0x30
[<c0108e93>] default_idle+0x23/0x30
[>c0108efc>] cpu_idle+0x2c/0x40
[<c03a6704>] start_kernel+0x144/0x150
[<c03a6480>] unknown_bootoption+0x0/0x100


	Panagiotis Papadakos

On Mon, 1 Sep 2003, Andrew Morton wrote:

> Panagiotis Papadakos <papadako@csd.uoc.gr> wrote:
> >
> > I tried to see if the problem had to do anything with acpi or Preemptible
> >  kernel. So I disabled both of them but the problem still exists. At least
> >  I got a better Oops, which I had to write down on paper. So it probably
> >  has many errors. Here it is if it helps anyone...
>
> You seem to have rampant memory corruption all over the place.
>
> Do you have CONFIG_DEBUG_KERNEL, CONFIG_DEBUG_SLAB and
> CONFIG_DEBUG_PAGEALLOC set?  If not, please enable them and retry.
>
>
