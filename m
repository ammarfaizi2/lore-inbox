Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271800AbRIRQxh>; Tue, 18 Sep 2001 12:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272983AbRIRQx1>; Tue, 18 Sep 2001 12:53:27 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10247 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271800AbRIRQxO>; Tue, 18 Sep 2001 12:53:14 -0400
Subject: Re: ext3/ext2 compatibility; time for ext3 in mainline kernel?
To: dank@kegel.com (Dan Kegel)
Date: Tue, 18 Sep 2001 17:57:51 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <3BA76A01.C2B5E701@kegel.com> from "Dan Kegel" at Sep 18, 2001 08:36:33 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15jOBz-0001FT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I installed Red Hat 7.2beta, and chose its nifty ext3 option when
> setting up my partitions.  But now when I boot into vanilla 2.4.9,
> some files are mysteriously missing, notably /usr/bin/id and
> /usr/lib/libreadline.so.3, judging from the error messages that spew
> when I try to do anything.
> 
> I guess either a) there's a bug, or b) ext3 isn't so compatible with ext2
> that you can just boot into an ext2-only kernel and expect things to work.

This should definitely work. If the journal has not been played back then
you may not be able to mount the fs as ext2. The case where it mounts as
ext2 but the journal is not played back or there are incompatibilities
showing is a bug.
