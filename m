Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132794AbRAHKrW>; Mon, 8 Jan 2001 05:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135621AbRAHKrK>; Mon, 8 Jan 2001 05:47:10 -0500
Received: from rhlx01.fht-esslingen.de ([134.108.34.10]:53070 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id <S132794AbRAHKrG>; Mon, 8 Jan 2001 05:47:06 -0500
Date: Mon, 8 Jan 2001 11:46:05 +0100 (CET)
From: Nils Philippsen <nils@fht-esslingen.de>
Reply-To: <nils@fht-esslingen.de>
To: Narancs 1 <narancs1@externet.hu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: postgres/shm problem
In-Reply-To: <Pine.LNX.4.02.10101081110001.1837-100000@prins.externet.hu>
Message-ID: <Pine.LNX.4.30.0101081142090.8952-100000@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 8 Jan 2001, Narancs 1 wrote:

> Lots of things may have changed in 2.4.0-prer., because nor cdrecord
> neither postgressql do not run because of system v ipc / shm problem.
> After recompiling cdrecord with the new header files, started working.
> I'm just recompiling postgres too.
>
> /var/log/postgresql.log:
>
> 010102.10:45:09.448   [627] IpcMemoryCreate: shmget failed (No space left
> on device) key=5432010, size=144, permission=700
> This type of error is usually caused by an improper
> shared memory or System V IPC semaphore configuration.

I had the same problem on my machine and it stemmed from accidentally setting
/proc/sys/kernel/shmall to "0" (that is the maximum number of SHM segments).
In my cas I used some /psoc/sys tweaking utility at a time where this value
was unknown (other kernel) and that utility then set kernel.shmall in
/etc/sysctl.conf to 0. You might check that.

Nils
-- 
 Nils Philippsen / Berliner Straﬂe 39 / D-71229 Leonberg // +49.7152.209647
nils@wombat.dialup.fht-esslingen.de / nils@fht-esslingen.de / nils@redhat.de
   The use of COBOL cripples the mind; its teaching should, therefore, be
   regarded as a criminal offence.                  -- Edsger W. Dijkstra

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
