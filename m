Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262808AbSLUST6>; Sat, 21 Dec 2002 13:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262812AbSLUST6>; Sat, 21 Dec 2002 13:19:58 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:23272 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262808AbSLUST5>;
	Sat, 21 Dec 2002 13:19:57 -0500
Date: Sat, 21 Dec 2002 19:27:47 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: John Reiser <jreiser@BitWagon.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, AnonimoVeneziano <voloterreno@tin.it>,
       Patrick Petermair <black666@inode.at>,
       Roland Quast <rquast@hotshed.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: vt8235 fix, hopefully last variant
Message-ID: <20021221192747.A30919@ucw.cz>
References: <20021219112640.A21164@ucw.cz> <3E04AB96.5030408@BitWagon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E04AB96.5030408@BitWagon.com>; from jreiser@BitWagon.com on Sat, Dec 21, 2002 at 09:57:42AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 21, 2002 at 09:57:42AM -0800, John Reiser wrote:

> Looking at the important piece:
> -----
> > +	/* Always use 4 address setup clocks on ATAPI devices */
> > +	if (drive->media != ide_disk)
> > +		t.setup = 4;
> -----
> it seems to me that using 4 for t.setup also should be done unless _all_ devices
> on that cable are ide_disk.  In particular, if one device is ide_disk but the
> other is not, then "t.setup = 4;" should be used even when talking to the ide_disk.
> Otherwise the non-ide_disk device might get confused, respond when it should not,
> and garble the transaction.  Or, is such a bad thing prevented in some other way?

Good idea.

-- 
Vojtech Pavlik
SuSE Labs
