Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261900AbTBOLwV>; Sat, 15 Feb 2003 06:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbTBOLwV>; Sat, 15 Feb 2003 06:52:21 -0500
Received: from holomorphy.com ([66.224.33.161]:42629 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261900AbTBOLwU>;
	Sat, 15 Feb 2003 06:52:20 -0500
Date: Sat, 15 Feb 2003 04:01:06 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@imladris.surriel.com>
Cc: Mike Galbraith <efault@gmx.de>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CFQ scheduler, #2
Message-ID: <20030215120106.GF29983@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@imladris.surriel.com>,
	Mike Galbraith <efault@gmx.de>, Jens Axboe <axboe@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <5.1.1.6.2.20030215105330.00c84da8@pop.gmx.net> <5.1.1.6.2.20030215105330.00c84da8@pop.gmx.net> <5.1.1.6.2.20030215123533.00cd3e70@pop.gmx.net> <Pine.LNX.4.50L.0302150947570.20371-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50L.0302150947570.20371-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2003 at 09:49:15AM -0200, Rik van Riel wrote:
> pgscan             2751953        5328260  <== ? hmm
> kswapd_steal        380282         522126
> pageoutrun            1107           1956
> allocstall            3472           1238

$ echo $(( 5328260/1956.0 ))       
2724.0593047034763
$ echo $(( (5328260/1956.0)*4 ))
10896.237218813905

That's 2724 pages or 11MB scanned per pageout run. Order-of-magnitude
better ratio for pages stolen per pageout run. Wouldn't mind seeing a
patch that improves this.


-- wli
