Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262780AbTDUWoW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 18:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbTDUWoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 18:44:22 -0400
Received: from holomorphy.com ([66.224.33.161]:33686 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262780AbTDUWoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 18:44:21 -0400
Date: Mon, 21 Apr 2003 15:55:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: 67-mjb2 vs 68-mjb1 (sdet degredation)
Message-ID: <20030421225552.GE8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org
References: <1425480000.1050959528@flay> <20030421144631.4987db46.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030421144631.4987db46.akpm@digeo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>> Just wondering if you can recognise / guess the problem from the profiles,
>> else I'll poke at it some more (will probably just work out what's hitting
>> .text.lock.filemap).

On Mon, Apr 21, 2003 at 02:46:31PM -0700, Andrew Morton wrote:
> erk.  Looks like the rwlock->spinlock conversion of mapping->page_lock.
> That was a small (1%?) win on small SMP, and looks to be a small lose on
> big SMP.  No real surprise there.
> Here's a backout patch.  Does it fix it up?

I've yet to recover from merging against this and several others;
hopefully mbligh can run the numbers you need.


-- wli
