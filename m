Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312983AbSD3IMO>; Tue, 30 Apr 2002 04:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313012AbSD3IMO>; Tue, 30 Apr 2002 04:12:14 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:29836 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S312983AbSD3IMN>; Tue, 30 Apr 2002 04:12:13 -0400
Date: Tue, 30 Apr 2002 09:51:57 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: blitzkrieg <blitzkrieg@sitoverde.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.11 SMP, APIC, build breaks
In-Reply-To: <20020429191540.A12574@slackware.alcatrazz.org>
Message-ID: <Pine.LNX.4.44.0204300942360.25786-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Apr 2002, blitzkrieg wrote:

> HI,
> I was trying to compile 2.5.11, I noticed that if 
> # CONFIG_SMP is not set
> 
> 	and
> 	
> # CONFIG_X86_LOCAL_APIC is not set
> # CONFIG_X86_IO_APIC is not set

Basically, that code needs CONFIG_X86_LOCAL_APIC, which is set for SMP or 
Local-APIC on UP (no IOAPIC needed). -dj has the following which fixes 
that dependancy.

dep_bool 'check for P4 thermal throttling interrupt.' \
CONFIG_X86_MCE_P4THERMAL $CONFIG_X86_MCE $CONFIG_X86_LOCAL_APIC

It'll get fixed when that stuff gets merged from -dj (where it originates 
from). For now simply enabling CONFIG_X86_LOCAL_APIC should suffice.

Thanks,
	Zwane Mwaikambo

-- 
http://function.linuxpower.ca


