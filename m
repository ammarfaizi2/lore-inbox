Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264232AbTFPUPj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 16:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264248AbTFPUPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 16:15:39 -0400
Received: from aibn55.astro.uni-bonn.de ([131.220.96.55]:7623 "EHLO
	aibn55.astro.uni-bonn.de") by vger.kernel.org with ESMTP
	id S264232AbTFPUPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 16:15:37 -0400
Date: Mon, 16 Jun 2003 22:29:20 +0200 (CEST)
From: Ole Marggraf <marggraf@astro.uni-bonn.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Ryan <genanr@emsphone.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.4.21: NFS copy produces I/O errors
In-Reply-To: <20030616200415.GA23051@thumper2.emsphone.com>
Message-ID: <Pine.LNX.4.55.0306162207360.8634@aibn99.astro.uni-bonn.de>
References: <Pine.LNX.4.55.0306162047140.6775@aibn99.astro.uni-bonn.de>
 <20030616200415.GA23051@thumper2.emsphone.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Trond, Andy.

Thank you, both, for the prompt reply.


On Mon, 16 Jun 2003, Andrew Ryan wrote:

> Trond, will tell you to always use hard mounts.  Though I believe it is an
> excuse to not fix what it really broken since other UNIXes seem to not have
> problems with soft mounts, it is a Linux problem, IMHO.

Actually, I just played around with the timeouts... It seems to work (only
one try, which is quite bad statistics...) also for a soft mount (hard
mount works anyway) when I raise "retrans" to 20. At retrans=15 I still
get a timeout (but much later, after about 30MB transmitted). This is for
an internal connection via only one switch, and with no significant
network load at the moment.

Which makes me wonder, since our system did not have any such problems for
years with the default retrans=3 (and soft mounts), until we ran into
2.4.20. That's why I actually did not expect that there was a need for
finetuning these parameters, and not by this amount... . 2.4.19 was
running fine, so something has to have changed on the way to 2.4.20.

> I don't know is this is the "right" way to fix this, but this patch has
> worked for me.  Kernel versions should not matter, as long as you add the
> !clnt->cl_softrtry to the if statement shown below things should work.
>
> But if you don't want to try this :

I will test the patch tomorrow, yes, thank you. I'll keep you informed.


Best regards,

Ole

-- 
+------------------------------------------------------------------------------+
 Ole Marggraf                     email: marggraf@gmx.net
 Sternwarte, Universitaet Bonn           marggraf@astro.uni-bonn.de
 Auf dem Huegel 71
 D-53121 Bonn, Germany            WWW:   http://www.astro.uni-bonn.de/~marggraf
+------------------------------------------------------------------------------+
