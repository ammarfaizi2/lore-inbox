Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264231AbUFXKo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbUFXKo3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 06:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264225AbUFXKo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 06:44:28 -0400
Received: from corpmail.outblaze.com ([203.86.166.82]:26083 "EHLO
	corpmail.outblaze.com") by vger.kernel.org with ESMTP
	id S264231AbUFXKoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 06:44:19 -0400
Date: Thu, 24 Jun 2004 18:44:16 +0800
From: Yusuf Goolamabbas <yusufg@outblaze.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: finish_task_switch high in profiles in 2.6.7
Message-ID: <20040624104416.GB8798@outblaze.com>
References: <2ayz2-1Um-15@gated-at.bofh.it> <m3n02tz203.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3n02tz203.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.4.2i
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.2-5; VAE: 6.25.0.62; VDF: 6.25.0.109; host: corpmail.outblaze.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How many context switches do you get in vmstat?

Mentioned in a subsequent message

http://marc.theaimsgroup.com/?l=linux-kernel&m=108806991921498&w=2

> Most likely you just have far too many of them. readprofile will attribute
> most of the cost to finish_task_switch, because that one reenables the 
> interrupts (and the profiling only works with interrupts on)
> 
> Too many context switches are usually caused by user space.

Hmm, Is there a way to determine which syscall would be the culprit. I
guess this is where something like DTrace would be invaluable

http://www.sun.com/bigadmin/content/dtrace/

