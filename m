Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273302AbRIQAg0>; Sun, 16 Sep 2001 20:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273294AbRIQAgQ>; Sun, 16 Sep 2001 20:36:16 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58889 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273269AbRIQAgE>; Sun, 16 Sep 2001 20:36:04 -0400
Subject: Re: Disk errors and Reiserfs
To: hiryuu@envisiongames.net (Brian)
Date: Mon, 17 Sep 2001 01:40:36 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200109162329.f8GNTY918084@demai05.mw.mediaone.net> from "Brian" at Sep 16, 2001 07:29:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15imSi-00068f-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My issue, though, is Linux did not handle it well.  Userspace actually has 
> an 'EIO' error code for this situation but, instead, any program touching 
> the mounted partition hung in a D state.

Thats a reiserfs property and one you'll find in pretty much any other
fs.

> Is it possible for the kernel to handle this with enough grace that you 
> can kill the processes and unmount the partition?  (Thus allowing the box 
> to continue in a hobbled, but function manner.)  Failing that, is it 
> possible for the kernel to handle it well enough for 'shutdown' to cleanly 
> shutdown the box?

Killing the process isnt neccessary, its been halted in its tracks. As to
a clean shutdown - no chance. You've just hit a disk failure, the on disk
state is not precisely known, writes have been lost. Nothing is going to
make a clean shutdown possible under such circumstances.

Alan
