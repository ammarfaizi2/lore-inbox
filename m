Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265782AbUGOFW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265782AbUGOFW4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 01:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266005AbUGOFW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 01:22:56 -0400
Received: from holomorphy.com ([207.189.100.168]:22434 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265782AbUGOFWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 01:22:55 -0400
Date: Wed, 14 Jul 2004 22:22:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Christian Borntraeger <linux-kernel@borntraeger.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, lmb@suse.de
Subject: Re: [PATCH] was: [RFC] removal of sync in panic
Message-ID: <20040715052250.GN3411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Christian Borntraeger <linux-kernel@borntraeger.net>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	lmb@suse.de
References: <200407141745.47107.linux-kernel@borntraeger.net> <200407141939.52316.linux-kernel@borntraeger.net> <20040714143112.1d8d1892.akpm@osdl.org> <200407150658.54925.linux-kernel@borntraeger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407150658.54925.linux-kernel@borntraeger.net>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2004 at 06:58:54AM +0200, Christian Borntraeger wrote:
> I have seen panic failing two times lately on an SMP system. The box 
> panic'ed but was running happily on the other cpus. The culprit of this 
> failure is the fact, that these panics have been caused by a block device 
> or a filesystem (e.g. using errors=panic). In these cases the  likelihood 
> of a failure/hang of  sys_sync() is high. This is exactly what happened in 
> both cases I have seen. Meanwhile the other cpus are happily continuing  
> destroying data as the kernel has a severe problem but its not aware of 
> that as smp_send_stop happens after sys_sync.

I've seen SMP boxen run interrupt handlers for ages after panicking,
but I never thought much of it.


-- wli
