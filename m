Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263221AbREaUnZ>; Thu, 31 May 2001 16:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263219AbREaUnP>; Thu, 31 May 2001 16:43:15 -0400
Received: from sovereign.org ([209.180.91.170]:23255 "EHLO lux.homenet")
	by vger.kernel.org with ESMTP id <S263221AbREaUnC>;
	Thu, 31 May 2001 16:43:02 -0400
From: Jim Freeman <jfree@sovereign.org>
Date: Thu, 31 May 2001 14:43:28 -0600
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: Remaining undocumented Configure.help symbols
Message-ID: <20010531144328.A16811@sovereign.org>
In-Reply-To: <20010529145940.A11498@thyrsus.com> <20010530185542.R14293@corellia.laforge.distro.conectiva> <20010530182012.D1305@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010530182012.D1305@thyrsus.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The verbiage in these entries seems 'make config' / text-interaction
-centric.  Granted, that's likely the context most kernel builders will
use, but it would seem fair to at least consider a broader audience
who may be using more gui-ish tools wrapped around extant content.

For instance, a click-a-node-to-choose-an-option-gui or click-a-box-to
-choose-an-option-set-and-optionally-drill-down-to-details-gui would
probably (when asked) present the Configure.help entry for a given
option, but the  "If you say Y here ... If unsure say Y"  wording would
not be apropos in such a presentation context.  

Something akin to "Select this option to enable classification of egress
traffic based on ..." might serve differing presentation modes more
adequately.

...jfree
========
On Wed, May 30, 2001 at 06:20:12PM -0400, Eric S. Raymond wrote:
> Harald Welte <laforge@gnumonks.org>:
> > On Tue, May 29, 2001 at 02:59:40PM -0400, Eric S. Raymond wrote:
> > 
> > > CONFIG_NET_CLS_TCINDEX
> > 
> >   If you say Y here, you will be able to classify outgoing packets 
> >   according to the tc_index field of the skb. You will want this 
> >   feature if you want to implement Differentiates Services useing
> >   sch_dsmark. If unsure, say Y.
> > 
> >   This code is also available as a module called cls_tcindex.o ( = code
> >   which can be inserted in and removed from the running kernel
> >   whenever you want). If you want to compile it as a module, say MM
> >   here and read Documentation/modules.txt
> 
> Looks good.
>  
> > > CONFIG_NET_SCH_INGRESS
> > 
> >   If you say Y here, you will be able to police incoming bandwidth
> >   and drop packets when this bandwidth exceeds your desired rate.
> >   If unsure, say Y.
> > 
> >   This code is also available as a module called cls_tcindex.o ( = code
> >   which can be inserted in and removed from the running kernel
> >   whenever you want). If you want to compile it as a module, say MM
> >   here and read Documentation/modules.txt
> 
> I'm going to assume that the cls_tcindex.o in the second entry is a 
> cut'n'paste error and should read sch_ingress.o.
> 
> Should the CLS_POLICE entry, then, read like this?
> 
> Traffic policing (needed for in/egress)
> CONFIG_NET_CLS_POLICE
>    Say Y to support traffic policing (bandwidth limits).  Needed for ingress
>    and egress rate limiting.
