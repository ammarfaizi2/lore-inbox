Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbUCEEUc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 23:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbUCEEUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 23:20:32 -0500
Received: from mail004.syd.optusnet.com.au ([211.29.132.145]:62670 "EHLO
	mail004.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262204AbUCEEUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 23:20:30 -0500
From: Stuart Young <sgy-lkml@amc.com.au>
To: <jason@stdbev.com>, linux-kernel@vger.kernel.org
Subject: Re: ACPI battery info failure after some period of time, 2.6.3-x and up
Date: Fri, 5 Mar 2004 15:20:40 +1100
User-Agent: KMail/1.5.4
References: <4047756D.2050402@blue-labs.org> <a2dddb49576d8789a2f7092911006002@stdbev.com>
In-Reply-To: <a2dddb49576d8789a2f7092911006002@stdbev.com>
Organization: AMC Enterprises P/L
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403051520.40341.sgy-lkml@amc.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Mar 2004 03:08 pm, Jason Munro wrote:
> On 12:29 pm Mar 4 David Ford <david+challenge-response@blue-labs.org> wrote:
> > powerix root # cat /proc/acpi/battery/BAT0/state
> > present:                 yes
> > ERROR: Unable to read battery status
> >
> > powerix root # dmesg -c
> >     ACPI-0279: *** Error: Looking up [BST0] in namespace,
> > AE_ALREADY_EXISTS     ACPI-1120: *** Error: Method execution failed
> > [\_SB_.BAT0._BST] (Node e7bd7680), AE_ALREADY_EXISTS
> >
> > powerix root # uname -r
> > 2.6.4-rc1
> >
> > This has been going on since about 2.6.3-rc something.  Some while
> > after reading the /proc files, the ability to read the battery
> > information gets munged.
>
> Same here on a Toshiba 1410-s173 noteboook:
>
> [logger] ACPI group battery / action battery is not defined
> [kernel] ACPI-0279: *** Error: Looking up [BUFF] in namespace,
>          AE_ALREADY_EXISTS
>
> I don't think it's happened in less than 24 hours of uptime, during which
> everything is good. I have been using suspend to ram daily if that matters
> (echo 3 > /proc/acpi/sleep).
>
> Linux version 2.6.3-wolk1.0 (root@jackass) (gcc version 3.3.3 20040217
> (Gentoo Linux 3.3.3, propolice-3.3-7)) #1 Thu Feb 26 16:18:24 CST 2004

Happened once to me. I actually thought my battery was dying, so I went into 
the BIOS and did a battery cycle (full discharge). Hasn't come back since, 
but I'd guess that was a co-incidence. Probably needed it anyway.

Feb 21 18:32:10 kosh kernel:     ACPI-0279: *** Error: Looking up [NACH] in 
namespace, AE_ALREADY_EXISTS
Feb 21 18:32:10 kosh kernel:     ACPI-1120: *** Error: Method execution failed 
[\_SB_.BAT0._BST] (Node c7f88ba0), AE_ALREADY_EXISTS

Was running 2.6.3 (vanilla) at the time. Uptime at this point (first mention 
in logs) was ~1 day, 1 hour & 15 mins. Probably haven't had >24 hrs uptime 
since then. Will have this weekend (for testing).

Laptop is an Asus L7300/L7200 (PIII-600 on 440MX chipset) with the latest 
BIOS. Currently running 2.6.4-rc2 vanilla.


