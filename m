Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265800AbUHSCvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbUHSCvP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 22:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267893AbUHSCvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 22:51:15 -0400
Received: from holomorphy.com ([207.189.100.168]:29884 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267918AbUHSCvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 22:51:11 -0400
Date: Wed, 18 Aug 2004 19:51:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>
Cc: pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Does io_remap_page_range() take 5 or 6 args?
Message-ID: <20040819025102.GZ11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>, pj@sgi.com,
	linux-kernel@vger.kernel.org
References: <20040818135638.4326ca02.davem@redhat.com> <20040818210503.GG11200@holomorphy.com> <20040818143029.23db8740.davem@redhat.com> <20040818214026.GL11200@holomorphy.com> <20040818220001.GN11200@holomorphy.com> <20040818225915.GQ11200@holomorphy.com> <20040818161658.49aa8de3.davem@redhat.com> <20040818233324.GT11200@holomorphy.com> <20040819023848.GY11200@holomorphy.com> <20040818194313.385f4d2f.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040818194313.385f4d2f.davem@redhat.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2004 19:38:48 -0700 William Lee Irwin III wrote:
>> Oddly, the sparc64 case seems to be the most difficult one for the
>> io_remap_page_range() sweep...

On Wed, Aug 18, 2004 at 07:43:13PM -0700, David S. Miller wrote:
> Oh yeah, that's due to the large TLB mapping support
> isn't it?

It could be ... most of the pain was centered around testing bits
inside of offset & ~PAGE_MASK, which, when the physical address offset
corresponds to is recovered from a pfn, are necessarily all zero.


-- wli
