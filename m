Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265463AbTLHRcN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 12:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265473AbTLHRcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 12:32:13 -0500
Received: from tantale.fifi.org ([216.27.190.146]:58761 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S265463AbTLHRcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 12:32:11 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Kenny Simpson <theonetruekenny@yahoo.com>, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [NFS client] NFS locks not released on abnormal process termination
References: <20031208033933.16136.qmail@web20024.mail.yahoo.com>
	<shszne3risb.fsf@charged.uio.no>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 08 Dec 2003 09:32:05 -0800
In-Reply-To: <shszne3risb.fsf@charged.uio.no>
Message-ID: <877k17rzai.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> writes:

> >>>>> " " == Kenny Simpson <theonetruekenny@yahoo.com> writes:
> 
>      > So, this patch has not found its way into any kernel yet?  Is
>      > there anyone actively persuing this bug?
> 
> Feel free. There are only so many hours in a day, and right now
> mine are pretty much overbooked with NFSv4 stuff...

Please note that this fix only mitigates the bug: it can still occur,
but much less frequently. Before this patch, nfsd would loose track of
the lock (see the enclosed program at the beginning of the thread)
after a few (<5) kills. With the patch, it takes sometimes as many as
300~500 kills before the bugs manifests itself.

Trond, do you think I should push the patch to Marcelo, or should I
wait for a better fix? I don't think Marcelo would accept a partial
fix. I would try to fix it myself, but I have no clue on the inner
workings of lockd/nfsd.

Phil.
