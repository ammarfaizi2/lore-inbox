Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269314AbUJGAxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269314AbUJGAxi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 20:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269356AbUJGAxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 20:53:38 -0400
Received: from main.gmane.org ([80.91.229.2]:21134 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269314AbUJGAxf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 20:53:35 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Pasi Savolainen <psavo@iki.fi>
Subject: Re: 2.6.9-rc3-mm2
Date: Thu, 7 Oct 2004 00:53:31 +0000 (UTC)
Message-ID: <slrncm94sb.hiv.psavo@varg.dyndns.org>
References: <1096968325.2628.5.camel@localhost.localdomain> <Pine.LNX.4.44.0410051251210.6757-100000@localhost.localdomain>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a11a.mannikko1.ton.tut.fi
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Hugh Dickins <hugh@veritas.com>:
> On Tue, 5 Oct 2004, Peter Zijlstra wrote:
>> On Mon, 2004-10-04 at 19:13, Pasi Savolainen wrote:
>> >   LD      .tmp_vmlinux1
>> >   KSYM    .tmp_kallsyms1.S
>> > make: *** wait: No child processes.  Stop.
>> > - -
>> > The 'no child processes' keeps on coming up at 'random' moments under
>> > rc3-mm1. First time ever that I've seen it otherwise.
>> 
>> Just a simple mee too!
>> on 2.6.9-rc3-mm2-VP-T0 and on some earlier Sx patches as well.
>> Unfortunatly I haven't had time to track back as to when this was
>> introduced.
>
> Please, would you try this patch below that I posted yesterday?
> At the time I thought the trylock was hardly used so not urgent.

Thanks, this seemed to fix it.
In my case these came very frequently and easily. No Zombie processes
were in 'ps aux' output, but I think it's being talked about in the
other thread.

-- 
   Psi -- <http://www.iki.fi/pasi.savolainen>

