Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131734AbRCQTFL>; Sat, 17 Mar 2001 14:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131737AbRCQTFB>; Sat, 17 Mar 2001 14:05:01 -0500
Received: from mx1out.umbc.edu ([130.85.253.51]:47560 "EHLO mx1out.umbc.edu")
	by vger.kernel.org with ESMTP id <S131734AbRCQTEp>;
	Sat, 17 Mar 2001 14:04:45 -0500
Date: Sat, 17 Mar 2001 14:04:02 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: Aaron Lunansky <alunansky@rim.net>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'kees@shoen.nl'" <kees@shoen.nl>
Subject: Re: [OT] how to catch HW fault
In-Reply-To: <A9FD1B186B99D4119BCC00D0B75B4D8104D4AA30@xch01ykf.rim.net>
Message-ID: <Pine.SGI.4.31L.02.0103171401430.313157-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Mar 2001, Aaron Lunansky wrote:

> It could very well be your ram (I don't suspect the cpu). If you can, try a
> different stick of ram.

I've found a good exercise for exercising memory faults is to recompile
the kernel with a -j16 flag; and in a second virtual console, do something
like dd if=/dev/hda of=/dev/null bs=2048k

Either the kernel compile will fail with a sig11, or the dd will fail and
lock the system, in my experience.

I've used this method, crudely, to chase down memory problems in systems
using 256-512MB ram.

YMMV.

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

