Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWIMUJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWIMUJA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 16:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWIMUJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 16:09:00 -0400
Received: from gw.goop.org ([64.81.55.164]:31442 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751164AbWIMUJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 16:09:00 -0400
Message-ID: <45086553.4090804@goop.org>
Date: Wed, 13 Sep 2006 13:08:51 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Zachary Amsden <zach@vmware.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael A Fetterman <Michael.Fetterman@cl.cam.ac.uk>
Subject: Re: Assignment of GDT entries
References: <450854F3.20603@goop.org> <Pine.LNX.4.61.0609131523390.28091@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0609131523390.28091@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> The entries 1 through 3 are used during the boot sequence, see
> setup.S, search for "gdt" around line 983.
>   

OK, but that's an early GDT used during boot, which shouldn't have any 
bearing on the GDT of the running kernel.

> I can't imagine a reason why you'd want to do this.
>   

I'm looking at packing all the descriptors together so they share a 
cache line, and therefore reduce the likelihood of a cache miss when 
loading a segment register.

    J
