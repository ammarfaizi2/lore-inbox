Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbVBSJOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVBSJOr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 04:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVBSJMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 04:12:30 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:64986 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261664AbVBSJF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 04:05:57 -0500
Subject: Re: Should kirqd work on HT?
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4216E248.5070603@pobox.com>
References: <1108794699.4098.28.camel@desktop.cunningham.myip.net.au>
	 <4216E248.5070603@pobox.com>
Content-Type: text/plain
Message-Id: <1108804063.4098.35.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 19 Feb 2005 20:07:43 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff.

On Sat, 2005-02-19 at 17:52, Jeff Garzik wrote:
> Nigel Cunningham wrote:
> What are the results of running irqbalanced?

You mean the debugging output? I can reenable it and record the results
if that's what you mean.

>From memory though, it got to not_worth_the_effort via this code:

        if (tmp_loaded == -1) {
         /* In the case of small number of heavy interrupt sources,
          * loading some of the cpus too much. We use Ingo's original
          * approach to rotate them around.
          */
                if (!first_attempt && imbalance >= useful_load_threshold) {
                        rotate_irqs_among_cpus(useful_load_threshold);
                        return;
                }
                goto not_worth_the_effort;
        }


(arch/i386/kernel/io_apic.c:449.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

