Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbTJMMIV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 08:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbTJMMIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 08:08:21 -0400
Received: from holomorphy.com ([66.224.33.161]:57733 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261724AbTJMMIS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 08:08:18 -0400
Date: Mon, 13 Oct 2003 05:11:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Kirill Korotaev <kk@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Invalidate_inodes can be very slow
Message-ID: <20031013121109.GJ16158@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Kirill Korotaev <kk@sw.ru>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <200310131318.09234.kk@sw.ru> <200310131545.01779.kk@sw.ru> <20031013115458.GI16158@holomorphy.com> <200310131602.20479.kk@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310131602.20479.kk@sw.ru>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> Sorry if I was unclear, I had in mind SMP performance testing of mount
>> and unmount -heavy workloads, like uni setups with many automounted fs's,
>> not stability testing per se.

On Mon, Oct 13, 2003 at 04:02:20PM +0400, Kirill Korotaev wrote:
> Oh, sorry for misunderstanding.
> In our internal testcase on 8-CPU 8Gb RAM machine with 4gb split kernel
> w/o this patch mount/umount test longs in many-many (>10) times longer.
> Moreover, during the test machine is very slow (due to lock_kernel)
> and typing simple commands takes up to 30 seconds or so.
> I think such a long hangs are due to number of umounts executed
> subsequently. But ofcourse it's not numbers, just for you to know where
> the patch comes from :)

Is this testcase available and/or trivial? Actually, even if it's trivial
it might just save us the pain of writing the scripts ourselves.


-- wli
