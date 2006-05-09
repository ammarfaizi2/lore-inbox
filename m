Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWEIFcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWEIFcR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 01:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWEIFcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 01:32:16 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:51604 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750930AbWEIFcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 01:32:16 -0400
Date: Mon, 8 May 2006 22:31:57 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
cc: Pekka Enberg <penberg@cs.helsinki.fi>, Linus Torvalds <torvalds@osdl.org>,
       Daniel Hokka Zakrisson <daniel@hozac.com>, linux-kernel@vger.kernel.org,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       greg@kroah.com, matthew@wil.cx, manfred@colorfullife.com, akpm@osdl.org
Subject: Re: [PATCH] fs: fcntl_setlease defies lease_init assumptions
In-Reply-To: <4460113C.9090609@mbligh.org>
Message-ID: <Pine.LNX.4.64.0605082230310.23795@schroedinger.engr.sgi.com>
References: <445E80DD.9090507@hozac.com>  <Pine.LNX.4.64.0605072030280.3718@g5.osdl.org>
  <84144f020605080131r58ce2a93w6c7ba784a266bbeb@mail.gmail.com> 
 <84144f020605080134q7e16f37fl385359c634ece8ca@mail.gmail.com> 
 <Pine.LNX.4.64.0605080807430.3718@g5.osdl.org>  <1147104412.22096.8.camel@localhost>
  <Pine.LNX.4.64.0605080913240.3718@g5.osdl.org> <1147116991.11282.3.camel@localhost>
 <Pine.LNX.4.64.0605082031580.23431@schroedinger.engr.sgi.com>
 <4460113C.9090609@mbligh.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 May 2006, Martin J. Bligh wrote:

> Can't you use sparsemem instead? It solves the same problem without the
> magic faulting, doesn't it?

But sparsemem has more complex table lookups. Ultimately IA64 will move 
to sparsemem (I think) but we are not there yet and we would like to be 
sure that there are no performance regressions with that move.

