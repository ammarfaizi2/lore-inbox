Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030317AbVH0FeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030317AbVH0FeH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 01:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbVH0FeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 01:34:06 -0400
Received: from linares.terra.com.br ([200.176.10.195]:57813 "EHLO
	linares.terra.com.br") by vger.kernel.org with ESMTP
	id S1030315AbVH0FeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 01:34:05 -0400
X-Terra-Karma: -2%
X-Terra-Hash: 9fa27bbb24781ce970d756773e087895
Date: Sat, 27 Aug 2005 02:34:00 -0300
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@davemloft.net>,
       rml@novell.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] IBM HDAPS accelerometer driver, with probing.
Message-ID: <20050827053359.GB15782@mandriva.com>
Mail-Followup-To: acme@ghostprotocols.net,
	Mitchell Blank Jr <mitch@sfgoth.com>, Andi Kleen <ak@suse.de>,
	"David S. Miller" <davem@davemloft.net>, rml@novell.com,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <1125094725.18155.120.camel@betsy> <20050826225848.GC28191@mipter.zuzino.mipt.ru> <20050826.161537.03992270.davem@davemloft.net> <p73vf1skt0g.fsf@verdi.suse.de> <20050827040622.GH91880@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050827040622.GH91880@gaz.sfgoth.com>
X-Url: http://advogato.org/person/acme
User-Agent: Mutt/1.5.9i
From: acme@ghostprotocols.net (Arnaldo Carvalho de Melo)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 26, 2005 at 09:06:22PM -0700, Mitchell Blank Jr escreveu:
> Andi Kleen wrote:
> > - it doesn't seem to help that much on modern CPUs with good
> > branch prediction and big icaches anyways.
> 
> Really?  I would think that as pipelines get deeper (although that trend
> seems to have stopped, thankfully) and Icache-miss penalties get relatively
> larger we'd see unlikely() becoming MORE of a benefit, not less.  Storing
> the used part of a "hot" function in 1 Icacheline instead of 4 seems like
> an obvious win.
> 
> Personally I've never found unlikely() to be ugly; if anything I think
> it serves as a nice little human-readable comment about whats going on
> in the control-flow.  I guess I'm in the minority on that one, though.

Hey, even if unlikely was:

#define unlikely(x) (x)

I'd find it useful :-)

- Arnaldo
