Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262447AbSJPN42>; Wed, 16 Oct 2002 09:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262536AbSJPN42>; Wed, 16 Oct 2002 09:56:28 -0400
Received: from zero.aec.at ([193.170.194.10]:49158 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S262447AbSJPN41>;
	Wed, 16 Oct 2002 09:56:27 -0400
Date: Wed, 16 Oct 2002 16:01:53 +0200
From: Andi Kleen <ak@muc.de>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: "David S. Miller" <davem@redhat.com>, ak@muc.de, akpm@digeo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Add extended attributes to ext2/3
Message-ID: <20021016140153.GA8414@averell>
References: <698528293@toto.iv> <15788.54887.251518.350350@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15788.54887.251518.350350@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There isn't as far as I know a flag I can test in a config.in file
> that distinguishes 64 from 32-bit architectures.  The intention was to
> enable the choice of CONFIG_LBD where it made sense;  it doesn't make
> sense for 64-bit architectures; and rather than enumerate all the
> 32-bit architectures, I just chose two that I knew were used in
> servers currently.  

Then you got it wrong. CONFIG_X86 includes x86-64, which is 64bit.
Correct test for x86-32 would be something like
CONFIG_X86 && !CONFIG_X86_64

best way is to just define_bool it in the individual arch/*/config.in
Or alternatively add a CONFIG_64BIT to the 64bit architectures and
test for that.


-Andi
