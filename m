Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLYBrY>; Sun, 24 Dec 2000 20:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbQLYBrP>; Sun, 24 Dec 2000 20:47:15 -0500
Received: from oracle.clara.net ([195.8.69.94]:12300 "EHLO oracle.clara.net")
	by vger.kernel.org with ESMTP id <S129228AbQLYBrJ>;
	Sun, 24 Dec 2000 20:47:09 -0500
Date: Mon, 25 Dec 2000 01:13:41 +0000 (GMT)
From: Dave Gilbert <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org
Subject: shmat returning NULL with 0 sized segment
Message-ID: <Pine.LNX.4.10.10012250109450.666-100000@tardis.home.dave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I'm trying to debug a weird problem with Xine - its screwing up its use
of shared memory for regions I haven't sussed yet.  One odd consequence is
that it has apparently successfully managed to allocate a 0 byte chunk of
shared memory; shmat is then called with shmaddr=0 and shmflg=0; the
result of shmat is 0

  Is this what shmat is supposed to do in this (admittedly odd)
circumstance? The error behaviour is defined in the man page as returning
-1 on error.

(Linux/Alpha 2.4.0-test8)

Back to trying to find out why it decided to allocate a  0 byte chunk....

Dave


-- 
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert      | Running GNU/Linux on       |  Happy  \ 
\   gro.gilbert @ treblig.org |  Alpha, x86, ARM and SPARC |  In Hex /
 \ ___________________________|___ http://www.treblig.org  |________/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
