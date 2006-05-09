Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbWEIGQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbWEIGQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 02:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWEIGQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 02:16:28 -0400
Received: from dvhart.com ([64.146.134.43]:37858 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751410AbWEIGQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 02:16:28 -0400
Message-ID: <446033B4.4070500@mbligh.org>
Date: Mon, 08 May 2006 23:16:20 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Linus Torvalds <torvalds@osdl.org>,
       Daniel Hokka Zakrisson <daniel@hozac.com>, linux-kernel@vger.kernel.org,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       greg@kroah.com, matthew@wil.cx, manfred@colorfullife.com, akpm@osdl.org,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] fs: fcntl_setlease defies lease_init assumptions
References: <445E80DD.9090507@hozac.com>  <Pine.LNX.4.64.0605072030280.3718@g5.osdl.org>  <84144f020605080131r58ce2a93w6c7ba784a266bbeb@mail.gmail.com>  <84144f020605080134q7e16f37fl385359c634ece8ca@mail.gmail.com>  <Pine.LNX.4.64.0605080807430.3718@g5.osdl.org>  <1147104412.22096.8.camel@localhost>  <Pine.LNX.4.64.0605080913240.3718@g5.osdl.org> <1147116991.11282.3.camel@localhost> <Pine.LNX.4.64.0605082031580.23431@schroedinger.engr.sgi.com> <4460113C.9090609@mbligh.org> <Pine.LNX.4.64.0605082230310.23795@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0605082230310.23795@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Mon, 8 May 2006, Martin J. Bligh wrote:
> 
> 
>>Can't you use sparsemem instead? It solves the same problem without the
>>magic faulting, doesn't it?
> 
> 
> But sparsemem has more complex table lookups. Ultimately IA64 will move 
> to sparsemem (I think) but we are not there yet and we would like to be 
> sure that there are no performance regressions with that move.

Please explain your concerns in more detail re complexity. I was under
the impression the design avoided that nicely by folding the
calculations together down into a single layer.

It's been around for a long time now ... has nobody tested the
performance on ia64 yet?

M.
