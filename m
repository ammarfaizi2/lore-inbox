Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311575AbSDOKO0>; Mon, 15 Apr 2002 06:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311879AbSDOKOZ>; Mon, 15 Apr 2002 06:14:25 -0400
Received: from hera.cwi.nl ([192.16.191.8]:55938 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S311575AbSDOKOZ>;
	Mon, 15 Apr 2002 06:14:25 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 15 Apr 2002 10:14:14 GMT
Message-Id: <UTC200204151014.KAA639446.aeb@cwi.nl>
To: Andries.Brouwer@cwi.nl, axboe@suse.de
Subject: Re: IDE / SmartMedia
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
        mdharm@one-eyed-alien.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	From axboe@brick.kernel.dk Mon Apr 15 10:05:40 2002

	-			drive->using_tcq = 1;

That helps, I think.

The first boot after deleting this line again crashed,
but this time with BUG() in <linux/usb.h>.
All usb stuff was compiled in except for usb-storage,
which was a module and not loaded.

Maybe a race somewhere. The second boot all was fine.

Andries
