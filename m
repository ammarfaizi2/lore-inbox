Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbVBKCWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbVBKCWp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 21:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVBKCWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 21:22:45 -0500
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:46481 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262059AbVBKCWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 21:22:42 -0500
Subject: Re: 2.6.11-rc3-mm2
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Matt Mackall <mpm@selenic.com>
Cc: Chris Wright <chrisw@osdl.org>, "Jack O'Quin" <jack.oquin@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, rlrevell@joe-job.com,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050211020956.GC15058@waste.org>
References: <a075431a050210125145d51e8c@mail.gmail.com>
	 <20050211000425.GC2474@waste.org>
	 <20050210164727.M24171@build.pdx.osdl.net>
	 <20050211020956.GC15058@waste.org>
Content-Type: text/plain
Date: Fri, 11 Feb 2005 13:22:36 +1100
Message-Id: <1108088557.5098.28.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-10 at 18:09 -0800, Matt Mackall wrote:
> On Thu, Feb 10, 2005 at 04:47:27PM -0800, Chris Wright wrote:
> > * Matt Mackall (mpm@selenic.com) wrote:
> > > What happened to the RT rlimit code from Chris?
> > 
> > I still have it, but I had the impression Ingo didn't like it as a long
> > term solution/hack (albeit small) to the scheduler.  Whereas the rt-lsm
> > patch is wholly self-contained.
> 
> I think it's important to recognize that we're trying to address an
> issue that has a much wider potential audience than pro audio users,
> and not very far off - what is high end audio performance today will be
> expected desktop performance next year.
> 
> So I think it's critical that we find solution that's appropriate for
> _every single box_, because realistically vendors are going to ship
> with this "wholly self-contained" feature turned on by default next
> year, at which point the "containment" will be nil and whatever warts
> it has will be with us forever.
> 
> The rlimit stuff is not perfect, but it's a much better fit for the
> UNIX model generally, which is a fairly big win. Having it in the
> system unconditionally doesn't trigger the gag reflex in quite the
> same way as the LSM approach.
> 

Without considering the userspace aspect, RT rlimits is the best
implementation I have seen. All others either break RT scheduling
semantics, or don't allow any way for root to maintain control of
the system after giving out RT privileges.


http://mobile.yahoo.com.au - Yahoo! Mobile
- Check & compose your email via SMS on your Telstra or Vodafone mobile.
