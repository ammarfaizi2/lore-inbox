Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273578AbRIQMIP>; Mon, 17 Sep 2001 08:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273579AbRIQMIF>; Mon, 17 Sep 2001 08:08:05 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27404 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273578AbRIQMIC>; Mon, 17 Sep 2001 08:08:02 -0400
Subject: Re: [PATCH] lazy umount (1/4)
To: matthias.andree@stud.uni-dortmund.de (Matthias Andree)
Date: Mon, 17 Sep 2001 13:13:08 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010917120428.A13815@emma1.emma.line.org> from "Matthias Andree" at Sep 17, 2001 12:04:28 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ixGu-0006ym-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, from a practical point of view two things that would really help
> Linux:
> 
> 1) Be able kill -9 processes from "D" state.

Wont happen. 

> 2) Force unmount busy file systems and kill -9 all related processes.

umount -f

> down, there is ABSOLUTELY NO WAY of getting rid of the mounts besides
> losing unrelated data (i. e. unmount in background, killall -9 rpciod -
> will possibly lose data written to other servers).

umount -f. 

> Now, then the server is back up and I unmounted the old beast, I need to
> be able to remount that file system without reboot. Looks like a deeply
> sleeping (state == 'D') process might prevent that, and that'd render
> the whole good idea no good.

Not with the lazy mount stuff

> ago, just because it does umount -f and Linux' ever-rising load with
> stuck processes really annoys me and has brought one of my production
> machines down more than once. Soft NFS mounts are not really an option.

The 'D' state stuff is not "load" - it didn't bring your box down, something
else did. Its reported as uptime so the stick your finger in their and guess
three magic numbers overall load view reflects I/O load. It and D state go
back to the earliest days of Unix and the same issues occur in any OS

Alan

