Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269245AbUIIAfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269245AbUIIAfs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 20:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269247AbUIIAfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 20:35:48 -0400
Received: from holomorphy.com ([207.189.100.168]:15532 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269245AbUIIAfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 20:35:47 -0400
Date: Wed, 8 Sep 2004 17:35:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Albert Cahalan <albert@users.sf.net>, Paul Jackson <pj@sgi.com>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040909003529.GI3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Roger Luethi <rl@hellgate.ch>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
	Paul Jackson <pj@sgi.com>
References: <20040908184028.GA10840@k3.hellgate.ch> <20040908184130.GA12691@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908184130.GA12691@k3.hellgate.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 08:41:30PM +0200, Roger Luethi wrote:
> A few notes:
> - Access control can be implemented easily. Right now it would be bloat,
>   though -- the vast majority of fields in /proc are world-readable
>   (/proc/pid/environ being the notable exception).
> - Additional process selectors (e.g. select by UID) are not hard to
>   add, either, should there ever be a need.
> - There are a few things I'm not sure about: For instance, what is a good
>   return value for mm_struct related fields wrt kernel threads? I picked
>   0, but ~(0) might be preferable because it's distinct.
> Signed-off-by: Roger Luethi <rl@hellgate.ch>

Any chance you could convert these to use the new vm statistics
accounting?


-- wli
