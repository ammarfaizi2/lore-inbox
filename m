Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261617AbSI2Tlx>; Sun, 29 Sep 2002 15:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261696AbSI2Tlx>; Sun, 29 Sep 2002 15:41:53 -0400
Received: from host187.south.iit.edu ([216.47.130.187]:1664 "EHLO
	host187.south.iit.edu") by vger.kernel.org with ESMTP
	id <S261617AbSI2Tlw>; Sun, 29 Sep 2002 15:41:52 -0400
Date: Sun, 29 Sep 2002 14:45:43 -0500 (CDT)
From: Stephen Marz <smarz@host187.south.iit.edu>
To: Franco Saliola <saliola@polygon.math.cornell.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: kernel BUG in usb-ohci.c:902!
In-Reply-To: <20020929152906.A5092@main.math.cornell.edu>
Message-ID: <Pine.LNX.4.44.0209291440270.1544-100000@host187.south.iit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Sep 2002, Franco Saliola wrote:

> Hello,
> 
> I thought this error may be of interest to someone on this list. My
> computer called it a kernel BUG. I wasn't sure how much information was
> needed, so I played it say and filled out the bug reporting form to the
> best of my ability. If you are only interested in seeing the error
> message, go all the way to the bottom of the message. It's the last
> thing in this mail.
> 
> I'm not subscribed to this list, please copy me on any replies,
> thoughts, suggestions. Thank you.
> 
> Franco
> 
> EIP:	0010:[<d291dd63>]	Not tainted
> EFLAGS:	00010286
> eax: 0000003a	ebx: cf46dc10	ecx: 00000000	edx: cebd0000
> esi: 00000000	edi: 00000002	ebp: c0297ed8	esp: c0297e84
> ds: 0018   es: 0018   ss: 0018
> Process swapper (pid: 0, stackpage=c0297000)
> Stack: d2920f40 cff3ba76 00000002 cf797800 cf46d610 00000202 c025f1f8 00000046
>        cff37fd8 c0297ecc c01191a8 00000046 00000001 d291f66a cf422000 00000001
>        00000000 00000002 cecfa800 ce526000 cd558000 c0297ee8 d290e135 cecfa800
> Call Trace:    [<d2920f40>] [<c01191a8>] [<d291f66a>] [<d290e135>] [<d2a30e2a>]
>   [<d2a30e10>] [<c0123f2c>] [<c01236ed>] [<c01202e2>] [<c01201d4>] [<c012000a>]
>   [<c010a416>] [<c010c8c8>] [<c0110018>] [<c01071a4>] [<c0114b35>] [<c0114a80>]
>   [<c0107212>] [<c0105000>]
> 
> Code: 0f 0b 86 03 0a 0e 92 d2 83 c4 0c e9 75 ff ff ff 57 68 15 0e
>  <0>Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing

I have noticed this problem in 2.5.39 except it occurs with the module 
uhci-hcd.  I can work around the problem by using the 'nousb' feature that 
the redhat rc scripts recognize.  I then load the modules by hand with 
pcmcia initialization first (pcmcia_core->yenta_socket->ds) then usb
ohci-hcd, uhci-hcd, then ehci-hcd last.  Then I can go ahead and load the 
hid and usb-storage drivers also.

Regards,

Stephen Marz

