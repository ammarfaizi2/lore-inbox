Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132606AbQKDI2e>; Sat, 4 Nov 2000 03:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132620AbQKDI2P>; Sat, 4 Nov 2000 03:28:15 -0500
Received: from mr14.vic-remote.bigpond.net.au ([24.192.1.29]:10946 "EHLO
	mr14.vic-remote.bigpond.net.au") by vger.kernel.org with ESMTP
	id <S132606AbQKDI2J>; Sat, 4 Nov 2000 03:28:09 -0500
Message-Id: <200011040827.TAA14095@mr14.vic-remote.bigpond.net.au>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
From: David Hammerton <dhammerton@labyrinth.net.au>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.4-test10: new wrapper.h brakes drivers
X-Mailer: Pronto v2.2.1
Date: 04 Nov 2000 03:27:58 EST
Reply-To: David Hammerton <dhammerton@labyrinth.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i just installed the latest kernel (2.4-test10).

On recompilation of my "Nvidia" kernel drivers (for geforce 2 3d video support
in linux), it failed linking to "mem_map_inc_count" (and dec_count).

Im not much of a programmer, but to get it working all i had to do was to add
to '/usr/src/linux/include/linux/wrapper.h':
/*the patch*/
#define mem_map_inc_count(p)    atomic_inc(&(p->count))
#define mem_map_dec_count(p)    atomic_dec(&(p->count))
/*end patch*/

yes, you'll notice i ripped this out of the older kernels..

good luck in finding an alternative, or just leave it in, or whatever.

cheers

David
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
