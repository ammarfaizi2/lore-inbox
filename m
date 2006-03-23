Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbWCWAHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWCWAHT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 19:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWCWAHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 19:07:06 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:18641 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S964898AbWCWAGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 19:06:42 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: Linux v2.6.16
To: Ashok Raj <ashok.raj@intel.com>, akpm@osdl.org,
       Peter Williams <pwil3058@bigpond.net.au>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ashok.raj@intel.com
Reply-To: 7eggert@gmx.de
Date: Thu, 23 Mar 2006 01:05:42 +0100
References: <5Sm46-2a7-13@gated-at.bofh.it> <5T455-7j-11@gated-at.bofh.it> <5T5aR-1DN-23@gated-at.bofh.it> <5Tbgl-2dp-43@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1FMDLK-0001Li-QY@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj <ashok.raj@intel.com> wrote:
> On Tue, Mar 21, 2006 at 10:31:20PM -0800, Ashok Raj wrote:
>> On Tue, Mar 21, 2006 at 09:22:41PM -0800, Peter Williams wrote:

>> >    I/O APICs
>> >    Mar 22 16:10:31 heathwren kernel: More than 8 CPUs detected and
>> >    CONFIG_X86_PC cannot handle it.
>> > 
>> >    ###  No more CPUs seen but something in there thinks there's more than
>> >    8
>> >    of them.
>> > 
>> >    Mar 22 16:10:31 heathwren kernel: Use CONFIG_X86_GENERICARCH or
>> >    CONFIG_X86_BIGSMP.

> Please consider for inclusion... resending with changelog per Andrew.

You should rather change the message, since AFAIR from the thread
HOTPLUG_CPU is required for suspending.

Something like:
"CONFIG_X86_PC (PC-compatible) can handle up to 8 CPUs. Reconfigure and
 recompile your kernel if you intend to use more CPUs."


BTW: The help text is confusing: If (CONFIG_X86_BIGSMP)
"This option is needed for the systems that have more than 8 CPUs
 and if the system is not of any sub-arch type above.",
no option allowing more than 8 CPUs should follow, but CONFIG_X86_GENERICARCH
does follow and it's suggested for that case. Maybe BIGSMP should be moved
down to the end, only CONFIG_X86_GENERICARCH being below with the help text
changed to "Supports all Subarchitectures above".

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
