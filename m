Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318558AbSHAAdn>; Wed, 31 Jul 2002 20:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318563AbSHAAdn>; Wed, 31 Jul 2002 20:33:43 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:48050 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S318558AbSHAAdm>; Wed, 31 Jul 2002 20:33:42 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Bill Davidsen <davidsen@tmr.com>
Date: Thu, 1 Aug 2002 10:34:23 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15688.33295.630127.361498@notabene.cse.unsw.edu.au>
Cc: Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6] The List, pass #2
In-Reply-To: message from Bill Davidsen on Wednesday July 31
References: <3D3761A9.23960.8EB1A2@localhost>
	<Pine.LNX.3.96.1020731133038.10066A-100000@gatekeeper.tmr.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday July 31, davidsen@tmr.com wrote:
> 
> >   o Add support for NFS v4
> 
> Sorry to repeat, this seems to be a feature which will be in many if not
> most other systems before any possible release date for 2.8. Is it really
> that far out? (that's a status request, not a statement)
> 

Well, given that the protocol specification isn't 100% finalised, it's
not clear that pushing for inclusion now is entirely sensible.  We
don't want people to be using an NFSv4 on Linux that is incompatible
in some subtle way with other vendors.

Also, I suspect that NFSv4 will be fairly localised in the changes it
makes and could well go in to 2.6.10 of whatever (afterall, reiserfs
went in at 2.4.2).

There are some changes that NFSv4 would like to make that affect
common code, such as making open(,O_EXCL) work for a networked
filesystem, but we can live without that (as we do with NFSv3), but
hopefully that functionality will get in before halloween anyway. 


My understanding is that the CITI team will be funneling some of their
NFSv4 code though the maintainers (Trond and myself) to at least get
some of the code into 2.5.  This will likely not include support for
all the fancy state and locking, but will support the well established
aspects of the protocol and will allow minimal operability.  This will
also mean there is a clear base in the mainline kernel for other bits
to be added as appropriate.
Obviously we will clarify the license before forwarding to Linus.

I'm particularly keen to get the crypto authentication stuff in and I
will be looking into that RealSoonNow.

NeilBrown
