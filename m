Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVFLUDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVFLUDT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 16:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVFLTWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 15:22:50 -0400
Received: from one.firstfloor.org ([213.235.205.2]:35555 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262646AbVFLRCq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 13:02:46 -0400
To: Daniel Walker <dwalker@mvista.com>
Cc: Esben Nielsen <simlo@phys.au.dk>, <linux-kernel@vger.kernel.org>,
       <sdietrich@mvista.com>, mingo@elte.hu
Subject: Re: [PATCH] local_irq_disable removal
References: <20050611200352.GA1477@elte.hu>
	<Pine.LNX.4.44.0506111345400.12084-100000@dhcp153.mvista.com>
From: Andi Kleen <ak@muc.de>
Date: Sun, 12 Jun 2005 19:02:44 +0200
In-Reply-To: <Pine.LNX.4.44.0506111345400.12084-100000@dhcp153.mvista.com> (Daniel
 Walker's message of "Sat, 11 Jun 2005 13:51:47 -0700 (PDT)")
Message-ID: <m1br6bcxu3.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker <dwalker@mvista.com> writes:
>
> Interesting .. So "cli" takes 7 cycles , "sti" takes 7 cycles. The current 
> method does "lea" which takes 1 cycle, and "or" which takes 1 cycle. I'm 
> not sure if there is any function call overhead .. So the soft replacment 
> of cli/sti is 70% faster on a per instruction level .. So it's at least 
> not any slower .. Does everyone agree on that?

It depends on what CPU your are benchmarking on. On K7 and K8 cli and sti
are only two or three cycles.

-Andi
