Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135765AbRAHLsc>; Mon, 8 Jan 2001 06:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136448AbRAHLsW>; Mon, 8 Jan 2001 06:48:22 -0500
Received: from rhlx01.fht-esslingen.de ([134.108.34.10]:35754 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id <S135765AbRAHLsG>; Mon, 8 Jan 2001 06:48:06 -0500
Date: Mon, 8 Jan 2001 12:47:26 +0100 (CET)
From: Nils Philippsen <nils@fht-esslingen.de>
Reply-To: <nils@fht-esslingen.de>
To: Narancs 1 <narancs1@externet.hu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: postgres/shm problem
In-Reply-To: <Pine.LNX.4.02.10101081222211.17427-100000@prins.externet.hu>
Message-ID: <Pine.LNX.4.30.0101081243530.8952-100000@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, Narancs 1 wrote:

> On Mon, 8 Jan 2001, Nils Philippsen wrote:
>
>
> > /proc/sys/kernel/shmall to "0" (that is the maximum number of SHM
> > segments).
> yes, powertweak made it wrong. what is the good value for it?

according to /usr/src/linux/include/linux/shm.h:

#define SHMALL (SHMMAX/PAGE_SIZE*(SHMMNI/16)) /* max shm system wide (pages)
*/

On my machine here, it is 2097152. It should be the same on any Intel IA32
compatible machine. To be safe, remove the value from /etc/sysctl.conf and
reboot the machine ;-).

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
