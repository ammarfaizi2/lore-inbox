Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbUCDPCt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 10:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbUCDPCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 10:02:49 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:51195 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S261924AbUCDPBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 10:01:20 -0500
Date: Thu, 4 Mar 2004 16:01:17 +0100
From: David Weinehall <tao@acc.umu.se>
To: Andi Kleen <ak@muc.de>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.2, AMD kernel: MCE: The hardware reports a non fatal, correctable incident
Message-ID: <20040304150117.GE19111@khan.acc.umu.se>
Mail-Followup-To: Andi Kleen <ak@muc.de>,
	Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
References: <1vmlH-3HK-5@gated-at.bofh.it> <1vq6q-7YO-33@gated-at.bofh.it> <m3llmgj0xc.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3llmgj0xc.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 12:39:59PM +0100, Andi Kleen wrote:
> Dave Jones <davej@redhat.com> writes:
> 
> > I'm toying with the idea of marking it CONFIG_BROKEN for 2.6,
> > and fixing it up later.
> 
> I would actually suggest to switch over to the rewritten MCE handler
> from x86-64 for i386 too. IMHO it is much better. It is race free,
> does not panic the machine if not needed, CPU independent, follows the
> Intel and AMD recommendations, run time sysfs configurable, logs to a
> separate device and does lots of other things much better
> [of course I'm biased on that a bit]. Disadvantage is that it isn't
> as well tested.

Well, the only way to solve that problem is to test it, right?  And what
better way to test it than to switch i386 over to it too :-)

> I haven't tried it on i386, but i wrote it to be easily portable
> to 32bit too. It does periodic MCEs too, but with a much lower 
> frequency and they could be turned off. I'm considering to turn
> them off for x86-64 too, because they seem to only log one bit
> ECC errors all the time. But with the new separate log device it's much
> less of a problem.
> 
> The only thing you would lose is the support for P5 MCEs, but these
> could be relatively easily readded if that should be a problem.

Well, losing functionality would be bad.

> Extended register logging for P4 is also not implemented right now,
> but that hardly seems like a needed feature.

No opinion here.


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
