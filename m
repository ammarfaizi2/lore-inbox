Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQKTBDV>; Sun, 19 Nov 2000 20:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129805AbQKTBDL>; Sun, 19 Nov 2000 20:03:11 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:10509 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129210AbQKTBDF>; Sun, 19 Nov 2000 20:03:05 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.4.0-test11-pre7: isapnp hang
Date: 19 Nov 2000 16:32:38 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8v9rf6$54k$1@cesium.transmeta.com>
In-Reply-To: <20001119233450.H20970@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20001119233450.H20970@redhat.com>
By author:    Tim Waugh <twaugh@redhat.com>
In newsgroup: linux.dev.kernel
> 
> Reading from port 0x313 (my ISA NE2000 is at 0x300-0x31f) hangs my
> machine dead.  Unfortunately, reading from that port is exactly what
> the isapnp code does on boot, if compiled into the kernel.
> 
> Is it the network card's fault (probably), or is there a less invasive
> probe that isapnp could use (unlikely, I guess)?
> 

Try reserving ports 0x300-0x31f on the kernel command line
("reserve=0x300,0x20").

I'm surprised isapnp uses a port in such a commonly used range,
though.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
