Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbTIZQqN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 12:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbTIZQqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 12:46:13 -0400
Received: from zeus.kernel.org ([204.152.189.113]:56780 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261439AbTIZQqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 12:46:11 -0400
To: Michael Frank <mhf@linuxmail.org>
Cc: andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG?] SIS IDE DMA errors
References: <yw1x7k3vlokf.fsf@users.sourceforge.net>
	<200309262208.30582.mhf@linuxmail.org>
	<yw1x3cejlk34.fsf@users.sourceforge.net>
	<200309262332.30091.mhf@linuxmail.org>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 26 Sep 2003 17:38:09 +0200
In-Reply-To: <200309262332.30091.mhf@linuxmail.org> (Michael Frank's message
 of "Fri, 26 Sep 2003 23:32:30 +0800")
Message-ID: <yw1xr823k1b2.fsf@users.sourceforge.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Frank <mhf@linuxmail.org> writes:

>> > Suspect chipset related issue which should be looked into.
>> 
>> That's what someone told me three months ago, too.  Nothing happened,
>> though.
>> 
>
> OK, now that we are two, we copy the IDE maintainer ;)
>
> I guess it is fair to say that we are happy to test patches.
>
> And here is my lspci -vv.
>
> 00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if 80 [Master])
>         Subsystem: Micro-Star International Co., Ltd.: Unknown device 5332
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 128
>         Interrupt: pin ? routed to IRQ 10
>         Region 4: I/O ports at 4000 [size=16]
>         Capabilities: <available only to root>

Mine looks rather similar, but there are a few differences.  Mine has
Mem+ and DEVSEL=fast.

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 80 [Master])
	Subsystem: Asustek Computer, Inc.: Unknown device 1688
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Region 4: I/O ports at b800 [size=16]



-- 
Måns Rullgård
mru@users.sf.net
