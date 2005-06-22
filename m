Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVFVSAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVFVSAi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 14:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVFVR73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 13:59:29 -0400
Received: from web30712.mail.mud.yahoo.com ([68.142.201.250]:26540 "HELO
	web30712.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261781AbVFVRzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 13:55:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=h1dq4etjPvSrv6j5PLqUzzV8ZXpv+Rp6BPCoWo8EAGXT4kC5ub+30CBA6ORVphkTM50QTLk+oRdi5bTXlTZRWJ4cArB0cpI/XxeVtM+k1pKmvJ//h14SoFJ8+u1oDk01Zgy7LZ60c5l+AoRo8yauRp/P8KKrQW/HIeW+UUZ93k0=  ;
Message-ID: <20050622175457.18548.qmail@web30712.mail.mud.yahoo.com>
Date: Wed, 22 Jun 2005 10:54:57 -0700 (PDT)
From: <spaminos-ker@yahoo.com>
Reply-To: spaminos-ker@yahoo.com
Subject: Re: cfq misbehaving on 2.6.11-1.14_FC3
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1119432285.3257.5.camel@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Jens Axboe <axboe@suse.de> wrote:
> THe problem here is that cfq  (and the other io schedulers) still
> consider the io async even if fsync() ends up waiting for it to
> complete. So there's no real QOS being applied to these pending writes,
> and I don't immediately see how we can improve that situation right now.
<I might sound stupid>
I still don't understand why async requests are in a different queue than the
sync ones?
Wouldn't it be simpler to consider all the IO the same, and like you pointed
out, consider synced IO to be equivalent to async + some sync (as in wait for
completion) call (fsync goes a little too far).
</I might sound stupid>

> 
> What file system are you using? I ran your test on ext2, and it didn't
> give me more than ~2 seconds latency for the fsync. Tried reiserfs now,
> and it's in the 23-24 range.
> 
I am using ext3 on Fedora Core 3.


