Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291794AbSBNRZj>; Thu, 14 Feb 2002 12:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291797AbSBNRZ3>; Thu, 14 Feb 2002 12:25:29 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9221 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291794AbSBNRZO>; Thu, 14 Feb 2002 12:25:14 -0500
Subject: Re: fsync delays for a long time.
To: moibenko@fnal.gov (Alexander Moibenko)
Date: Thu, 14 Feb 2002 17:39:12 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SGI.4.31.0202140951330.3076325-100000@fsgi03.fnal.gov> from "Alexander Moibenko" at Feb 14, 2002 10:03:57 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16bPqi-0000c5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> run my gdbm application and bonnie test on the same device.
> When gdbm comes to the point when it calls fsync it delays for a long
> time.

fsync on a very large file is very slow on the 2.2 kernels

> result. IDE is even worse in our case. In the discussion it was also said
> that fsync for 2.4.x is modified. But does it fix a problem?

2.4 is a lot smarter about flushing only the things it needs to. That
makes it dependant on the number of blocks to write not some embarrasingly
large power of the file size


