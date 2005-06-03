Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVFCQM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVFCQM3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 12:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVFCQM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 12:12:29 -0400
Received: from colin.muc.de ([193.149.48.1]:33797 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261334AbVFCQM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 12:12:26 -0400
Date: 3 Jun 2005 18:12:25 +0200
Date: Fri, 3 Jun 2005 18:12:25 +0200
From: Andi Kleen <ak@muc.de>
To: YhLu <YhLu@tyan.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5 is broken in nvidia Ck804 Opteron MB/with dual cor e dual way
Message-ID: <20050603161225.GI1683@muc.de>
References: <3174569B9743D511922F00A0C94314230A40399E@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C94314230A40399E@TYANWEB>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 02:33:06PM -0700, YhLu wrote:
> So siblings should be in one core...? that make sense....

Yes. The whole terminology is confusing for historical reasons.
If we started again with the naming game there would be probably 
different names.

To make it even more confusing while it is different internally
in the kernel, CPUID and /proc/cpuinfo fake them to the same
to the world to be compatible with old software who e.g.
reads this for licensing purposes.

BTW I doubt these are related to the hang you are chasing
because if you grep the kernel cpu_core_map is never used
in the kernel at all except for cpuinfo. This means
it is unlikely to cause any hangs.

-Andi
