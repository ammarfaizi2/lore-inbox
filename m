Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbTJDN3a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 09:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbTJDN3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 09:29:30 -0400
Received: from math.ut.ee ([193.40.5.125]:4024 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262033AbTJDN33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 09:29:29 -0400
Date: Sat, 4 Oct 2003 16:29:23 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Jes Sorensen <jes@trained-monkey.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: qla1280 & __flush_cache_all
In-Reply-To: <m33ceyi1bf.fsf@trained-monkey.org>
Message-ID: <Pine.GSO.4.44.0310041627090.22040-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Meelis> So why is qla1280 in 2.6-current using __flush_cache_all?
>
> The driver is calling flush_cache_all() not __flush_cache_all(), the
> __ thing is an architecture specific issue.
>
> Yes it's a lazy approach left over from the old codebase.

Yes, it's flush_cache_all() that's causing problems. Current sparc64
doesn't even have flush_cache_all anymore.

-- 
Meelis Roos (mroos@linux.ee)

