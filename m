Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbTFGAa6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 20:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbTFGAa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 20:30:57 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62482 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262424AbTFGAa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 20:30:56 -0400
Date: Fri, 6 Jun 2003 17:43:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Mackerras <paulus@samba.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: __user annotations
In-Reply-To: <16097.12932.161268.783738@argo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.44.0306061738200.31112-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 7 Jun 2003, Paul Mackerras wrote:
> Linus Torvalds writes:
> 
> > You can get check from
> > 
> > 	bk://kernel.bkbits.net/torvalds/sparse
> 
> Is that up to date?  I cloned that repository and said "make" and got
> heaps of compile errors.  First there were a heap of warnings like
> this:

You need to have a modern compiler. The "heaps of errors" is what you get 
if you use a stone-age compiler that doesn't support anonymous structure 
and union members or other C99 features.

Gcc has supported them since some pre-3.x version (which is pretty late,
since they've been around in other compilers for much longer). They are a
great way to make readable data structures that have internal structure
_without_ having to have that structure show up unnecessarily in usage.

		Linus

