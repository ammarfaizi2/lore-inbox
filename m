Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132540AbREEOjk>; Sat, 5 May 2001 10:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132567AbREEOja>; Sat, 5 May 2001 10:39:30 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29714 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132540AbREEOjN>; Sat, 5 May 2001 10:39:13 -0400
Subject: Re: Athlon and fast_page_copy: What's it worth ? :)
To: chromi@cyberspace.org (Jonathan Morton)
Date: Sat, 5 May 2001 15:41:41 +0100 (BST)
Cc: hahn@coffee.psychology.mcmaster.ca (Mark Hahn),
        bergsoft@home.com (Seth Goldberg), linux-kernel@vger.kernel.org
In-Reply-To: <l03130306b719ba7ef592@[192.168.239.105]> from "Jonathan Morton" at May 05, 2001 03:19:15 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14w3Ff-0000iz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My wild guess is that with the "faster" code, the K7 is avoiding loading
> cache lines just to write them out again, and is just writing tons of data.
> The PPC G4 - and perhaps even the G3 - performs a similar trick
> automatically, without special assembly...

X86 has done that since the K5 era. 

No the main thing that the mmx copier does is to read and write in 64bit
wide chunks, and then more importantly to prefetch pending data. Thus instead
of stalling on reads there is a continual stream of data from the sdram hitting
the cpu ready for us to write it back out (and the write out is buffered too)

Alan

