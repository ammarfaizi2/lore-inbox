Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267331AbTAGHsr>; Tue, 7 Jan 2003 02:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267332AbTAGHsr>; Tue, 7 Jan 2003 02:48:47 -0500
Received: from dialup-102.199.220.203.acc01-alma-roc.comindico.com.au ([203.220.199.102]:17281
	"EHLO big.net.au") by vger.kernel.org with ESMTP id <S267331AbTAGHsq>;
	Tue, 7 Jan 2003 02:48:46 -0500
Date: Tue, 7 Jan 2003 17:29:08 +1100
From: Silvio Cesare <silvio@big.net.au>
To: linux-kernel@vger.kernel.org
Subject: suggestion.. check for read/write/size/TASK_SIZE in kernel segment (early on) ?
Message-ID: <20030107062908.GA5793@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.. I'm not sure if this is valid or not (or is compliant with everything),
but it seems like a reasonable suggestion IMO.

In read/write system call, check that the read/write buffer address
resides not in the kernel segment.  ie, check buffer address and TASK_SIZE,
address + size etc..

That may seem silly.. but it would stop any later problems by drivers
which dont check this themselves, or handle it incorrectly or inconsistantly..

1) clear security integrity check (so drivers etc are less worried)
2) clearly defined behaviour (error codes etc) when this occurs (easier
   on the drivers again).

If its not possible to do this in the system call directly any chance of
putting such a check early on in the generic driver code present?
perhaps the buffer in read/write means something other than a userspace
buffer/array, to someone, but i cant think of any read/write behaviour to
counter-claim this..

perhaps a dumb suggestion.. open to feedback :)

--
Silvio
