Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311304AbSCQFff>; Sun, 17 Mar 2002 00:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311299AbSCQFfZ>; Sun, 17 Mar 2002 00:35:25 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:62712
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S311296AbSCQFfN>; Sun, 17 Mar 2002 00:35:13 -0500
Date: Sat, 16 Mar 2002 21:36:24 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: MrChuoi@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre3-ac1
Message-ID: <20020317053624.GD23938@matchmail.com>
Mail-Followup-To: MrChuoi@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020316190415.38CE14E534@mail.vnsecurity.net> <E16mLFj-000794-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16mLFj-000794-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 08:58:11PM +0000, Alan Cox wrote:
> > SwapTotal:       65528 kB
> > SwapFree:        65528 kB
> > Committed_AS:    57252 kB
> 
> Ok at this point you have 64Mb of free swap, and at worse (absolutely worst
> pure theory) have 57Mb committed
> 
> > LowTotal:       126856 kB
> > SwapTotal:       65528 kB
> > SwapFree:        63324 kB
> > Committed_AS:   226160 kB
> 
> So you have 128Mb of RAM, 64Mb of swap, and if all pages are touched you
> would need 226Mb of swap + ram (minus kernel overhead). Looks like the
> machine is hovering on the edge
> 

In Other Words (IOW), add more swap like everyone else said.

The rmap design does use a bit more memory (about 400k for 128MB ram) for
the reverse mapping tables, so that could push you over into an OOM case.
