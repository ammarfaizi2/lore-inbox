Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283928AbRLEKK1>; Wed, 5 Dec 2001 05:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283929AbRLEKKO>; Wed, 5 Dec 2001 05:10:14 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:40430 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S283928AbRLEKJl>; Wed, 5 Dec 2001 05:09:41 -0500
Message-ID: <3C0DF24C.1B128C80@redhat.com>
Date: Wed, 05 Dec 2001 10:09:16 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
CC: linux-kernel@vger.kernel.org
Subject: Re: APIC Error when doing apic_pm_suspend
In-Reply-To: <Pine.LNX.4.33.0112051123500.18928-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> 
> I get an APIC error 0x40 when resuming from an apm -s. If i'm correct
> that would be an illegal register access wouldn't it? I tried putting
> enter/exit printks in the apic_pm_resume/suspend functions and it showed
> that both returned before the APIC error printk. Is there anyway of finding out
> which register access it was? I "thought" it would be one of the
> apic_writes in the pm functions but looks like i might be wrong.
> 
> The kernel is compiled with local APIC and gets detected and enabled on
> boot (UP machine).

Just about all bioses that support suspend do not have the knowledge
that an
operating system would use apics, since windows95 doesn't do that. The
fact
that it appears to mostly work for you is RARE. You're very very lucky
with
an almost not broken bios..... UP APIC and Suspend are usually very
exclusive.
(well, actually, the suspend often works, it's the resume that hurts)

Greetings,
   Arjan van de Ven
