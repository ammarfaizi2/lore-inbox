Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129050AbQKEKNQ>; Sun, 5 Nov 2000 05:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129098AbQKEKNF>; Sun, 5 Nov 2000 05:13:05 -0500
Received: from www.medex.hu ([212.108.197.8]:62988 "EHLO www.medex.hu")
	by vger.kernel.org with ESMTP id <S129050AbQKEKMr>;
	Sun, 5 Nov 2000 05:12:47 -0500
Date: Sun, 5 Nov 2000 11:12:48 +0100 (CET)
From: Kesmarki Attila <danthe@www.medex.hu>
To: Jan Dvorak <johnydog@go.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: tdfx fb with SUN12x22 font on 2.4.0-test10
In-Reply-To: <20001104230923.A8498@napalm.go.cz>
Message-ID: <Pine.LNX.4.10.10011051051100.648-100000@www.medex.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The tdfxfb driver has not too many features in the current kernel.
For example, it is restriceted to use 8 bit width fonts only...

You can enable this support by modifying the display_switch structs in the
tdfxfb.c. You need to replace all the
"fontwidthmask: FONTWIDTH(8)" with "fontwidthmask: ~1"

It may work, because it is implemented in the driver, just not tested yet.     

Or, if you need a better 3dfx support, you can use my driver.
(http://www.medex.hu/~danthe/tdfx)

/Attila Kesmarki

On Sat, 4 Nov 2000, Jan Dvorak wrote:

> Hi,
> 
> i am getting 
> 
> Nov  4 21:50:22 napalm kernel: Adding Swap: 48188k swap-space (priority -1)
> Nov  4 21:50:25 napalm kernel: fbcon_setup: No support for fontwidth 12
> Nov  4 21:50:25 napalm kernel: fbcon_setup: type 0 (aux 0, depth 8) not supported
> Nov  4 21:50:25 napalm kernel: fbcon_setup: No support for fontwidth 12
> Nov  4 21:50:25 napalm kernel: fbcon_setup: type 0 (aux 0, depth 8) not supported
> ...
> 
> when using tdfx framebuffer driver on voodoo3 pci with SUN12x22 font.
> But, the driver and the font (nice font, really) is working just fine.
> So ... where is the magic ? I bet that >8 font width wasn't supported but
> now it is.
> 
> .config attached
> 
> Thanks,
> 
> Jan Dvorak <johnydog@go.cz>
> 
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
