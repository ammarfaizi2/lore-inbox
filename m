Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292859AbSCISiC>; Sat, 9 Mar 2002 13:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292856AbSCIShw>; Sat, 9 Mar 2002 13:37:52 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25865 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292851AbSCIShp>; Sat, 9 Mar 2002 13:37:45 -0500
Subject: Re: gettimeofday() system call timing curiosity
To: pjd@fred001.dynip.com
Date: Sat, 9 Mar 2002 18:51:19 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), root@chaos.analogic.com,
        johan.adolfsson@axis.com, lk@tantalophile.demon.co.uk (Jamie Lokier),
        hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org,
        terje.eggestad@scali.com (Terje Eggestad),
        greearb@candelatech.com (Ben Greear),
        davidel@xmailserver.org (Davide Libenzi),
        george@mvista.com (george anzinger)
In-Reply-To: <200203090303.g29332R14018@fred.cambridge.ma.us> from "pjd@fred.cambridge.ma.us" at Mar 08, 2002 10:03:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16jlw7-0002BC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Curiously, on a 1.7GHz P4 running RH7.1 (2.4.2 i686) it never hits
> the same case, and takes slightly over a second to call gettimeofday a

Nothing curious about that I'm afraid. Every benchmark I've run on a PIV
shows that kind of behaviour - anything but perfectly predicted linear
code flow seems to hurt it. Locked operations really seem to make it suffer.
