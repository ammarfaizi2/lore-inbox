Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267445AbUHJGdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267445AbUHJGdW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 02:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267444AbUHJGdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 02:33:22 -0400
Received: from holomorphy.com ([207.189.100.168]:9702 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267445AbUHJGc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 02:32:57 -0400
Date: Mon, 9 Aug 2004 23:32:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm2
Message-ID: <20040810063254.GD11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040808152936.1ce2eab8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040808152936.1ce2eab8.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2004 at 03:29:36PM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc3/2.6.8-rc3-mm2/
> - Added a little patch to the CPU scheduler which disables its array
>   switching.
>   This is purely experimental and will cause high-priority tasks to starve
>   lower-priority tasks indefinitely.  It is here to determine whether it is
>   this aspect of the scheduler which caused the staircase scheduler to exhibit
>   improved throughput in some tests on NUMAq.

This patch can't do what the changelog claims it does; if it did, its
implementation of yield() would render the yielding process forever
unrunnable, plus the active/expired reassignment on sched.c:2672 would
have gone away.  What is it actually meant to do?


-- wli
