Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265567AbTAJQkH>; Fri, 10 Jan 2003 11:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265532AbTAJQkH>; Fri, 10 Jan 2003 11:40:07 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:25244 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265567AbTAJQkF>;
	Fri, 10 Jan 2003 11:40:05 -0500
Date: Fri, 10 Jan 2003 17:48:34 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>
Cc: fverscheure@wanadoo.fr,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Problem in IDE Disks cache handling in kernel 2.4.XX
Message-ID: <20030110164834.GM843@suse.de>
References: <Pine.LNX.4.10.10301100502450.31168-100000@master.linux-ide.org> <1042207998.28469.98.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042207998.28469.98.camel@irongate.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10 2003, Alan Cox wrote:
> On Fri, 2003-01-10 at 13:03, Andre Hedrick wrote:
> > Oh, just let the darn thing barf a 0x51/0x04 is fine with me!
> > Just an abort/unsupported command.
> 
> Sounds ok to me. We do need a barfsupressor option so we can issue
> commands that may fail without confusing the user (eg multiwrite setup)
> 
> ie
> 	ide_hwif_barfsupress(hwif);
> 	ide_command....
> 
> That's very much true irrespective of the flush thing

In the barrier patches, I just used drive->quiet to supress ide_error()
complaining too much (on cache flushes, too). Whether that's per-drive
of per-hwif entity, dunno...

-- 
Jens Axboe

