Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbWGES1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbWGES1J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 14:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWGES1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 14:27:09 -0400
Received: from terminus.zytor.com ([192.83.249.54]:33165 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964976AbWGES1I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 14:27:08 -0400
Message-ID: <44AC0460.9060607@zytor.com>
Date: Wed, 05 Jul 2006 11:26:40 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] i386: early pagefault handler
References: <200607050745_MC3-1-C42B-9937@compuserve.com>	 <p73veqcp58s.fsf@verdi.suse.de> <44ABEB20.2010702@zytor.com>	 <Pine.LNX.4.64.0607050952190.12404@g5.osdl.org> <1152124139.6533.1.camel@localhost.localdomain>
In-Reply-To: <1152124139.6533.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Mer, 2006-07-05 am 09:54 -0700, ysgrifennodd Linus Torvalds:
>> Anybody with that old a CPU will have learnt to to say "no-hlt" or 
>> whatever the kernel command line is, and we could probably retire the 
>> silly old hlt check (which I'm not even sure really ever worked).
> 
> The one specific case I know precisely details of was the Cyrix 5510. A
> hlt by the CPU on that chipset during an IDE DMA transfer hangs the
> system forever.
> 
> Its some years since I've even seen a 5510 and that check could be
> automated anyway

I think HLT for a die loop should be safe :)

	-hpa
