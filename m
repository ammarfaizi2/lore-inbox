Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288111AbSACDOK>; Wed, 2 Jan 2002 22:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288156AbSACDNu>; Wed, 2 Jan 2002 22:13:50 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:6417 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S288111AbSACDNm>;
	Wed, 2 Jan 2002 22:13:42 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15411.52243.87016.442521@argo.ozlabs.ibm.com>
Date: Thu, 3 Jan 2002 14:12:19 +1100 (EST)
To: Joe Buck <jbuck@synopsys.COM>
Cc: dewar@gnat.com, velco@fadata.bg, gcc@gcc.gnu.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org,
        trini@kernel.crashing.org
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <200201022359.PAA05815@atrus.synopsys.com>
In-Reply-To: <20020102235318.26F2FF2EC7@nile.gnat.com>
	<200201022359.PAA05815@atrus.synopsys.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Buck writes:

> There is already such a project under development: see
> 
> http://gcc.gnu.org/projects/bp/main.html
> 
> This is a modification to gcc that implements pointers as triples.
> While there is a performance penalty for doing this, it can completely
> eliminate the problem of exploitable buffer overflows.  However, programs
> that violate the rules of ISO C by generating out-of-range pointers will
> fail.

What will it do if I cast a pointer to unsigned long?  Or if I cast an
unsigned long to a pointer?  The kernel does both of these things, and
in a lot of places.

Part of my beef with what gcc-3 is doing is that I take a pointer,
cast it to unsigned long, do something to it, cast it back to a
pointer, and gcc _still_ thinks it's knows what I am doing.  It
doesn't.

Paul.
