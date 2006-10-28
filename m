Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWJ1Pds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWJ1Pds (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 11:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWJ1Pds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 11:33:48 -0400
Received: from h155.mvista.com ([63.81.120.155]:43328 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S1750920AbWJ1Pdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 11:33:47 -0400
Message-ID: <45437856.5060509@ru.mvista.com>
Date: Sat, 28 Oct 2006 19:33:42 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Cc: Ingo Molnar <mingo@elte.hu>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, mgreer@mvista.com
Subject: Re: [PATCH -rt] powerpc update
References: <20061003155358.756788000@dwalker1.mvista.com> <20061018072858.GA29576@elte.hu> <454371AC.4030902@ru.mvista.com>
In-Reply-To: <454371AC.4030902@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I wrote:

> 3. Do the same as x86 APIC driver does and use level/egde flows instead 
> of fasteoi for the case when IRQs are threaded -- that ensues doing (2) 
> as well.

    Note that OpenPIC (as far as I could understand its h/w) is essentially
the same as IOAPIC/LAPIC couple on x86, i.e. a level-triggered IRQ remains 
effectively globally masked until CPU writes to its local EOI reg. However, 
the repetitive edge-triggered IRQ from the same line may still be detected 
while being serviced on a CPU (hm, the questions is, can it be sent to any 
other CPU in system while being handled on a certain CPU?)...
    I hope somebody corrects me if I'm wrong about both x86 and PPC. :-)

>>     Ingo

WBR, Sergei

