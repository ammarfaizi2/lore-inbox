Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263733AbUFXBwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263733AbUFXBwv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 21:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263731AbUFXBwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 21:52:51 -0400
Received: from holomorphy.com ([207.189.100.168]:55174 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263733AbUFXBwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 21:52:31 -0400
Date: Wed, 23 Jun 2004 18:52:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [oom]: [0/4] fix OOM deadlock running OAST
Message-ID: <20040624015229.GP1552@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040623223146.GG1552@holomorphy.com> <20040623153758.40e3a865.akpm@osdl.org> <20040623230730.GJ1552@holomorphy.com> <20040623163819.013c8585.akpm@osdl.org> <20040624000308.GK1552@holomorphy.com> <20040623171818.39b73d52.akpm@osdl.org> <20040624002651.GL1552@holomorphy.com> <20040624003249.GM1552@holomorphy.com> <20040623180722.69a8ea6f.akpm@osdl.org> <20040624012435.GN1552@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624012435.GN1552@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 06:07:22PM -0700, Andrew Morton wrote:
>> Well none, really.  This problem is now fixed, is it not?
>> It would be nice to fix up the unrelated issue of putting unbacked pages
>> onto the LRU.  Could do that by adding backing_dev_info.not_on_lru, check
>> that in the various places where we add pages to the LRU.
>> Or, conceivably, do it lazily: take these pages off the LRU if we encounter
>> them in page reclaim.  This might be a net win - do extra work for the rare
>> case, less work for the common case.
>> Something like this:

On Wed, Jun 23, 2004 at 06:24:35PM -0700, William Lee Irwin III wrote:
> To me, this resembles reworking the LRU removal bits. I'll flesh out
> the example you posted in the way you've suggested (via backing_dev_info).
> Thanks.

Also, you mentioned at one point extending committed memory accounting
to account for unreclaimable pages (the term you suggested). Would you
also like that to be looked into? It might take longer than overnight
to brew up, mostly due to testing turnaround.


-- wli
