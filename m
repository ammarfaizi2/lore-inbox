Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267938AbRGZNXp>; Thu, 26 Jul 2001 09:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267947AbRGZNXZ>; Thu, 26 Jul 2001 09:23:25 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:26386 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S267938AbRGZNXP>; Thu, 26 Jul 2001 09:23:15 -0400
Date: Thu, 26 Jul 2001 10:23:07 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <20010726151749.M17244@emma1.emma.line.org>
Message-ID: <Pine.LNX.4.33L.0107261020570.20326-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, 26 Jul 2001, Matthias Andree wrote:
> On Thu, 26 Jul 2001, Rik van Riel wrote:
>
> > In fact, knowing how hard disks work mechanically, only
> > journaling filesystems could have an extention to make
> > this work.  Ie. this is NOT something you can rely on ;)
>
> This is not about failing hard disks. It is about premature
> acknowledgment of something which has not happened at that time.

So you didn't read what I was writing.

Let me explain it to you slowly:

Disks.  Write.  One.  Write.  At.  A.  Time.

A rename often needs as many as 4 or 5 writes,
ergo, you CANNOT do a rename atomically without
journaling and transactions.

> The competition is there and it has names: BSD + ufs + softupdates,
> Solaris + logging ufs. Read MTA mailing lists before obstructing.

BSD + softupdates is physically incapable of doing what
you suggest it does.  This can be proven from the lack
of transactions and the way hard disks work physically.

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

