Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278450AbRJaM60>; Wed, 31 Oct 2001 07:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280188AbRJaM6Q>; Wed, 31 Oct 2001 07:58:16 -0500
Received: from chiark.greenend.org.uk ([195.224.76.132]:10770 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id <S278450AbRJaM6F>; Wed, 31 Oct 2001 07:58:05 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <wwvn128dkzj.fsf@rjk.greenend.org.uk>
Date: Wed, 31 Oct 2001 12:58:40 +0000
X-Face: h[Hh-7npe<<b4/eW[]sat,I3O`t8A`(ej.H!F4\8|;ih)`7{@:A~/j1}gTt4e7-n*F?.Rl^
     F<\{jehn7.KrO{!7=:(@J~]<.[{>v9!1<qZY,{EJxg6?Er4Y7Ng2\Ft>Z&W?r\c.!4DXH5PWpga"ha
     +r0NzP?vnz:e/knOY)PI-
X-Boydie: NO
From: Richard Kettlewell <rjk@greenend.org.uk>
To: <linux-kernel@vger.kernel.org>
Subject: Re: problem with ide-scsi and IDE tape drive
In-Reply-To: <Pine.LNX.4.33.0110311347580.3081-100000@kai.makisara.local>
In-Reply-To: <wwvady8vhfs.fsf@rjk.greenend.org.uk>
	<Pine.LNX.4.33.0110311347580.3081-100000@kai.makisara.local>
X-Mailer: VM 6.92 under 21.4 (patch 1) "Copyleft" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Makisara writes:

> Looking at your log everything seems to work perfectly from the
> point of view of the drivers. The problem is that the first write
> command (from the log cmd: a 1 0 0 3c 0 Len: 30720) is refused by
> your drive (the sense key Illegal Request). The command looks OK
> (i.e., it is a write of 60 512 byte blocks in fixed block mode).

OK...

> Does your drive only accept writes from the beginning of the tape
> (there are drives that have this limitation)?

The manual doesn't mention any such limitation, but it's not very
comprehensive.  Suggestions how I can find out whether the drive is
supposed to support arbitrarily positioned writes or not would be
welcome.

> In this case the problem is that you rewind and space forward
> between the two tar commands. You don't have to rewind between the
> commands. The same result is obtained if you just use two
> consecutive tar commands (and this means that writing only starts
> from the beginning of the tape, from the drive's point of view).

This points to an acceptable workaround.

Thanks for your help!

ttfn/rjk
