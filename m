Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263081AbTHVKHY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 06:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263092AbTHVKHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 06:07:23 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:44002 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S263081AbTHVKHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 06:07:22 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Fri, 22 Aug 2003 12:07:20 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: TeJun Huh <tejun@aratech.co.kr>
Cc: andrea@suse.de, manfred@colorfullife.com, linux-kernel@vger.kernel.org,
       zwane@linuxpower.ca
Subject: Re: Possible race condition in i386 global_irq_lock handling.
Message-Id: <20030822120720.06b0f8f6.skraw@ithnet.com>
In-Reply-To: <20030822011840.GA14540@atj.dyndns.org>
References: <3F44FAF3.8020707@colorfullife.com>
	<20030821172721.GI29612@dualathlon.random>
	<20030821234824.37497c08.skraw@ithnet.com>
	<20030822011840.GA14540@atj.dyndns.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Aug 2003 10:18:40 +0900
TeJun Huh <tejun@aratech.co.kr> wrote:

>  I'm attaching patch for i386. It makes three changes.
> 
>  1. add smp_mb() between local_irq_count++ and global_irq_lock test
>     in irq_enter().
>  2. add smp_mb__after_clear_bit() before irqs_running() test in
>     wait_on_irq().
>  3. remove irqs_running() test from synchronize_irq()

Thank you TeJun,

I have started tests and will provide feedback if your patch has any influence
on my problem. This may take some days.

Regards,
Stephan
