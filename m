Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbUCJUq6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 15:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262819AbUCJUq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 15:46:58 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:44300 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262813AbUCJUq5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 15:46:57 -0500
Date: Wed, 10 Mar 2004 12:45:32 -0800
To: Jens Axboe <axboe@suse.de>
Cc: Kenneth Chen <kenneth.w.chen@intel.com>, "'Andrew Morton'" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, thornber@redhat.com
Subject: Re: [PATCH] backing dev unplugging
Message-ID: <20040310204532.GA10281@sgi.com>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	Kenneth Chen <kenneth.w.chen@intel.com>,
	'Andrew Morton' <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	thornber@redhat.com
References: <20040310115545.16cb387f.akpm@osdl.org> <200403102003.i2AK3qm16576@unix-os.sc.intel.com> <20040310202025.GH15087@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310202025.GH15087@suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 09:20:25PM +0100, Jens Axboe wrote:
> It'll be hard to apply the patch against anything but -mm, since it
> builds (or at least will conflict with) other changes in there. I
> deliberately made a -mm version this time though I usually make -linus
> and adapt if necessary, for Andrew to get some testing on this.

I tried applying to a BK tree (that was fresh as of a couple of hours
ago), and ignored the dm related changes, and it seemed to work ok after
I fixed up rejects in direct-io.c and blkdev.h (which didn't seem hard,
unless I'm missing something):

10 qla2200 fc controllers, 64 cpus, 112 disks

stock BK tree: ~43945 I/Os per second
w/Jens' patch: ~47149 I/Os per second

Jesse
