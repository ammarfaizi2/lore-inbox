Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbUAPFpR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 00:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265274AbUAPFpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 00:45:17 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:36842 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S265269AbUAPFpO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 00:45:14 -0500
Date: Thu, 15 Jan 2004 21:44:49 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 NFS-server low to 0 performance
Message-ID: <20040116054449.GH1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0401101143280.2363-100000@poirot.grange> <1073745028.1146.13.camel@nidelv.trondhjem.org> <btt971$3p8$1@gatekeeper.tmr.com> <1073917652.1639.21.camel@nidelv.trondhjem.org> <1073920323.1639.28.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073920323.1639.28.camel@nidelv.trondhjem.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 12, 2004 at 10:12:03AM -0500, Trond Myklebust wrote:
> 
> > The 8k limit that you find in RFC1094 was an ad-hoc "limit" based purely
> > on testing using pre-1989 hardware. AFAIK most if not all of the
> > commercial vendors (Solaris, AIX, Windows/Hummingbird, EMC and Netapp)
> > are all currently setting the defaults to 32k block sizes for both TCP
> > and UDP.
> > Most of them want to bump that to a couple of Mbyte in the very near
> > future.
> 
> Note: the future Mbyte sizes can, of course, only be supported on TCP
> since UDP has an inherent limit at 64k. The de-facto limit on UDP is
> therefore likely to remain at 32k (although I think at least one vendor
> has already tried pushing it to 48k).

Does the RPC max size limit change with memory or filesystem?

I have one system (K7 2200, 1.5GB, ext3) where it uses 32K RPCs, and another
(P2 300, 168MB, reiserfs3) and it uses 8k RPCs, even if I request larger max
sizes, and they're both running 2.6.1-bk2.

Strange...
