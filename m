Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284823AbRLLBNH>; Tue, 11 Dec 2001 20:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284831AbRLLBMu>; Tue, 11 Dec 2001 20:12:50 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8201 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284823AbRLLBMf>; Tue, 11 Dec 2001 20:12:35 -0500
Subject: Re: SV: Lockups with 2.4.14 and 2.4.16
To: johan@ekenberg.se (Johan Ekenberg)
Date: Wed, 12 Dec 2001 01:22:03 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <000c01c182a7$d3a093b0$050010ac@FUTURE> from "Johan Ekenberg" at Dec 12, 2001 01:56:26 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Dy5z-0007h8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BTW, these commands don't work over SSH, ie the '&' doesn't produce a
> background job + report-when-finished when running like:
>    ssh badserver "touch /foo &"
> If I run without '&', would that just touch a file somewhere in the
> cache-memory, ie not flushed to disk, or would it still detect if a disk is
> hung? What's the point of running it in the bg anyway?

I was thinking "from a shell". Doing it with two ssh commands should show 
which one if either hangs

> Is there any chance the lockup could be with one of the IDE disks running
> swap or backups? Could that produce a global lockup of this kind?

I think its a reiserfs/quota/dac960 deadlock though which is open to
question at the moment
