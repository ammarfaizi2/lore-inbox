Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264119AbTEGREy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 13:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264118AbTEGREy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 13:04:54 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:62110 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264119AbTEGRE0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 13:04:26 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 7 May 2003 10:18:29 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
In-Reply-To: <20030507164901.GB19324@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.50.0305071009050.2208-100000@blue1.dev.mcafeelabs.com>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de>
 <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de>
 <20030507143315.GA6879@stargate.galaxy> <20030507144736.GE8978@holomorphy.com>
 <20030507164901.GB19324@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003, [iso-8859-1] Jörn Engel wrote:

> It also matters if people writing applications for embedded systems
> have a fetish for many threads. 1000 threads, each eating 8k memory
> for pure existance (no actual work done yet), do put some memory
> pressure on small machines. Yes, it would be possible to educate those
> people, but changing kernel code is more fun and less work.

I'm afraid I do not agree with both your sentences. Changing a *working
kernel* code is definitely not much fun and not really less work if your
target is the per-cpu kernel stack. You'll completely lose kernel
preemption and this is really bad since many paths inside the kernel are
easily preemptable. The design and the code of the kernel will become more
complex (and slow) and even people that are correctly programming it are
going to pay the price. No thanks, I'd say screw you thread maniacs ...




- Davide

