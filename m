Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264828AbUEUXCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264828AbUEUXCj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265242AbUEUWll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:41:41 -0400
Received: from zero.aec.at ([193.170.194.10]:5 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S265828AbUEUWdB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:33:01 -0400
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: brettspamacct@fastclick.com, linux-kernel@vger.kernel.org
Subject: Re: How can I optimize a process on a NUMA architecture(x86-64
 specifically)?
References: <1Y6yr-eM-11@gated-at.bofh.it> <1YbRm-4iF-11@gated-at.bofh.it>
	<1Yma3-4cF-3@gated-at.bofh.it> <1YmjP-4jX-37@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 21 May 2004 21:17:11 +0200
In-Reply-To: <1YmjP-4jX-37@gated-at.bofh.it> (Martin J. Bligh's message of
 "Fri, 21 May 2004 19:50:13 +0200")
Message-ID: <m3pt8xd1zc.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

> There is no such thing as a homenode. What you describe is more or less why
> we ditched that concept.

numa api has a "prefered node", which is a bit similar to the old
home node. The main difference is that it does not affect the scheduler,
only the memory allocation. You can of course affect the scheduler too,
but that's a separate option now and more strict.

For historical reasons numactl still has a --homenode= alias for --prefered,
although it is undocumented and discouraged now.

-Andi

