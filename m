Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277739AbRJLPzU>; Fri, 12 Oct 2001 11:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277750AbRJLPzL>; Fri, 12 Oct 2001 11:55:11 -0400
Received: from soul.helsinki.fi ([128.214.3.1]:63748 "EHLO soul.helsinki.fi")
	by vger.kernel.org with ESMTP id <S277742AbRJLPyz>;
	Fri, 12 Oct 2001 11:54:55 -0400
Date: Fri, 12 Oct 2001 18:55:25 +0300 (EET DST)
From: Mikael Johansson <mpjohans@pcu.helsinki.fi>
To: <linux-kernel@vger.kernel.org>
Subject: (memory?) bug between 2.4.9-ac10 and -ac14
In-Reply-To: <20011012083616.C9992@cpe-24-221-152-185.az.sprintbbd.net>
Message-ID: <Pine.OSF.4.30.0110121841270.13202-100000@soul.helsinki.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello All!

A bug report which seems related to at least memory management:

If becoming root and then su:ing some other, non-local, userid, an oops
with segfault is the outcome. Non-local here means that the user info is
located on another machine, our server. su:ing the dummy local user
seems to work OK.

I remember the new shell being the process that oopses, but can't
unfortunately get the output (other than "segmentation fault") before
Monday as the machine is behind locked doors :-/

Anyway, this occurs if I boot the machine with the full 1.5GB of memory,
but _not_ if I specify mem=512M in lilo.conf, so there seems to be some
sort of "large memory support" issue.

The system is fine with 2.4.9-ac10, and unfine with these (all I've
tested): ac-14, ac-15, ac-18.

I can get more detailed info on Monday, but thought that maybe someone has
come across this before.

Brief system specs:
Athlon 1.4GHz
Abit KT7A (with Athlon/VIA-bug)
3x512MB SDRAM
2x40GB => RAID-0

Have a nice day,
    Mikael J.

