Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319388AbSIFUwG>; Fri, 6 Sep 2002 16:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319392AbSIFUwF>; Fri, 6 Sep 2002 16:52:05 -0400
Received: from [195.39.17.254] ([195.39.17.254]:7808 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S319388AbSIFUwE>;
	Fri, 6 Sep 2002 16:52:04 -0400
Date: Fri, 6 Sep 2002 10:09:33 +0000
From: Pavel Machek <pavel@suse.cz>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
Subject: Re: writing OOPS/panic info to nvram?
Message-ID: <20020906100933.E35@toy.ucw.cz>
References: <E471FA7E-C00E-11D6-A20D-000393911DE2@sara.nl> <20020904140856.GA1949@werewolf.able.es> <1031149539.2788.120.camel@irongate.swansea.linux.org.uk> <20020904144154.GE1949@werewolf.able.es> <20020904144938.GA1106@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020904144938.GA1106@marowsky-bree.de>; from lmb@suse.de on Wed, Sep 04, 2002 at 04:49:38PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Ah, ther is no way to write raw blocks at a very low level to disk...??
> 
> Not reliably; you _know_ your infrastructure has crashed, otherwise you
> wouldn't be inside the crash dump handler ;), so you can't possibly trust the
> normal block layer to write the crash dump (and not write it over your salary
> and customer database).

Floppy seems like safe choice. Verify its special "crash floppy" by checking
signature, then write.

> A network dump is much safer, though I would suggest running it over a
> dedicated card / driver combo and on a special ethernet protocol, because you
> might have lost your IP configuration...

Its enough for it to work 99% cases. Separate ethernet card is overkill,
serial console is easier than that.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

