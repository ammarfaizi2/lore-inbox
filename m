Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269289AbTGJO20 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 10:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269291AbTGJO20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 10:28:26 -0400
Received: from pasta.sw.starentnetworks.com ([12.33.234.10]:45525 "EHLO
	pasta.sw.starentnetworks.com") by vger.kernel.org with ESMTP
	id S269289AbTGJO2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 10:28:14 -0400
Date: Thu, 10 Jul 2003 10:42:53 -0400
From: Brian Ristuccia <bristucc@sw.starentnetworks.com>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rmap15j: sometimes processes stuck in state D, WCHAN 'down'
Message-ID: <20030710144253.GJ24907@sw.starentnetworks.com>
References: <20030703124813.GN24907@sw.starentnetworks.com> <Pine.LNX.4.44.0307032329190.8098-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307032329190.8098-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 11:30:09PM -0400, Rik van Riel wrote:
> On Thu, 3 Jul 2003, Brian Ristuccia wrote:
> 
> > Is anyone else seeing this problem with stock 2.4.21 or 2.4.21-rmap15j?
> 
> I haven't heard of anything like this.  Could you please get
> a backtrace of all the stuck processes with alt+sysrq+t and
> decode the backtraces with ksymoops ?
> 

This is actually the backtrace from ctrl-scrollock or whatever - the
machine where it happened didn't have magic sysrq. If the difference is
important, I can put a magic sysrq kernel everywhere and try to reproduce it
again. 

Jul 10 10:18:19 grunt1 kernel: ld            D D6E5C848     0 25131      1
25142 25147 (NOTLB)
Jul 10 10:18:19 grunt1 kernel: Call Trace:    [dput+25/340] [__down+108/200]
[__down_failed+8/12] [.text.lock.namei+53/1246] [link_path_walk+1786/2460]
Jul 10 10:18:19 grunt1 kernel: ld            D D6E5C848     0 25142      1
25131 (NOTLB)
Jul 10 10:18:19 grunt1 kernel: Call Trace:    [dput+25/340] [__down+108/200]
[__down_failed+8/12] [.text.lock.namei+53/1246] [link_path_walk+1786/2460]
Jul 10 10:18:19 grunt1 kernel: ld            D D6E5C848     0 25143      1
25144  7575 (NOTLB)
Jul 10 10:18:19 grunt1 kernel: Call Trace:    [dput+25/340] [__down+108/200]
[__down_failed+8/12] [.text.lock.namei+53/1246] [link_path_walk+1786/2460]
Jul 10 10:18:19 grunt1 kernel: ld            D D6E5C848     0 25144      1
25147 25143 (NOTLB)
Jul 10 10:18:19 grunt1 kernel: Call Trace:    [dput+25/340] [__down+108/200]
[__down_failed+8/12] [.text.lock.namei+53/1246] [link_path_walk+1786/2460]
Jul 10 10:18:19 grunt1 kernel: ld            D D7A6A000   408 25147      1
25131 25144 (NOTLB)

-- 
Brian Ristuccia
bristucc@sw.starentnetworks.com
