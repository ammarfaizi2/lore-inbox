Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314085AbSFNXaI>; Fri, 14 Jun 2002 19:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314396AbSFNXaH>; Fri, 14 Jun 2002 19:30:07 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:14279 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S313571AbSFNXaF>; Fri, 14 Jun 2002 19:30:05 -0400
Date: Fri, 14 Jun 2002 18:29:52 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Dave Jones <davej@suse.de>
cc: john stultz <johnstul@us.ibm.com>, <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [Patch] tsc-disable_A5
In-Reply-To: <20020614215654.V16772@suse.de>
Message-ID: <Pine.LNX.4.44.0206141827510.31514-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jun 2002, Dave Jones wrote:

> On Fri, Jun 14, 2002 at 12:04:18PM -0700, john stultz wrote:
> 
>  > .config that looked like:
>  > 
>  > CONFIG_X86_TSC=y
>  > ...
>  > # CONFIG_X86_TSC is not set
>  > So I assumed CONFIG_X86_TSC would still hold. Am I wrong, or is there
>  > another way to do this?
> 
> Ugh, I hadn't realised the .config generation was so primitive.
> That's quite unfortunate. That needs fixing at some point.

I suppose you could it rewrite like

...
CONFIG_X86_WANT_TSC=y (or whatever)
...

if [ some_condition ]; then
  define_bool CONFIG_X86_TSC n
else
  define_bool CONFIG_X86_TSC $CONFIG_X86_WANT_TSC
fi

Not exactly elegant, but it should work ;)

--Kai


