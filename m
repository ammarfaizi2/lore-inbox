Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269251AbUIIAn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269251AbUIIAn0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 20:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269252AbUIIAn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 20:43:26 -0400
Received: from holomorphy.com ([207.189.100.168]:20652 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269251AbUIIAnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 20:43:25 -0400
Date: Wed, 8 Sep 2004 17:43:20 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Albert Cahalan <albert@users.sf.net>, Paul Jackson <pj@sgi.com>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040909004320.GJ3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Roger Luethi <rl@hellgate.ch>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
	Paul Jackson <pj@sgi.com>
References: <20040908184028.GA10840@k3.hellgate.ch> <20040908184130.GA12691@k3.hellgate.ch> <20040909003529.GI3106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909003529.GI3106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 05:35:29PM -0700, William Lee Irwin III wrote:
> Any chance you could convert these to use the new vm statistics
> accounting?

Hmm, there's a more serious issue; CONFIG_MMU=n will barf on these.
For that you will need to #ifdef on CONFIG_MMU and use the methods
in fs/proc/task_nommu.c and so on.


-- wli
