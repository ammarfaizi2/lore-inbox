Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318706AbSIKKsL>; Wed, 11 Sep 2002 06:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318708AbSIKKsK>; Wed, 11 Sep 2002 06:48:10 -0400
Received: from zero.aec.at ([193.170.194.10]:64786 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S318706AbSIKKsJ>;
	Wed, 11 Sep 2002 06:48:09 -0400
Date: Wed, 11 Sep 2002 12:51:10 +0200
From: Andi Kleen <ak@muc.de>
To: Oleg Drokin <green@namesys.com>
Cc: Andi Kleen <ak@muc.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre6
Message-ID: <20020911125110.A9187@averell>
References: <Pine.LNX.4.44.0209101501200.16518-100000@freak.distro.conectiva> <20020911140047.A924@namesys.com> <20020911121438.20537@colin.muc.de> <20020911143644.A841@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020911143644.A841@namesys.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2002 at 12:36:44PM +0200, Oleg Drokin wrote:
> Hello!
> 
> On Wed, Sep 11, 2002 at 12:14:38PM +0200, Andi Kleen wrote:
> 
> > > AGP stuff still does not work for me. (It broke somewhere around 2.4.20-pre4
> > > and I reported it at that time, but nobody was interested in that somehow)
> > Does the kernel print a message like "Advanced speculative caching feature present" 
> > or not present at boot up? 
> 
> Nothing even remotely similar to that.
> Also I greeped the source tree and have found nothing similar to that in source,
> too.
> 
> > If yes does it go away when you boot with unsafe-gart-alias  ? 
> 
> There seems to be no such option, too
> green@angband:~/bk_work/reiser3-linux-2.4> grep -r gart-alias *
> green@angband:~/bk_work/reiser3-linux-2.4>


That was just for double checking. Looks like Marcelo removed it already.

> 
> > What other command line options do you use? Perhaps mem=nopentium? If yes
> > does it help when you boot without that and with unsafe-gart-alias specified.
> 
> Yes, if I remove mem=nopentium , it boots ok.

Ok. That makes it clearer.

One final question: Did you compile your kernel with CONFIG_X86_PAE
(= CONFIG_HIGHMEM64G) ? 

-Andi

