Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261613AbSJQBZN>; Wed, 16 Oct 2002 21:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261614AbSJQBZN>; Wed, 16 Oct 2002 21:25:13 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:11452 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S261613AbSJQBZN>; Wed, 16 Oct 2002 21:25:13 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "David S. Miller" <davem@redhat.com>
Date: Thu, 17 Oct 2002 11:30:43 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15790.4803.492885.687276@notabene.cse.unsw.edu.au>
Cc: acme@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv4: make arp seq_file show method only produce one
 record per call
In-Reply-To: message from David S. Miller on Wednesday October 16
References: <20021017010135.GR7541@conectiva.com.br>
	<20021016.175809.28811497.davem@redhat.com>
	<20021017011108.GT7541@conectiva.com.br>
	<20021016.181550.88499112.davem@redhat.com>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday October 16, davem@redhat.com wrote:
>    From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
>    Date: Wed, 16 Oct 2002 22:11:08 -0300
> 
>    That would be nice, yes, bastardizing pos for this is, humm, ugly, and
>    it isn't accessible at show time (pun intended 8) ).
> 
> Can you remind me what the original objection was to
> just using seq->private?  Is it used, or planned to
> be used, by something else?

I use seq->private for private state for /proc/fs/nfs/exports.
It works nicely.
You need to define an 'open' the sets it up, and a 'release' to
tear it down, rather than doing it in start/stop.
See fs/nfsd/fnsctl.c:exports_open

NeilBrown
