Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264026AbSIQKZs>; Tue, 17 Sep 2002 06:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264034AbSIQKZs>; Tue, 17 Sep 2002 06:25:48 -0400
Received: from 62-190-217-132.pdu.pipex.net ([62.190.217.132]:18182 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S264026AbSIQKZs>; Tue, 17 Sep 2002 06:25:48 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209171037.g8HAbuIf001453@darkstar.example.net>
Subject: Re: Heuristic readahead for filesystems
To: jdow@earthlink.net (jdow)
Date: Tue, 17 Sep 2002 11:37:56 +0100 (BST)
Cc: jw@pegasys.ws, linux-kernel@vger.kernel.org
In-Reply-To: <02f401c25deb$e5f87bc0$1125a8c0@wednesday> from "jdow" at Sep 16, 2002 06:45:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Well they could read contiguous sectors if the sector interleave
> > was correctly determined and the correct interleave was set
> > while low-level formatting. Now-days, interleave is either ignored
> > or unavailable because there is a sector buffer that can contain
> > an entire track of data. Some SCSI drives have sector buffers
> > that can contain a whole cylinder of data.
> 
> When I say contiguous I mean contiguous not interleaved, sonny. I had
> CP/M (and UCSD Pascal) reading physically contiguous sectors on the
> disk with no lost speed. That means I read, with my DSSD format of
> 9 sectors each 512 bytes in size per side 18 full tracks 19 revolutions
> of the disk. I did skew the sector numbers to allow for seeks. But I
> did not interleave the tracks. It was not necessary with clean and
> correct code. I rather resent the presumption that I am a dumb bitch
> here.

Ah, but the *really* clever thing to do at the time, on systems where you couldn't optimally achieve 1:1 interleave on a floppy, was to allocate sectors on alternating sides of the disk.  So, you could, for example, read two tracks in 3 revolutions, instead of 6, in the case of 3:1 interleave :-).

John.
