Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262432AbRFRSbe>; Mon, 18 Jun 2001 14:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262445AbRFRSbZ>; Mon, 18 Jun 2001 14:31:25 -0400
Received: from dialin-194-29-61-221.berlin.gigabell.net ([194.29.61.221]:33285
	"EHLO server1.localnet") by vger.kernel.org with ESMTP
	id <S262432AbRFRSbN>; Mon, 18 Jun 2001 14:31:13 -0400
Date: Mon, 18 Jun 2001 20:32:03 +0200
From: =?ISO-8859-1?Q?Ren=E9?= Rebe <rene.rebe@gmx.net>
To: James Simmons <jsimmons@transvirtual.com>
Cc: linux-kernel@vger.kernel.org, ademar@conectiva.com.br, rolf@sir-wum.de,
        linux-fbdev-devel@lists.sourceforge.net
Subject: Re: sis630 - help needed debugging in the kernel
Message-Id: <20010618203203.35390ca8.rene.rebe@gmx.net>
In-Reply-To: <Pine.LNX.4.10.10106170652280.17509-100000@transvirtual.com>
In-Reply-To: <20010616232740.092475e2.rene.rebe@gmx.net>
	<Pine.LNX.4.10.10106170652280.17509-100000@transvirtual.com>
Organization: FreeSourceCommunity ;-)
X-Mailer: Sylpheed version 0.4.99 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jun 2001 07:03:55 -0700 (PDT)
James Simmons <jsimmons@transvirtual.com> wrote:

[...]

> Yes. It oops in fbcon_cfb8_putc. I haven't figured out yet what exactly
> caused it. I don't have this card to play with :-( Did you run the other
> test I suggested.

Never arrived here :-(. (Pleas cc me, since I'm not on this lists ...)

> Try booting at 640x480 with a color depth of 32. Then
> try booting at a different resolution (1024x768) at the default color
> depth. I want to see if its a error with the resolution setting or if it
> is a error with setting up the data relating to the color depth handling. 
> The results should give me some clue.

I can't set the videomode for the driver ...? I tried:

video=sis:vesa:0x112
video=sis:xres:640,yres:480,depth:32
video=sis,xres:640,yres:480,depth:32

Is there another way to tell the fb driver what mode to use??

I set the shared memory size from 16MB to 64 MB: results:
  sisfb: framebuffer at 0xe0000000, mapped to 0xc8800000, size 65536k
  sisfb: MMIO at 0xefce0000, mapped to 0xcc801000, size 128k
  Unable to handle kernel paging request at virtual address cc8002e0

old results:
  sisfb: framebuffer at 0xe0000000, mapped to 0xcb800000, size 16384k
  sisfb: MMIO at 0xefce0000, mapped to 0xcc801000, size 128k
  Unable to handle kernel paging request at virtual address cc800180

(Maybe some typo somewhere ??)

PS: I have more free time the next days -> shorter latency and more kernel
source read time ...

k33p h4ck1n6 René

-- 
René Rebe (Registered Linux user: #127875)
http://www.rene.rebe.myokay.net/
-Germany-

Anyone sending unwanted advertising e-mail to this address will be charged
$25 for network traffic and computing time. By extracting my address from
this message or its header, you agree to these terms.
