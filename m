Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265248AbUAJQIu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 11:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265255AbUAJQIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 11:08:49 -0500
Received: from pD9E565C5.dip.t-dialin.net ([217.229.101.197]:41606 "EHLO
	averell.firstfloor.org") by vger.kernel.org with ESMTP
	id S265248AbUAJQIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 11:08:47 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 NFS-server low to 0 performance
From: Andi Kleen <ak@muc.de>
Date: Sat, 10 Jan 2004 17:08:41 +0100
In-Reply-To: <1csrv-Er-9@gated-at.bofh.it> (Trond Myklebust's message of
 "Sat, 10 Jan 2004 15:40:09 +0100")
Message-ID: <m3eku74whi.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <1cpDr-5az-11@gated-at.bofh.it> <1csrv-Er-9@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> writes:

> The correct solution to this problem is (b). I.e. we convert mount to
> use TCP as the default if it is available. That is consistent with what
> all other modern implementations do.

Please do that. Fragmented UDP with 16bit ipid is just russian roulette at 
today's network speeds.

One disadvantage is that some older (early 2.4) Linux nfsd servers that have
TCP enabled can cause problems. But I guess we can live with that, they
should be updated anyways.

-Andi
