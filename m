Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932583AbWGTJf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbWGTJf7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 05:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbWGTJf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 05:35:59 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:17040 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S932583AbWGTJf7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 05:35:59 -0400
Date: Thu, 20 Jul 2006 11:35:57 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Bill Ryder <bryder@wetafx.co.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc1]  Make group sorting optional in the 2.6.x kernels
Message-ID: <20060720093557.GA1796@janus>
References: <44B32888.6050406@wetafx.co.nz> <20060719080213.GA22925@janus> <44BE936B.3080107@wetafx.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44BE936B.3080107@wetafx.co.nz>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2006 at 08:17:47AM +1200, Bill Ryder wrote:
[...]
> As an aside Frank - can you point at a paper which provides a
> walkthrough of how your patch  works and what the caveats are?

	http://www.frankvm.com/nfs-ngroups/README

> For example
> 
> /top(0)/p1(2)/p3(2)/p4(2)/p5(6)/file1(6)
> /top(0)/p1(2)/p3(2)/p4(2)/p6(7)/file2(7)
> /top(0)/p1(2)/p3(2)/p4(2)/p7(8)/file3(6)
> /top(0)/p1(2)/p3(2)/p4(2)/p7(8)/file4(8)
> 
> And so on - where the (n) indicated the (gid) for that directory/file.
> So most of our directories are in the same group. But as you get further
> down the tree the groups start to change.
> 
> The process will belong to > 16 groups.

setgroups() require privilege. I don't understand how the above is
supposed to work for non-root users needing >16 groups. And when you're
root it is silly to play these group games for getting access.

-- 
Frank
