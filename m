Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290625AbSBSWRl>; Tue, 19 Feb 2002 17:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290627AbSBSWRc>; Tue, 19 Feb 2002 17:17:32 -0500
Received: from rj.SGI.COM ([204.94.215.100]:13037 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S290625AbSBSWRT>;
	Tue, 19 Feb 2002 17:17:19 -0500
Date: Tue, 19 Feb 2002 14:17:04 -0800
From: Jesse Barnes <jbarnes@sgi.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: David Mosberger <davidm@hpl.hp.com>, Dan Maas <dmaas@dcine.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ben Collins <bcollins@debian.org>
Subject: Re: readl/writel and memory barriers
Message-ID: <20020219141704.B1510654@sgi.com>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	David Mosberger <davidm@hpl.hp.com>, Dan Maas <dmaas@dcine.com>,
	linux-kernel@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ben Collins <bcollins@debian.org>
In-Reply-To: <20020219103506.A1511175@sgi.com> <13997.1014156337@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13997.1014156337@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2002 at 09:05:37AM +1100, Keith Owens wrote:
> On Tue, 19 Feb 2002 10:35:06 -0800, 
> Jesse Barnes <jbarnes@sgi.com> wrote:
> >Making a variable volatile doesn't guarantee that the compiler won't
> >reorder references to it, AFAIK.
> 
> Ignoring the issue of hardware that reorders I/O, volatile accesses
> must not be reordered by the compiler.  From a C9X draft (1999, anybody
> have the current C standard online?) :-

Of course volatile references must be ordered wrt each other, but a
reference to a volatile doesn't preclude the compiler from moving it
above or below accesses to other variables.  That is, it doesn't act
as an optimization barrier.  Sound right?  I guess I'm getting a
little off-topic here...

Jesse
