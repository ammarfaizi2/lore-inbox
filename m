Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbTK3TpF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 14:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbTK3TpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 14:45:04 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:58843 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262838AbTK3TpB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 14:45:01 -0500
Date: Sun, 30 Nov 2003 20:44:31 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jens Axboe <axboe@suse.de>, Vojtech Pavlik <vojtech@suse.cz>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Prakash K. Cheemplavam" <prakashkc@gmx.de>, marcush@onlinehome.de,
       linux-kernel@vger.kernel.org, eric_mudama@Maxtor.com
Subject: Re: Silicon Image 3112A SATA trouble
Message-ID: <20031130194431.GA21350@ucw.cz>
References: <3FCA1DD3.70004@pobox.com> <20031130165146.GY10679@suse.de> <200311301758.53885.bzolnier@elka.pw.edu.pl> <3FCA2380.1050902@pobox.com> <20031130171006.GA10679@suse.de> <20031130175649.GA18670@ucw.cz> <20031130181723.GD6454@suse.de> <3FCA34A6.3010600@pobox.com> <20031130182232.GF6454@suse.de> <3FCA3787.1000104@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FCA3787.1000104@pobox.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 01:31:35PM -0500, Jeff Garzik wrote:

> >Ah, my line wasn't completely clear (to say the least)... So to clear
> >all doubts:
> >
> >	if ((sector_count % 15 == 1) && (sector_count != 1))
> >		errata path
> >
> >Agree?
> 
> 
> Agreed.
> 
> 
> The confusion here is most likely my fault, as my original post 
> intentionally inverted the logic for illustrative purposes (hah!)...

Yeah, and there was an error in the inversion, since if you invert the
above statement, it looks like this:

if ((sector_count % 15 != 1) || (sector_count == 1))
	ok path
else
	errata path

Logic can be a bitch at times.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
