Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261324AbSJCXfW>; Thu, 3 Oct 2002 19:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261457AbSJCXfW>; Thu, 3 Oct 2002 19:35:22 -0400
Received: from server.s8.com ([66.77.12.139]:18693 "EHLO server.s8.com")
	by vger.kernel.org with ESMTP id <S261324AbSJCXfV>;
	Thu, 3 Oct 2002 19:35:21 -0400
Subject: Re: linux-2.4.20-pre8-ac3: NFS performance regression
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andreas Pfaller <apfaller@yahoo.com.au>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <shsu1k316jn.fsf@charged.uio.no>
References: <200210032024.47664.apfaller@yahoo.com.au>
	<1033683184.28814.35.camel@irongate.swansea.linux.org.uk> 
	<shsu1k316jn.fsf@charged.uio.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 03 Oct 2002 16:40:40 -0700
Message-Id: <1033688440.7341.20.camel@plokta.s8.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-03 at 15:50, Trond Myklebust wrote:

> FYI, here is the 'fix' Alan is talking about. It could be worth
> trying...

Trond -

I'd seen a similar problem under 2.4.19 with your NFS-ALL patch
applied.  The client would lock up for periods of up to several minutes
at a time without generating any traffic, then would wake up and
retransmit.  This would continue for a few seconds (rarely more than 30
seconds of uninterrupted IO) before another huge pause-and-retransmit
cycle began.

Your patch restores client performance to sane levels.  It applies
cleanly against 2.4.19 with NFS-ALL.  I suggest you republish NFS-ALL
with this patch applied, in case other people who are stuck with 2.4.19
run into this problem.

Thanks,

	<b
