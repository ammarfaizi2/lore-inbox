Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbVBKCKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVBKCKV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 21:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVBKCKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 21:10:21 -0500
Received: from waste.org ([216.27.176.166]:24232 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262060AbVBKCKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 21:10:15 -0500
Date: Thu, 10 Feb 2005 18:09:56 -0800
From: Matt Mackall <mpm@selenic.com>
To: Chris Wright <chrisw@osdl.org>
Cc: "Jack O'Quin" <jack.oquin@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, rlrevell@joe-job.com,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.11-rc3-mm2
Message-ID: <20050211020956.GC15058@waste.org>
References: <a075431a050210125145d51e8c@mail.gmail.com> <20050211000425.GC2474@waste.org> <20050210164727.M24171@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050210164727.M24171@build.pdx.osdl.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2005 at 04:47:27PM -0800, Chris Wright wrote:
> * Matt Mackall (mpm@selenic.com) wrote:
> > What happened to the RT rlimit code from Chris?
> 
> I still have it, but I had the impression Ingo didn't like it as a long
> term solution/hack (albeit small) to the scheduler.  Whereas the rt-lsm
> patch is wholly self-contained.

I think it's important to recognize that we're trying to address an
issue that has a much wider potential audience than pro audio users,
and not very far off - what is high end audio performance today will be
expected desktop performance next year.

So I think it's critical that we find solution that's appropriate for
_every single box_, because realistically vendors are going to ship
with this "wholly self-contained" feature turned on by default next
year, at which point the "containment" will be nil and whatever warts
it has will be with us forever.

The rlimit stuff is not perfect, but it's a much better fit for the
UNIX model generally, which is a fairly big win. Having it in the
system unconditionally doesn't trigger the gag reflex in quite the
same way as the LSM approach.

-- 
Mathematics is the supreme nostalgia of our time.
