Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288732AbSA0VfO>; Sun, 27 Jan 2002 16:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288748AbSA0VfD>; Sun, 27 Jan 2002 16:35:03 -0500
Received: from zero.tech9.net ([209.61.188.187]:1796 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288732AbSA0Vev>;
	Sun, 27 Jan 2002 16:34:51 -0500
Subject: Re: [CFT] Bus mastering support for IDE CDROM audio
From: Robert Love <rml@tech9.net>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020127222551.B7548@suse.de>
In-Reply-To: <3C5119E0.6E5C45B6@zip.com.au>
	<1012166472.812.7.camel@phantasy>  <20020127222551.B7548@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 27 Jan 2002 16:40:16 -0500
Message-Id: <1012167617.1049.10.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-01-27 at 16:25, Jens Axboe wrote:

> sr already uses DMA for all transfers, so no performance gain was to be
> expected there. problem is ide-cd using pio for all packet command data
> transfers currently (modulo fs read write requests, of course)
> 
> not a whole lot of pio aic7xxx adapters out there :-)

Right.  The patch touches the generic cdrom driver, however, so Andrew
asked for testing with SCSI readers.  Thankfully it works; of course
performance didn't go up.

	Robert Love

