Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbVHKA2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbVHKA2n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 20:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbVHKA2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 20:28:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:48606 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964948AbVHKA2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 20:28:42 -0400
Date: Thu, 11 Aug 2005 02:28:41 +0200
From: Andi Kleen <ak@suse.de>
To: yhlu <yhlu.kernel@gmail.com>
Cc: Andi Kleen <ak@suse.de>, Mike Waychison <mikew@google.com>,
       YhLu <YhLu@tyan.com>, Peter Buckingham <peter@pantasys.com>,
       linux-kernel@vger.kernel.org, "discuss@x86-64.org" <discuss@x86-64.org>
Subject: Re: [discuss] Re: 2.6.13-rc2 with dual way dual core ck804 MB
Message-ID: <20050811002841.GE8974@wotan.suse.de>
References: <3174569B9743D511922F00A0C94314230AF97867@TYANWEB> <42FA8A4B.4090408@google.com> <20050810232614.GC27628@wotan.suse.de> <86802c4405081016421db9baa5@mail.gmail.com> <20050811000430.GD8974@wotan.suse.de> <86802c4405081017174c22dcd5@mail.gmail.com> <86802c440508101723d4aadef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86802c440508101723d4aadef@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 05:23:31PM -0700, yhlu wrote:
> I wonder if you can make the bsp can start the APs callin in the same
> time, and make it asynchronous, So you make spare 2s or more.

The setting of cpu_callin_map in the AP could be moved earlier yes.
But it's not entirely trivial because there are some races to consider.

And the 1s quiet period on the AP could be probably also reduced
on modern systems. I doubt it is needed on Xeons or Opterons.

-Andi
