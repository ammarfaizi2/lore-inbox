Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129752AbRCASR0>; Thu, 1 Mar 2001 13:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129753AbRCASRP>; Thu, 1 Mar 2001 13:17:15 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:35086 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129752AbRCASQ7>; Thu, 1 Mar 2001 13:16:59 -0500
Subject: Re: fat problem in 2.4.2
To: gator@cs.tu-berlin.de
Date: Thu, 1 Mar 2001 18:19:35 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0103011502050.23650-100000@swamp.bayern.net> from "Peter Daum" at Mar 01, 2001 03:25:29 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14YXft-0008GK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In that case, why was it changed for FAT only? Ext2 will still
> happily enlarge a file by truncating it.

ftruncate() and truncate() may extend a file but they are not required to
do so.

> If the behavior has to be changed, wouldn't it be better to first
> give people a chance to get programs, that rely on the old
> behavior fixed, before enforcing the change?

A program relying on the old behaviour was violating standards. Also its been
this way for almost two years.

> Staroffice (the binary-only version; the new "open source"
> version is not yet ready for real-world use) for example
> currently doesn't write to FAT filesystems anymore - which is
> pretty annoying for people who need it.
> 
> Is there somewhere a patch for the current kernel?

You might be able to fish it out of old -ac kernel trees and debug it further.
Alternatively you could implement it in glibc of course, which is a nicer
solution

