Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287306AbSBMQHd>; Wed, 13 Feb 2002 11:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287421AbSBMQHX>; Wed, 13 Feb 2002 11:07:23 -0500
Received: from splat.lanl.gov ([128.165.17.254]:40888 "EHLO
	balance.radtt.lanl.gov") by vger.kernel.org with ESMTP
	id <S287306AbSBMQHR>; Wed, 13 Feb 2002 11:07:17 -0500
Date: Wed, 13 Feb 2002 09:07:16 -0700
From: Eric Weigle <ehw@lanl.gov>
To: Akarapu Mahesh <mahesh_a6@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: doubt on auto tuning in 2.4 kernels
Message-ID: <20020213160716.GB31597@lanl.gov>
In-Reply-To: <F2587EYg3BOWkSPPi4J0001ca43@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F2587EYg3BOWkSPPi4J0001ca43@hotmail.com>
User-Agent: Mutt/1.3.25i
X-Eric-Unconspiracy: There ought to be a conspiracy
X-Editor: Vim, http://www.vim.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> Does anybody know if auto tuning can be turned off in 2.4 kernels. If yes
> can some body tell me how to do so. Seems like Auto tuning of socket buffers
> is overriding my large buffer settings.
> Any help in this regard would be appreciated.

It can't be turned off. It is a way of managing non-swappable kernel memory
and if you are in memory pressure, then you may not get 'ideal' buffers.

There are a couple things you *can* do, though; take a look at
Documentation/networking/ip-sysctl.txt in the kernel source. In particular,
tcp_wmem and tcp_rmem. It's not a good idea to set min and max the
same, but if you make your default the 'ideal' and the min/max slightly
less/more you should get good results.

Also look at your settings in /proc/sys/net/core/[rw]mem_[max|default].

Here are a couple of tuning links I've found useful:

	http://www.psc.edu/networking/perf_tune.html#Linux
	http://www-didc.lbl.gov/tcp-wan.html
 
-Eric

--
--------------------------------------------
 Eric H. Weigle   CCS-1, RADIANT team
 ehw@lanl.gov     Los Alamos National Lab
 (505) 665-4937   http://home.lanl.gov/ehw/
--------------------------------------------
