Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268439AbUILFAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268439AbUILFAb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 01:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268445AbUILFAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 01:00:31 -0400
Received: from holomorphy.com ([207.189.100.168]:10371 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268439AbUILFAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 01:00:23 -0400
Date: Sat, 11 Sep 2004 22:00:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: Roger Luethi <rl@hellgate.ch>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton OSDL <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>,
       James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040912050013.GC2660@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>, Roger Luethi <rl@hellgate.ch>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	Andrew Morton OSDL <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Albert Cahalan <albert@users.sourceforge.net>,
	"Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>,
	James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>
References: <20040908184130.GA12691@k3.hellgate.ch> <1094730811.22014.8.camel@moss-spartans.epoch.ncsc.mil> <20040909172200.GX3106@holomorphy.com> <20040909175342.GA27518@k3.hellgate.ch> <1094760065.22014.328.camel@moss-spartans.epoch.ncsc.mil> <20040909205531.GA17088@k3.hellgate.ch> <20040909212507.GA32276@k3.hellgate.ch> <1094942212.1174.20.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094942212.1174.20.camel@cube>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-09 at 17:25, Roger Luethi wrote:
>> I forgot to mention that you can see the remnants of that approach in
>> <linux/nproc.h>: I used two bits of the field ID to define per-field
>> access restrictions (NPROC_PERM_USER, NPROC_PERM_ROOT).

On Sat, Sep 11, 2004 at 06:36:53PM -0400, Albert Cahalan wrote:
> Besides the low-security and high-security choices,
> I'd like to see a medium-security choice.
> low: everybody sees everything
> medium: everybody sees something; privileged user sees all
> high: must be privileged
> This might mean that asking for stuff like EIP and WCHAN
> causes you to see fewer processes.
> If partial info is returned for a process, I'd like to
> also get a bitmap of valid fields. Special "not valid"
> values are a pain to deal with.

That's an interesting observation. Perhaps the union of the mmu and
nommu fields should be nominally reported alongside a bitmap of the
useful fields?


-- wli
