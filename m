Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129904AbRBCAM0>; Fri, 2 Feb 2001 19:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130450AbRBCAMQ>; Fri, 2 Feb 2001 19:12:16 -0500
Received: from jalon.able.es ([212.97.163.2]:2776 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129904AbRBCAL6>;
	Fri, 2 Feb 2001 19:11:58 -0500
Date: Sat, 3 Feb 2001 01:11:51 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Ken Moffat <ken@kenmoffat.uklinux.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Every Make option ends in error.
Message-ID: <20010203011151.G3014@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.21.0102022052090.31663-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.21.0102022052090.31663-100000@localhost.localdomain>; from ken@kenmoffat.uklinux.net on Fri, Feb 02, 2001 at 21:59:37 +0100
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.02 Ken Moffat wrote:
> Hi guys, 
>  I guess I'm doing something stupid, so please can somebody point it out
> and put me out of my misery ?
>  
>  Copied a plain 2.4.0 tree to a new directory, patched it to 2.4.1 without
> any errors. Then I realised it had all the object files from my last
> compile, so I thought "make mrproper" was called for. It did a little,
> then

Do a 'cp -a linux-2.4.0 linux-2.4.1', and symlinks (asm...) will not be
de-referenced.

Or even better, if you are going to patch, do a 'cp -rl', and your new
tree will not waste almost any space (hard-links all the files, so space
only is duplicated when patch changes some file - and if you remove the
old kernel tree, the space just goes to the new).

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-ac1 #2 SMP Fri Feb 2 00:19:04 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
