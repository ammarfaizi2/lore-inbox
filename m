Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129677AbRAaXPm>; Wed, 31 Jan 2001 18:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129695AbRAaXPd>; Wed, 31 Jan 2001 18:15:33 -0500
Received: from hera.cwi.nl ([192.16.191.8]:60572 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129677AbRAaXPX>;
	Wed, 31 Jan 2001 18:15:23 -0500
Date: Thu, 1 Feb 2001 00:15:15 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200101312315.AAA19635.aeb@vlet.cwi.nl>
To: mlord@pobox.com, rupa-list+linux-kernel@rupa.com
Subject: Re: Problems with Promise IDE controller under 2.4.1
Cc: Andries.Brouwer@cwi.nl, andre@linux-ide.org, linux-kernel@vger.kernel.org,
        ole@linpro.no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord writes:

> Even better would be to add a stage in front of the fall-back,
> which queries the BIOS (from kernel startup code) for translation
> info on ALL drives.

It doesn't work.
I wrote the code and asked people to test it.
So many BIOS quirks.

(Numbering of drives depends on setup options, and on whether
there are SCSI disks mentioned in the BIOS setup,
there are off-by-one errors in several BIOSes,
several versions of Phoenix extensions are implemented etc.
It is really not worth trying to go this way. It fails.)

No, geometry does not exist, and also BIOS drivers have come
to the same conclusion.

Since nothing depends on it, there is no reason to want
any geometry in particular.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
