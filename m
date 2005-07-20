Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVGTTYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVGTTYv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 15:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbVGTTYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 15:24:51 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:61297 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S261493AbVGTTYu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 15:24:50 -0400
X-IronPort-AV: i="3.94,212,1118034000"; 
   d="scan'208"; a="269371968:sNHT25046430"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: page allocation/attributes question (i386/x86_64 specific)
Date: Wed, 20 Jul 2005 14:24:48 -0500
Message-ID: <B1939BC11A23AE47A0DBE89A37CB26B40743CA@ausx3mps305.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: page allocation/attributes question (i386/x86_64 specific)
Thread-Index: AcWNO9iN8MVFGj2fQoWn26mYUughoAAAA9cAAAkSqDA=
From: <Stuart_Hayes@Dell.com>
To: <mingo@elte.hu>
Cc: <ak@suse.de>, <riel@redhat.com>, <andrea@suse.de>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Jul 2005 19:24:49.0781 (UTC) FILETIME=[B24EC250:01C58D60]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hayes, Stuart wrote:
> Ingo Molnar wrote:
>> * Stuart_Hayes@Dell.com <Stuart_Hayes@Dell.com> wrote:
>> 
>>> Ingo Molnar wrote:
>>>> there's one problem with the patch: it breaks things that need the
>>>> low 1MB executable (e.g. APM bios32 calls). It would at a minimum
>>>> be needed to exclude the BIOS area in 0xd0000-0xfffff.
>>>> 
>>>> 	Ingo
>>> 
>>> I wrote it to make everything below 1MB executable, if it isn't RAM
>>> according to the e820 map, which should include the BIOS area.  This
>>> includes 0xd0000-0xffff on my system.  Do you think I should
>>> explicity make 0xd0000-0xfffff executable regardless of the e820
>>> map? 
>> 
>> hm ... which portion does this? I'm looking at fixnx2.patch. I
>> definitely saw a APM bootup crash due to this, but that was on a
>> 2.4-ish backport of the patch.
>> 
>> 	Ingo
> 
> Oh, sorry, we're talking about two different patches.  I sent in a
> different patch yesterday, because Andi Kleen didn't seem very
> enthusiastic about fixnx2.patch.  Here's the patch that I sent
> yesterday (attached as file init.c.patch).   
> 
> Thanks
> Stuart

Although... if you like the fixnx2.patch better, I can modify it.  I'm
ok with either approach.

Stuart
