Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265541AbTAJRRa>; Fri, 10 Jan 2003 12:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265564AbTAJRRa>; Fri, 10 Jan 2003 12:17:30 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:59794
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265541AbTAJRR2>; Fri, 10 Jan 2003 12:17:28 -0500
Subject: Re: Problem in IDE Disks cache handling in kernel 2.4.XX
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Andre Hedrick <andre@linux-ide.org>, fverscheure@wanadoo.fr,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <20030110164834.GM843@suse.de>
References: <Pine.LNX.4.10.10301100502450.31168-100000@master.linux-ide.org>
	 <1042207998.28469.98.camel@irongate.swansea.linux.org.uk>
	 <20030110164834.GM843@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042222339.32175.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 10 Jan 2003 18:12:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-10 at 16:48, Jens Axboe wrote:
> In the barrier patches, I just used drive->quiet to supress ide_error()
> complaining too much (on cache flushes, too). Whether that's per-drive
> of per-hwif entity, dunno...

Commands are queued per hwif so it doesn't actually matter I suspect.

BTW do you plan to fix up the oopses in the tcq code or should I just mark
it disabled for anyone who has the time to finish the job ? There are a 
whole pile of drivers that fail with tcq - mostly because they have custom
dma end functions


