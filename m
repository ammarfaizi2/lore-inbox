Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbTH1RGi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 13:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264116AbTH1RGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 13:06:38 -0400
Received: from holomorphy.com ([66.224.33.161]:41155 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264113AbTH1RGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 13:06:37 -0400
Date: Thu, 28 Aug 2003 10:07:16 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Peter Chubb <peter@chubb.wattle.id.au>, Andrew Morton <akpm@osdl.org>,
       Peter Chubb <peterc@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test4 -- add context switch counters
Message-ID: <20030828170716.GG4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Peter Chubb <peter@chubb.wattle.id.au>,
	Andrew Morton <akpm@osdl.org>,
	Peter Chubb <peterc@gelato.unsw.edu.au>,
	linux-kernel@vger.kernel.org
References: <16204.24623.273818.861350@wombat.chubb.wattle.id.au> <20030827075143.GX4306@holomorphy.com> <20030828165504.GA21352@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030828165504.GA21352@matchmail.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 12:51:43AM -0700, William Lee Irwin III wrote:
>> We don't have load control yet; the counters should probably be removed
>> until we do.

On Thu, Aug 28, 2003 at 09:55:04AM -0700, Mike Fedyk wrote:
> Why not just count the number of pages swapped in/out per process?  I'm sure
> that would be helpful for VM tools polling for stats from userspace...  And
> even in the development of load control.

That's good to report, sure; however, that would violate the semantics
of getrusage(), whose nswap refers to whole-process swapping done for
the purposes of reducing the multiprogramming level (i.e. load control).


-- wli
