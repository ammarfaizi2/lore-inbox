Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129819AbQKZNBj>; Sun, 26 Nov 2000 08:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130192AbQKZNBT>; Sun, 26 Nov 2000 08:01:19 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:62419 "EHLO
        obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
        id <S129819AbQKZNBR>; Sun, 26 Nov 2000 08:01:17 -0500
Date: Sun, 26 Nov 2000 14:30:59 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: "Mr. Big" <mrbig@sneaker.sch.bme.hu>, linux-kernel@vger.kernel.org,
        rik@informatik.tu-chemnitz.de
Subject: readonly /proc/sys/vm/freepages (was: Re: PROBLEM: crashing kernels)
Message-ID: <20001126143059.M13759@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.3.96.1001124183828.385A-100000@sneaker.sch.bme.hu> <3A20501E.32EEB3C8@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A20501E.32EEB3C8@uow.edu.au>; from andrewm@uow.edu.au on Sun, Nov 26, 2000 at 10:49:50AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2000 at 10:49:50AM +1100, Andrew Morton wrote:
> You may also get some benefit from running:
> 
> # echo "512 1024 1536" > /proc/sys/vm/freepages
> 
> after booting.

... which is a NOOP on recent 2.4.0-testX-kernels. So please
complain at Rik for this (CC'ed him) ;-)

It's simply not that easy to set in the new VM since we count the
inactive_clean and/or inactive_dirty pages like free pages in
some cases.

> The default values are a little too low for
> applications which are very network intensive.

Especially for low memory machines, which are dedicated only for
this purpose. Many people use (embedded) Linux and a (embedded)
PC to cheaply fill functionality gaps in industrial environments.

Regards

Ingo Oeser
-- 
To the systems programmer, users and applications
serve only to provide a test load.
<esc>:x
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
