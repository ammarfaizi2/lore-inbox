Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264938AbTFCGMG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 02:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264939AbTFCGMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 02:12:06 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:28424 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S264938AbTFCGMF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 02:12:05 -0400
Date: Tue, 3 Jun 2003 08:25:00 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Marc Heckmann <mh@nadir.org>
Cc: neilb@cse.unsw.edu.au, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc6: softraid anamoly
Message-ID: <20030603062500.GA10876@alpha.home.local>
References: <20030603031421.GC1766@nadir.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030603031421.GC1766@nadir.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 02, 2003 at 11:14:24PM -0400, Marc Heckmann wrote:
> Hi,
> 
> I just installed a vanilla 2.4.21-rc6 smp kernel on a redhat 9 system
> today. To my surprise, the priority of the raid kernel threads are quite
> odd:
 
>     9 root     18446744073709551615 -20     0   1 mdrecoveryd
>    18 root     18446744073709551615 -20     0   0 raid1d
>    19 root     18446744073709551615 -20     0   0 raid1d
>    20 root     18446744073709551615 -20     0   0 raid1d
>    21 root     18446744073709551615 -20     0   0 raid1d

Known problem in procps-2.0.11 (sprintf %llu). You should upgrade to 2.0.12 or
2.0.13, and you'll see -1 here !

Cheers,
Willy

