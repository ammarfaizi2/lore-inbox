Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291983AbSBNXoJ>; Thu, 14 Feb 2002 18:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291987AbSBNXn7>; Thu, 14 Feb 2002 18:43:59 -0500
Received: from coruscant.franken.de ([193.174.159.226]:52919 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S291985AbSBNXnr>; Thu, 14 Feb 2002 18:43:47 -0500
Date: Fri, 15 Feb 2002 00:31:51 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Nick Craig-Wood <ncw@axis.demon.co.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        netfilter-devel@lists.samba.org
Subject: Re: 2.4.18-pre9: iptables screwed?
Message-ID: <20020215003151.T28092@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@gnumonks.org>,
	Nick Craig-Wood <ncw@axis.demon.co.uk>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	netfilter-devel@lists.samba.org
In-Reply-To: <a3vjts$r7l$1@cesium.transmeta.com> <20020208094649.J26676@sunbeam.de.gnumonks.org> <20020214161225.A2867@axis.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20020214161225.A2867@axis.demon.co.uk>; from ncw@axis.demon.co.uk on Thu, Feb 14, 2002 at 04:12:25PM +0000
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.17
X-Date: Today is Prickle-Prickle, the 44th day of Chaos in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2002 at 04:12:25PM +0000, Nick Craig-Wood wrote:

> > > sudo iptables-restore < /etc/sysconfig/iptables
> > > iptables-restore: libiptc/libip4tc.c:384: do_check: Assertion
> > > `h->info.valid_hooks == (1 << 0 | 1 << 3)' failed.
> > > Abort (core dumped)
> 
> I've noticed this too.
> 
> Apologies if this info is too late but I didn't see a followup to
> lkml.

The redhat iptables package has debugging enabled, and the debugging
code does not cope correctly with the new kernels.

We didn't assume that anybody is running debugging-enabled old iptables
versions on production systems, but I guess some unfortunate coincidence
caused this within the redhat package :(

> Nick Craig-Wood
> ncw@axis.demon.co.uk

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M+ 
V-- PS++ PE-- Y++ PGP++ t+ 5-- !X !R tv-- b+++ !DI !D G+ e* h--- r++ y+(*)
