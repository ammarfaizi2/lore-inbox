Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131689AbRACCKW>; Tue, 2 Jan 2001 21:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131943AbRACCKM>; Tue, 2 Jan 2001 21:10:12 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:6148 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S131689AbRACCKK>; Tue, 2 Jan 2001 21:10:10 -0500
Date: Wed, 3 Jan 2001 01:37:31 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Daniel Stone <daniel@kabuki.eyep.net>, Elmer Joandi <elmer@ylenurme.ee>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Compile errors: RCPCI, LANE, and others
In-Reply-To: <E14DVBT-0002YO-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0101030136240.1221-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2001, Alan Cox wrote:

> > > i2o_block.c:595: warning: #warning "RACE"
> > this is most likely a bad thing, yes.
>
> Yeah its to remind me to fix a small race

If preferred the alternative approach to this:

	if (!current->lock_depth)
		BUG();

in sleep_on().

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
