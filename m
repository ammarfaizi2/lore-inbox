Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbRAIOBo>; Tue, 9 Jan 2001 09:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbRAIOBZ>; Tue, 9 Jan 2001 09:01:25 -0500
Received: from rhlx01.fht-esslingen.de ([134.108.34.10]:46234 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id <S129741AbRAIOBP>; Tue, 9 Jan 2001 09:01:15 -0500
Date: Tue, 9 Jan 2001 15:01:11 +0100 (CET)
From: Nils Philippsen <nils@fht-esslingen.de>
Reply-To: <nils@fht-esslingen.de>
To: Felix Maibaum <f.maibaum@tu-bs.de>
cc: linux <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0 bug in SHM an via-rhine or is it my fault?
In-Reply-To: <3A5B170E.F48872A@tu-bs.de>
Message-ID: <Pine.LNX.4.30.0101091457330.8600-100000@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2001, Felix Maibaum wrote:

> My SHM stopped working!
> everything was fine in test12, and after that all I got was "no space
> left on device".
> Has anything changed that one should know about? I mounted shm like it's
> written in the help, and on a friends celeron SMP machine it works fine,
> I just don't know what I did wrong.

You used a buggy version of powertweak which set kernel.shmall to 0 in
/etc/sysctl.conf. Remove the offending line in /etc/sysctl.conf and either
reboot the machine or "echo 2097152 > /proc/sys/kernel/shmall".

Ciao,
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
