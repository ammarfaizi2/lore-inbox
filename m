Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266117AbUFUGYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266117AbUFUGYO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 02:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266128AbUFUGYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 02:24:14 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:10711 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S266117AbUFUGYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 02:24:13 -0400
Date: Mon, 21 Jun 2004 15:25:29 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: [3/4] [PATCH]Diskdump - yet another crash dump function
In-reply-to: <1642.1087796771@kao2.melbourne.sgi.com>
To: Keith Owens <kaos@sgi.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@muc.de>
Message-id: <D8C457588C10EEindou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <1642.1087796771@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 21 Jun 2004 15:46:11 +1000, Keith Owens wrote:

>On Thu, 17 Jun 2004 14:13:56 +0200, 
>Ingo Molnar <mingo@elte.hu> wrote:
>>but there's another possible method (suggested by Alan Cox) that
>>requires no changes to the timer API hotpaths: 'clear' all timer lists
>>upon a crash [once all CPUs have stopped and irqs are disabled] and just
>>let the drivers use the normal timer APIs. Drive timer execution via a
>>polling method.
>>
>>this basically approximates your polling based implementation but uses
>>the existing kernel timer data structures and timer mechanism so should
>>be robust and compatible. It doesnt rely on any previous state (because
>>all currently pending timers are discarded) so it's as crash-safe as
>>possible.
>
>Don't forget live crash dumping.  The system is running and is behaving
>strangely so you want to take a dump for investigation, but you do not
>want to kill the system afterwards.  Live crash dumping is very useful
>for problem diagnosis.
>It is a little more complex than dumping after an oops because you must
>not destroy any kernel data, including timer lists.

The method he proposed is used only when die/panic happens. Live dump
is a function crash command provides throuth /dev/mem.

Best Regards,
Takao Indoh
