Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310256AbSCEV2B>; Tue, 5 Mar 2002 16:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310248AbSCEV1w>; Tue, 5 Mar 2002 16:27:52 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:3801 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S310240AbSCEV1l>;
	Tue, 5 Mar 2002 16:27:41 -0500
Date: Tue, 5 Mar 2002 13:27:39 -0800
To: Maksim Krasnyanskiy <maxk@qualcomm.com>
Cc: Paul Mackerras <paulus@samba.org>, linux-ppp@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: PPP feature request (Tx queue len + close)
Message-ID: <20020305132739.A1179@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020304144200.A32397@bougret.hpl.hp.com> <15492.13788.572953.6546@argo.ozlabs.ibm.com> <20020304191947.A32730@bougret.hpl.hp.com> <15492.21937.402798.688693@argo.ozlabs.ibm.com> <20020305094535.A792@bougret.hpl.hp.com> <5.1.0.14.2.20020305095825.01b61fd8@mail1.qualcomm.com> <20020305102835.B847@bougret.hpl.hp.com> <5.1.0.14.2.20020305112314.01c3cea8@mail1.qualcomm.com> <20020305122343.A1094@bougret.hpl.hp.com> <5.1.0.14.2.20020305125056.01b5e1b8@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.1.0.14.2.20020305125056.01b5e1b8@mail1.qualcomm.com>; from maxk@qualcomm.com on Tue, Mar 05, 2002 at 01:17:42PM -0800
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 01:17:42PM -0800, Maksim Krasnyanskiy wrote:
>
> True. PPP is a sort of "pass through" thing in your case.

	Not fully. In some cases, PPP does compression (and
potentially encryption), and at 4 Mb/s those operations can become
close to bottlenecks (at least, on my slow boxes). But at least, it's
constant latency, as opposed to IrDA latencies.

> Yes. I see your point. It doesn't really make any difference which layer
> buffers stuff (unless that layer introduces delays). So I guess in your case
> you can just set txqueuelen to 1 if you're sure that underlying layer has long
> enough queues.

	By the way, same logic applies to PAN. In PAN it's easier,
because as PAN is a pseudo Ethernet driver you can fudge tx_queue_len
directly.

> I see.
> Did you try ifconfig txqueuelen 1 ?

	Not yet. I'm finishing the current batch of IrDA fixes, and
other backlog of Wireless patches. I would also need to squeeze
buffers out of IrDA queues.

> Max

	Thanks, have fun...

	Jean
