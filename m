Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269102AbUIXUD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269102AbUIXUD6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 16:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269105AbUIXUD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 16:03:57 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:52121 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269102AbUIXUDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 16:03:30 -0400
Subject: Re: [PROPOSAL/PATCH] Fortuna PRNG in /dev/random
From: Lee Revell <rlrevell@joe-job.com>
To: James Morris <jmorris@redhat.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Jean-Luc Cooke <jlcooke@certainkey.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, mpm@selenic.com
In-Reply-To: <Xine.LNX.4.44.0409241440410.8732-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0409241440410.8732-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1096056208.11589.8.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 24 Sep 2004 16:03:29 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-24 at 14:43, James Morris wrote:
> On Fri, 24 Sep 2004, Theodore Ts'o wrote:
> 
> > have *any* encryption algorithms in the kernel at all.  As to whether
> > or not cryptoapi needs to be mandatory in the kernel, the question is
> > aside from /dev/random, do most people need to have crypto in the
> > kernel?  If they're not using ipsec, or crypto loop devices, etc.,
> > they might not want to have the crypto api in their kernel
> > unconditionally.
> 
> As far as I know embedded folk do not want the crypto API to be mandatory,
> although I think Matt Mackall wanted to try and make something work
> (perhaps a subset just for /dev/random use).

/dev/random used to be a source of high latencies, but Ingo's patches 
fix this.  There was not a lot of CPU overhead but the latency was was a
problem for serious audio use.  But, audio is a unique set of
requirements, it's somewhere between desktop and embedded and hard-RT.

This could certainly be a problem for the embedded folks due to space or
CPU concerns, but the latency problem seems to be solved.

Lee  

