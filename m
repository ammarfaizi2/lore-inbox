Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbTINLef (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 07:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbTINLef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 07:34:35 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:60688 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262374AbTINLee
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 07:34:34 -0400
Date: Sun, 14 Sep 2003 13:34:21 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>, neilb@cse.unsw.edu.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-pre4 => NFSD problem on alpha
Message-ID: <20030914113421.GA705@alpha.home.local>
References: <Pine.LNX.4.44.0309121528290.3893-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309121528290.3893-100000@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, Neil,

I've tested -pre4 on my alpha, and noticed that knsfd doesn't work anymore :
the client sticks in D state forever. It has been working flawlessly for
weeks with 2.4.22-rc2. What's strange is that 23-pre4 is OK on my athlon with
the same nfs-utils (1.0.5).

I have the following NFSD options on both kernels :
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y

My alpha kernels were build with GCC 3.2.3, while the athlon one is done with
2.95.3.

If I have some time, I'll try intermediate kernels to find which one brought
the problem. I noticed that there were knfsd changes in 2.4.23-pre3, perhaps
they're related. If you want me to try a patch, please ask.

Cheers,
Willy

