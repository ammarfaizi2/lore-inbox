Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbVFGAqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVFGAqm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 20:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261800AbVFGAqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 20:46:42 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:37323 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261778AbVFGApS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 20:45:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ARoK6lWh+9cQapZZBWYHA7EDNS6Xxa1Ysv5dVKEcFHGOxChid53GnUpqTwQFavdxXzBtm1KJnsTd/Ii8BbWrPCs5ts/ff2KQzG+bjRd7yjIbu5twxcZyPg6RxfyHwTtnRuq9LGytYGS70+EfeWSFy0a6O9ByLIlZw3W9x7C24GE=
Message-ID: <75052be70506061745478abdf5@mail.gmail.com>
Date: Tue, 7 Jun 2005 08:45:15 +0800
From: Skywind <gnuwind@gmail.com>
Reply-To: Skywind <gnuwind@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Is kernel 2.6.11 adjust tcp_max_syn_backlog incorrectly?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any one know the reason?

I think the subject may change to 
"Is kernel 2.6.11 havn't set /proc network variable"
or
"Kernel 2.6.11 havn't set /proc network variable correctly by mem size"


> Is kernel 2.6.11 adjust tcp_max_syn_backlog incorrectly?
>
> Test Backgroud:
> CPU: Intel P4
> Mem: 512Mb
> The /etc/sysctl.conf and other haven't touch anything.
>
> I found a strange question: when I use kernel 2.6.11, the value of
> /proc/sys/net/ipv4/tcp_max_syn_backlog is 256,
> while kernel 2.6.10 on same computer the value is 1024.
>
> So I check the net/ipv4/[tcp.c, tcp_ipv4.c] and know when Mem >= 256Mb
> the tcp_max_syn_backlog will be set to 1024,
> but it is 256 in my test above.

> Some other variables that should be adjust all together with
> tcp_max_syn_backlog are:
> ip_local_port_range
> tcp_max_tw_buckets
> tcp_max_orphans
> But they don't be adjust to correctly value(refer to net/ipv4/tcp.c) all.
>
> It seems that kernel don't adjust these value automatic, is this a bug?
>
> I guess the mechanism of tcp.c in 2.6.11 have some changes(between
> 2.6.10), and it conduce to this result,
> Is this guess correctly?



> Xu Gang (Skywind)
> 2005/06/06
