Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031229AbWKURK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031229AbWKURK3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 12:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031238AbWKURK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 12:10:29 -0500
Received: from gateway-1237.mvista.com ([63.81.120.155]:51682 "EHLO
	imap.sh.mvista.com") by vger.kernel.org with ESMTP id S1031230AbWKURK2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 12:10:28 -0500
Message-ID: <45633360.6080109@ru.mvista.com>
Date: Tue, 21 Nov 2006 20:12:00 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       ltt-dev@shafik.org, mgreer@mvista.com, mlachwani@mvista.com
Subject: Re: LTTng do_page_fault vs handle_mm_fault instrumentation
References: <20061121160629.GA6944@Krystal> <4563289A.2000702@ru.mvista.com> <20061121170317.GA10250@Krystal>
In-Reply-To: <20061121170317.GA10250@Krystal>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Mathieu Desnoyers wrote:

> Instrumentation around the handle_mm_fault handler call, inside do_page_fault,
> looked to me as a good compromise : it can access the struct pt_regs, it will
> never be called from either a vmalloc fault or an erroneous page fault caused by
> the tracer itself (which of course, never happens, but who knows...). It won't,
> however, give information about some error paths in the page fault handler,
> mainly related to kernel faults. It is also a little farther from the page
> fault handler "real" entry and exit points, but I consider it a minor impact
> compared to the cost of entering the trap on currently existing architectures.

   I kept this approach mostly (note it would have been hard to change it due 
to this particular handler's structure itself) but just cleaned it up. If you 
consider that adding more markers was a bit too much, I can remove them. :-)

WBR, Sergei
