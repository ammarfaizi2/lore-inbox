Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbTEKNeS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 09:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbTEKNeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 09:34:18 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:64712 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261358AbTEKNeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 09:34:18 -0400
Date: Sun, 11 May 2003 15:46:56 +0200
From: Jens Axboe <axboe@suse.de>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 and ide-floppy errors
Message-ID: <20030511134656.GL837@suse.de>
References: <20030511124233.GB10013@ulima.unil.ch> <Pine.SOL.4.30.0305111445100.4788-100000@mion.elka.pw.edu.pl> <20030511125243.GK837@suse.de> <20030511131557.GA10688@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030511131557.GA10688@ulima.unil.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 11 2003, Gregoire Favre wrote:
> On Sun, May 11, 2003 at 02:52:43PM +0200, Jens Axboe wrote:
> 
> > Correct, that needs a check. It should work, but is far from optimal
> > both from the software and hardware point of view... So I'd much rather
> > just keep TCQ enabled only on a single drive on a channel. That way I
> > don't have to deal with the ide tcq stupidities.
> 
> 
> Well, I don't know if it's better without TCQ:
> 
> May 11 15:12:39 localhost kernel: hdb: DMA interrupt recovery
> May 11 15:12:39 localhost kernel: hdb: lost interrupt
> May 11 15:14:02 localhost kernel: hdb: DMA interrupt recovery
> May 11 15:14:02 localhost kernel: hdb: lost interrupt

It smells fishy. Does the zip usually work as slave with that drive as
master? IOW, what is your typical working config (kernel)?

-- 
Jens Axboe

