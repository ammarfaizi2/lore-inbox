Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbTHUVs1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 17:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262907AbTHUVs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 17:48:27 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:61119 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S262913AbTHUVs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 17:48:26 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Thu, 21 Aug 2003 23:48:24 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: manfred@colorfullife.com, tejun@aratech.co.kr,
       linux-kernel@vger.kernel.org, zwane@linuxpower.ca
Subject: Re: Possible race condition in i386 global_irq_lock handling.
Message-Id: <20030821234824.37497c08.skraw@ithnet.com>
In-Reply-To: <20030821172721.GI29612@dualathlon.random>
References: <3F44FAF3.8020707@colorfullife.com>
	<20030821172721.GI29612@dualathlon.random>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> smb_rmb is enough in practice for x86 (in asm-i386), but not the right
> barrier in general because rmb only serializes reads against reads, so
> it would also make little sense while reading the i386 code. here you've
> to serialize a write against a read so it would be misleading unless you
> know exactly the lowlevel implementations of those barriers.
> 
> smp_mb() before the while loop should be the correct barrier for all
> archs and the asm generated on x86 will be the same.
> 
> alpha, ia64 and x86-64 (and probably others) needs it too.

Can some kind soul please provide me with the needed mini-patch. I would like
to try that on my constantly crashing SMP test box...

Regards,
Stephan
