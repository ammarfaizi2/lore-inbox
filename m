Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbQKPMEC>; Thu, 16 Nov 2000 07:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129875AbQKPMDl>; Thu, 16 Nov 2000 07:03:41 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:31454 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S129245AbQKPMDe>;
	Thu, 16 Nov 2000 07:03:34 -0500
Date: Thu, 16 Nov 2000 12:32:45 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200011161132.MAA26011@harpo.it.uu.se>
To: mikpe@csd.uu.se, viro@math.psu.edu
Subject: Re: 2.4.0-test10 truncate() change broke `dd'
Cc: aeb@veritas.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2000, Alexander Viro wrote:

> And what kind of meaning would you assign to truncate on floppy?

On a block or char device, truncate == lseek seems reasonable.

My guess is that dd uses ftruncate because that's correct for
regular files and has happened to also work (as an alias for
lseek) for devices.

> Use conv=notrunc.

I didn't know about notrunc. Yet another GNU invention?

/Mikael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
