Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289675AbSAJVAL>; Thu, 10 Jan 2002 16:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289677AbSAJVAD>; Thu, 10 Jan 2002 16:00:03 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:24846 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289675AbSAJU7r>; Thu, 10 Jan 2002 15:59:47 -0500
Message-ID: <3C3DFF76.2DA2F5BD@zip.com.au>
Date: Thu, 10 Jan 2002 12:54:14 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matt Bernstein <matt@theBachChoir.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: oops with 2.4.17 + mini-ll patch
In-Reply-To: <Pine.LNX.4.43.0201101544330.31242-100000@nick.dcs.qmul.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Bernstein wrote:
> 
> Not sure if this is related to your patch (which looked harmless enough to
> me :), but here it is anyway.

mmm..  Probably coincidental.

> Dual PIII 1GHz, modular everything inc. ATA/IDE (VIA); SCSI (gdth.o);
> NFSv3 (udp, client only); autofs4; ext2 only for local fs. Debian woody.

It could be a timer deletion race.  There are still zillions of these,
but nobody ever encounters them.

What was the system doing at the time?  Do you think a module could
have been in the process of unloading?  autofs unmount, something
like that?

-
