Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129911AbRBMXbe>; Tue, 13 Feb 2001 18:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130212AbRBMXbY>; Tue, 13 Feb 2001 18:31:24 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:42508 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129911AbRBMXbO>; Tue, 13 Feb 2001 18:31:14 -0500
Subject: Re: Stale NFS handles on 2.4.1
To: jakob@unthought.net (Jakob Østergaard)
Date: Tue, 13 Feb 2001 23:31:50 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010214002750.B11906@unthought.net> from "Jakob Østergaard" at Feb 14, 2001 12:27:50 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SovJ-0003H1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The NFS clients are getting
>  "Stale NFS handle"
> messages every once in a while which will make a "touch somefile.o"
> fail.

If they have the previous .o handle cached and it was removed on another
client thats quite reasonable behaviour. NFS isnt coherent

> It's quite annoying and I didn't see it on 2.2 even after the NFS
> patches were integrated.

I wonder if its because 2.4 runs faster and caches better 8). You can
tune the attribute cache times that may help. Are we talking 30 second
intervals here or stuff being cached for far too long (which would imply a bug)

