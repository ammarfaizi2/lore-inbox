Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966209AbWKTRBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966209AbWKTRBz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 12:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966210AbWKTRBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 12:01:55 -0500
Received: from h155.mvista.com ([63.81.120.155]:16327 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S966207AbWKTRBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 12:01:54 -0500
Message-ID: <4561DFE1.4020708@ru.mvista.com>
Date: Mon, 20 Nov 2006 20:03:29 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
 type IRQ handlers
References: <200611192243.34850.sshtylyov@ru.mvista.com> <1163966437.5826.99.camel@localhost.localdomain> <20061119200650.GA22949@elte.hu> <1163967590.5826.104.camel@localhost.localdomain> <20061119202348.GA27649@elte.hu> <1163985380.5826.139.camel@localhost.localdomain> <20061120100144.GA27812@elte.hu> <4561C9EC.3020506@ru.mvista.com> <20061120165621.GA1504@elte.hu>
In-Reply-To: <20061120165621.GA1504@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Ingo Molnar wrote:

>>>on PPC64, 'get the vector' initiates an ACK as well - is that done 
>>>before handle_irq() is done?

>>   Exactly. How else do_IRQ() would know the vector?

> the reason i'm asking is that in this case masking is a bit late at this 
> point and there's a chance for a repeat interrupt.

    How's that? Acknowledge != EOI on OpenPIC (as well as 8259).
    Acknoledging sets the bit in the in-service register preventing all the 
interrupts with same or lower prioriry from being accepted.

> 	Ingo

WBR, Sergei
