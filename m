Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318920AbSHFANP>; Mon, 5 Aug 2002 20:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318942AbSHFANP>; Mon, 5 Aug 2002 20:13:15 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:60679 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S318920AbSHFANO>; Mon, 5 Aug 2002 20:13:14 -0400
Date: Mon, 5 Aug 2002 17:16:43 -0700
From: jw schultz <jw@pegasys.ws>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BIG files & file systems
Message-ID: <20020806001643.GC9754@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33L2.0208021507420.14068-100000@dragon.pdx.osdl.net> <1028552648.1251.26.camel@laptop.americas.sgi.com> <3D4E80BA.5040701@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D4E80BA.5040701@namesys.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2002 at 05:42:18PM +0400, Hans Reiser wrote:
> You might also mention that I think the limits imposed by Linux are the 
> only meaningful ones, as we would change our limits as soon as Linux 
> did, and it was Linux that selected our limits for us.  We would have 
> changed already if Linux didn't make it pointless to change it on Intel. 
> Reiser4 will have 64 bit blocknumbers that will be semi-pointless until 
> 64 bit CPUs are widely deployed, and I am simply guessing this will be 
> not very far into reiser4's lifecycle.  Really, the couple of #defines 
> that constitute these size limits, plus some surrounding code, are not 
> such a big thing to change (except that it constitutes a disk format 
> change).

Hans,

My recollection is that reiser4 isn't released yet.  Why not
set the reiser4 disk format with 64 bit blocknumbers from
dot?  32 bit archs could write zeros and otherwise ignore
the upper 32 bits and refuse to mount if filesystem size
would cause overflow.  That way you avoid on-disk format
change mid cycle.  That seems a lot less overhead than
coping with different datatypes.

Of course if you'd rather support another on-disk format
to squeeze a bit more data onto small drives i can understand.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
