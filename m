Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131768AbQL3E51>; Fri, 29 Dec 2000 23:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131865AbQL3E5Q>; Fri, 29 Dec 2000 23:57:16 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:20744 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131768AbQL3E5M>; Fri, 29 Dec 2000 23:57:12 -0500
Date: Fri, 29 Dec 2000 20:26:25 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: test13-pre5/drivers/sound/via82cxxx_audio.c did not
 compile
In-Reply-To: <20001229200916.A2645@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.10.10012292025510.1722-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Dec 2000, Adam J. Richter wrote:
>
> 	linux-2.4.0-test13-pre5 eliminated vm_operations_struct->swapout,
> but this change was not reflected in drivers/sound/via82cxxx_audio.c,
> causing that file to fail to compile.  I have attached what I believe
> is the correct fix below.

Actually, the right fix is to change all VM_RESERVE to VM_RESERVED (ie add
a "D" at the end), at which point it should compile and work fine..

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
