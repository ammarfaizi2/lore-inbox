Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262857AbRE3WS3>; Wed, 30 May 2001 18:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262856AbRE3WST>; Wed, 30 May 2001 18:18:19 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:50948 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S262855AbRE3WSD>;
	Wed, 30 May 2001 18:18:03 -0400
Date: Wed, 30 May 2001 18:20:12 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Harald Welte <laforge@gnumonks.org>
Cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: Remaining undocumented Configure.help symbols
Message-ID: <20010530182012.D1305@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Harald Welte <laforge@gnumonks.org>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010529145940.A11498@thyrsus.com> <20010530185542.R14293@corellia.laforge.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010530185542.R14293@corellia.laforge.distro.conectiva>; from laforge@gnumonks.org on Wed, May 30, 2001 at 06:55:42PM -0300
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Welte <laforge@gnumonks.org>:
> On Tue, May 29, 2001 at 02:59:40PM -0400, Eric S. Raymond wrote:
> 
> > CONFIG_NET_CLS_TCINDEX
> 
>   If you say Y here, you will be able to classify outgoing packets 
>   according to the tc_index field of the skb. You will want this 
>   feature if you want to implement Differentiates Services useing
>   sch_dsmark. If unsure, say Y.
> 
>   This code is also available as a module called cls_tcindex.o ( = code
>   which can be inserted in and removed from the running kernel
>   whenever you want). If you want to compile it as a module, say MM
>   here and read Documentation/modules.txt

Looks good.
 
> > CONFIG_NET_SCH_INGRESS
> 
>   If you say Y here, you will be able to police incoming bandwidth
>   and drop packets when this bandwidth exceeds your desired rate.
>   If unsure, say Y.
> 
>   This code is also available as a module called cls_tcindex.o ( = code
>   which can be inserted in and removed from the running kernel
>   whenever you want). If you want to compile it as a module, say MM
>   here and read Documentation/modules.txt

I'm going to assume that the cls_tcindex.o in the second entry is a 
cut'n'paste error and should read sch_ingress.o.

Should the CLS_POLICE entry, then, read like this?

Traffic policing (needed for in/egress)
CONFIG_NET_CLS_POLICE
   Say Y to support traffic policing (bandwidth limits).  Needed for ingress
   and egress rate limiting.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

A ``decay in the social contract'' is detectable; there is a growing
feeling, particularly among middle-income taxpayers, that they are not
getting back, from society and government, their money's worth for
taxes paid. The tendency is for taxpayers to try to take more control
of their finances ..
	-- IRS Strategic Plan, (May 1984)
