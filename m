Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263748AbRG0V1q>; Fri, 27 Jul 2001 17:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264244AbRG0V1g>; Fri, 27 Jul 2001 17:27:36 -0400
Received: from weta.f00f.org ([203.167.249.89]:2438 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S263748AbRG0V1R>;
	Fri, 27 Jul 2001 17:27:17 -0400
Date: Sat, 28 Jul 2001 09:27:50 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Michal Jaegermann <michal@harddata.com>, linux-kernel@vger.kernel.org
Subject: Re: Strange remount behaviour with ext3-2.4-0.9.4
Message-ID: <20010728092750.A1696@weta.f00f.org>
In-Reply-To: <E15QF5E-0006ZL-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15QF5E-0006ZL-00@the-village.bc.nu>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, Jul 27, 2001 at 10:23:44PM +0100, Alan Cox wrote:

    You dont want r/w snapshots for archiving. An archive of a
    previous date is worthless if it can't be absolutely utterly and
    definitively read only.

sure, for archiving you don't, but for other purposes you might

RO is easier and what most people want, this is all WAFL gives right now

RW has it's uses too, especially if you can clone /foo/bar to
/foo/blem and such like, a cheaper more elegant way of cp -Rupdl I
guess

    It is hard to do well, but its an important item. One possiiblity
    is to do it by replaying the log to a r/w snapshot (in ram) over a
    r/o snapshot (on stable media)

you can probably get away without the need for replay... just build
and in-memory extent list of blocks to would otherwise have been
rewritten and the journal offsets, before you read a block, you check
to see if you need to get from journal first

obviously you need to make sure you get the last insatce of each block
in the journal should there be more than one



  --cw
