Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755427AbWKNGYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755427AbWKNGYb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 01:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755428AbWKNGYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 01:24:31 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:40956 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1755427AbWKNGYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 01:24:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=krL4Umr9M6EBQHY7pmUSwIXwmSS+3qjQmoG57KtNbqUOwxCVf7GZ1mPFqGReGfyGF5fIPFj5vf2gAY/Q9aD61ojK+NhVz6hJ0LuyNk9uXM4h20OTJa42MdFsYuDh1QjhGW3SRApIuF1ImttP+xa1osaPW3JTN4uNzBi3QjEZDL8=
Message-ID: <787b0d920611132224n76cb2345t685bb5c521cedcbc@mail.gmail.com>
Date: Tue, 14 Nov 2006 01:24:29 -0500
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Mikulas Patocka" <mikulas@artax.karlin.mff.cuni.cz>
Subject: Re: 2048 CPUs [was: Re: New filesystem for Linux]
Cc: "Pavel Machek" <pavel@ucw.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0611122103060.4965@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920611041154l69db46abv4c8c467809ada57c@mail.gmail.com>
	 <Pine.LNX.4.64.0611042332240.20974@artax.karlin.mff.cuni.cz>
	 <20061107212614.GA6730@ucw.cz>
	 <Pine.LNX.4.64.0611072328220.10497@artax.karlin.mff.cuni.cz>
	 <20061107231456.GB7796@elf.ucw.cz>
	 <Pine.LNX.4.64.0611081921170.5694@artax.karlin.mff.cuni.cz>
	 <20061110090303.GB3196@elf.ucw.cz>
	 <Pine.LNX.4.64.0611101606090.20654@artax.karlin.mff.cuni.cz>
	 <20061112142813.GA4371@ucw.cz>
	 <Pine.LNX.4.64.0611122103060.4965@artax.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> No intel document guarantees you that if more CPUs
> >> simultaneously execute locked cmpxchg in a loop that a
> >
> > If we are talking 2048 cpus, we are talking ia64.
>
> IA64 spinlock is locked cmpxchg, if failed than pause (i386 equivalent of
> rep nop) read the value, and if unlocked, try cmpxchg again.
>
> There is no fairness in it.

I suppose we could use something better.

There is the MCS lock, the related CLH lock, and IBM's
improvement on the MCS lock. As with RCU, we'd need
to get IBM's permission to use their lock. (so, how did we
get permission for RCU?) The basic MCS lock is also
patented I think.

http://www.cs.rochester.edu/~scott/professional/Dijkstra/presentation.html
