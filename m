Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269344AbUIIB1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269344AbUIIB1J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 21:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269329AbUIIBYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 21:24:25 -0400
Received: from holomorphy.com ([207.189.100.168]:41900 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269333AbUIIBWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 21:22:35 -0400
Date: Wed, 8 Sep 2004 18:22:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Albert Cahalan <albert@users.sf.net>, Paul Jackson <pj@sgi.com>
Subject: Re: [2/2] handle CONFIG_MMU=n and use new vm stats for CONFIG_MMU=y
Message-ID: <20040909012229.GN3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Roger Luethi <rl@hellgate.ch>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
	Paul Jackson <pj@sgi.com>
References: <20040908184028.GA10840@k3.hellgate.ch> <20040908184130.GA12691@k3.hellgate.ch> <20040909003529.GI3106@holomorphy.com> <20040909004320.GJ3106@holomorphy.com> <20040909011549.GK3106@holomorphy.com> <20040909011708.GL3106@holomorphy.com> <20040909012137.GM3106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909012137.GM3106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 06:21:37PM -0700, William Lee Irwin III wrote:
> Make __task_mem() and __task_mem_cheap() use the appropriate methods
> for CONFIG_MMU=y and add some attempt at correct code for CONFIG_MMU=n.
> The new methods for /proc/ accounting involve using counters kept in
> the mm instead of iteration over vmas. For the CONFIG_MMU=y case this
> does not involve acquiring mm->mmap_sem for any per-mm statistics. The
> CONFIG_MMU=n case still needs iteration over tblocks to calculate them.

Once again, compiletested only on ia64.


-- wli
