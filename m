Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbVL2QSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbVL2QSu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 11:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbVL2QSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 11:18:50 -0500
Received: from cantor2.suse.de ([195.135.220.15]:20881 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750793AbVL2QSt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 11:18:49 -0500
To: =?iso-8859-1?q?Dieter_St=FCken?= <stueken@conterra.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: X86_64 compile error (crash.c)
References: <43B40541.20107@conterra.de>
From: Andi Kleen <ak@suse.de>
Date: 29 Dec 2005 17:18:37 +0100
In-Reply-To: <43B40541.20107@conterra.de>
Message-ID: <p73wthng9lu.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Stüken <stueken@conterra.de> writes:
> 
> #include <linux/cpumask.h> might be included in "asm-x86_64/proto.h"
> 
> however, it happens only with a very unusual configuration:
> 
> CONFIG_X86_64=y
> CONFIG_KEXEC=y
> CONFIG_COMPAT=n
> 
> else linux/cpumask.h gets included somewhere else...

Thanks for the report. I think the right fix is to move the declaration
of cpu_initialized into smp.h. I did this in my tree for 2.6.16.

-Andi
