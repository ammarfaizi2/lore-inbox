Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265769AbUEZTC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265769AbUEZTC4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 15:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265777AbUEZTC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 15:02:56 -0400
Received: from waste.org ([209.173.204.2]:38275 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S265769AbUEZTCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 15:02:55 -0400
Date: Wed, 26 May 2004 14:02:22 -0500
From: Matt Mackall <mpm@selenic.com>
To: "David S. Miller" <davem@redhat.com>
Cc: J?rn Engel <joern@wohnheim.fh-wedel.de>, mingo@elte.hu, andrea@suse.de,
       riel@redhat.com, torvalds@osdl.org, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: 4k stacks in 2.6
Message-ID: <20040526190216.GA5414@waste.org>
References: <Pine.LNX.4.44.0405251549530.26157-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.44.0405251607520.26157-100000@chimarrao.boston.redhat.com> <20040525211522.GF29378@dualathlon.random> <20040526103303.GA7008@elte.hu> <20040526125014.GE12142@wohnheim.fh-wedel.de> <20040526111222.4159a771.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040526111222.4159a771.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2004 at 11:12:22AM -0700, David S. Miller wrote:
> On Wed, 26 May 2004 14:50:14 +0200
> J?rn Engel <joern@wohnheim.fh-wedel.de> wrote:
> 
> > Change gcc to catch stack overflows before the fact and disallow
> > module load unless modules have those checks as well.
> 
> That's easy, just enable profiling then implement a suitable
> _mcount that checks for stack overflow.  I bet someone has done
> this already.

There was a patch floating around for this in the 2.2 era that I
ported to 2.4 on one occassion. It won't tell you worst case though,
just worst observed case.

Sparse is probably not a bad place to put a real call chain stack analysis.

-- 
Mathematics is the supreme nostalgia of our time.
