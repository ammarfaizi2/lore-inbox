Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbVIDUjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbVIDUjY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 16:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbVIDUjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 16:39:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53131 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751171AbVIDUjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 16:39:23 -0400
Date: Sun, 4 Sep 2005 16:37:25 -0400
From: Dave Jones <davej@redhat.com>
To: Bas Westerbaan <bas.westerbaan@gmail.com>
Cc: Adrian Bunk <bunk@stusta.de>, Pekka Enberg <penberg@cs.helsinki.fi>,
       Paul Misner <paul@misner.org>, linux-kernel@vger.kernel.org
Subject: Re: RFC: i386: kill !4KSTACKS
Message-ID: <20050904203725.GB4715@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Bas Westerbaan <bas.westerbaan@gmail.com>,
	Adrian Bunk <bunk@stusta.de>, Pekka Enberg <penberg@cs.helsinki.fi>,
	Paul Misner <paul@misner.org>, linux-kernel@vger.kernel.org
References: <20050902060830.84977.qmail@web50208.mail.yahoo.com> <200509041549.17512.vda@ilport.com.ua> <200509041144.13145.paul@misner.org> <84144f02050904100721d3844d@mail.gmail.com> <6880bed305090410127f82a59f@mail.gmail.com> <20050904193350.GA3741@stusta.de> <6880bed305090413132c37fed3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6880bed305090413132c37fed3@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2005 at 10:13:10PM +0200, Bas Westerbaan wrote:
 > > > Though 4K stacks are used a lot, they probably aren't used on all
 > > > configurations yet. Other situations may arise where 8K stacks may be
 > > > preferred. It is too early to kill 8K stacks imho.
 > > 
 > > Please name situations where 8K stacks may be preferred that do not
 > > involve binary-only modules.
 > 
 > I meant that there could be situations, which have not yet been found,

And the boogeyman might really exist too.
This is just hypotetical hand-waving.

 > where it could be preferred to use 8K stacks instead of 4K. When you
 > switch from having 8K stacks as default to 4K stacks without
 > possibility for 8K stacks you'd possibly encounter these yet to be
 > found situations.

Fedora kernels have been built with 4K stacks for a long time.
(Since even before the option went upstream). The only things that
have been reported to have problems with 4KB stacks are..

- NDISwrapper / driverloader.
  (Shock, horror - no-one cares).
- XFS when used in conjunction with RAID
  Fixed now ?  (Though Neil Brown does have a pending patch for md
  to make that use less stack, which will also help).
- Reiser4
  Fixed 'soon'.

 > When on the other hand the 4K stacks are set as default, leaving the
 > option in, instead of removing it, these possible situations, when
 > found, could be resolved (temporarilly) by switching back to 8K
 > stacks.
 > 
 > After a while having 4K stacks as default would be a better time to
 > decide whether to remove the option or not instead of now.

This is what was proposed not long after the option got merged.
"After a while" has passed by quite a stretch.

		Dave

