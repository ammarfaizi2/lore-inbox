Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292586AbSCIHS4>; Sat, 9 Mar 2002 02:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292522AbSCIHRl>; Sat, 9 Mar 2002 02:17:41 -0500
Received: from zeus.kernel.org ([204.152.189.113]:61645 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S292529AbSCIHPe>;
	Sat, 9 Mar 2002 02:15:34 -0500
From: pjd@fred001.dynip.com
Message-Id: <200203090303.g29332R14018@fred.cambridge.ma.us>
Subject: Re: gettimeofday() system call timing curiosity
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 8 Mar 2002 22:03:02 -0500 (EST)
Cc: root@chaos.analogic.com, johan.adolfsson@axis.com,
        lk@tantalophile.demon.co.uk (Jamie Lokier),
        hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        terje.eggestad@scali.com (Terje Eggestad),
        greearb@candelatech.com (Ben Greear),
        davidel@xmailserver.org (Davide Libenzi),
        george@mvista.com (george anzinger)
In-Reply-To: <E16jRCr-0007R7-00@the-village.bc.nu> from "Alan Cox" at Mar 08, 2002 08:43:13 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

re: repeated gettimeofday() calls...

Alan Cox wrote:
> 
> On a 1.8GHz athlon the "same" case occurs almost all the time. Machines
> without a TSC will probably never hit it due to the slow ISA transactions
> to talk to the PIT

Curiously, on a 1.7GHz P4 running RH7.1 (2.4.2 i686) it never hits
the same case, and takes slightly over a second to call gettimeofday a
million times.  On my 600MHz Celeron at home (66MHz FSB, i810) running
2.4.17 with a similar .config (I started with the RH7.1 config out of
the source RPM) it takes .8 sec for a million calls and successive calls
return the same value about 20% of the time.

Peter Desnoyers
