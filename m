Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbVBTOoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVBTOoX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 09:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVBTOoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 09:44:22 -0500
Received: from jade.aracnet.com ([216.99.193.136]:45756 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S261835AbVBTOoT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 09:44:19 -0500
Date: Sun, 20 Feb 2005 06:44:12 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jeff Garzik <jgarzik@pobox.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: ncunningham@cyclades.com, kwijibo@zianet.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Should kirqd work on HT?
Message-ID: <320350000.1108910651@[10.10.2.4]>
In-Reply-To: <421769BD.4060606@pobox.com>
References: <88056F38E9E48644A0F562A38C64FB60040DBACB@scsmsx403.amr.corp.intel.com> <421769BD.4060606@pobox.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Jeff Garzik <jgarzik@pobox.com> wrote (on Saturday, February 19, 2005 11:30:53 -0500):

> Pallipadi, Venkatesh wrote:
>> You are right. Kernel balancer doesn't move around the irqs, unless it
>> has too many interrupts. The logic is moving around interrupts all the
>> time will not be good on caches. So, there is a threshold above which
>> the balancer start moving things around.
>> 
>> You should see them moving around if you do 'ping -f' or a big 'dd' from
>> the disk.
> 
> If kirqd is moving NIC interrupts, it's broken.
> 
> (and another reason why irqbalanced is preferable)

Why is it broken to move NIC interrupts? Obviously you don't want to
rotate them around a lot, but in the interests of fairness to other 
processes, it seems reasonable to migrate them occasionally (IIRC, kirqd
rate limits to once a second or something).

M.

