Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbVLLTbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbVLLTbw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 14:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbVLLTbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 14:31:52 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:65491 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932169AbVLLTbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 14:31:51 -0500
Message-ID: <439DD01A.2060803@watson.ibm.com>
Date: Mon, 12 Dec 2005 19:31:38 +0000
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       lse-tech@lists.sourceforge.net,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Jay Lan <jlan@sgi.com>, Jens Axboe <axboe@suse.de>,
       John Stultz <johnstul@us.ibm.com>
Subject: Re: [Lse-tech] [RFC][Patch 1/5] nanosecond timestamps and diffs
References: <43975D45.3080801@watson.ibm.com> <43975E6D.9000301@watson.ibm.com> <Pine.LNX.4.62.0512121049400.14868@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0512121049400.14868@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Wed, 7 Dec 2005, Shailabh Nagar wrote:
> 
> 
>>+void getnstimestamp(struct timespec *ts)
> 
> 
> There is already getnstimeofday in the kernel.
> 
> 

Yes, and that function is being used within the getnstimestamp() being proposed.
However, John Stultz had advised that getnstimeofday could get affected by calls to
settimeofday and had recommended adjusting the getnstimeofday value with wall_to_monotonic.

John, could you elaborate ?

Thanks,
Shailabh
