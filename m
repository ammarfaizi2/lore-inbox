Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319434AbSIGA6E>; Fri, 6 Sep 2002 20:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319435AbSIGA6E>; Fri, 6 Sep 2002 20:58:04 -0400
Received: from epithumia.math.uh.edu ([129.7.128.2]:3303 "EHLO
	epithumia.math.uh.edu") by vger.kernel.org with ESMTP
	id <S319434AbSIGA6E>; Fri, 6 Sep 2002 20:58:04 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: ide drive dying?
References: <0d2bf5139200692DTVMAIL9@smtp.cwctv.net>
	<1031346090.10612.90.camel@irongate.swansea.linux.org.uk>
From: Jason L Tibbitts III <tibbs@math.uh.edu>
Date: 06 Sep 2002 20:02:43 -0500
In-Reply-To: Alan Cox's message of "06 Sep 2002 22:01:29 +0100"
Message-ID: <ufaadmuzk5o.fsf@epithumia.math.uh.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "AC" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

AC> Thats up to the owner. There are lots of uses for such drives -
AC> /tmp, swap, in a raid array, etc

Be careful of these even in a RAID array; they will go bad silently.
I had one array (software RAID5, 8 75GXP drives on a 3w6800 in JBOD
mode, one hot spare) that was going fine until one drive died hard,
wouldn't spin up, etc.  I replaced it, but during the RAID resync
three other drives were found to have errors.  The array was trash,
but luckily all drives were dead just at the tail end, so I could copy
the data out during the RAID resync.  Some of the failed drives had
the updated firmware.

3ware has background integrity scans now; I don't know if software
RAID has any equivalent besides an occasional 'dd', but even that's a
good idea.

 - J<
