Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271030AbUJVDLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271030AbUJVDLE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 23:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271043AbUJVDIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 23:08:25 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:62597 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S271067AbUJVCz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 22:55:56 -0400
From: Jesse Barnes <jbarnes@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: ZONE_PADDING wastes 4 bytes of the new cacheline
Date: Thu, 21 Oct 2004 21:55:51 -0500
User-Agent: KMail/1.7
Cc: Andrea Arcangeli <andrea@novell.com>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
References: <20041021011714.GQ24619@dualathlon.random> <20041022011057.GC14325@dualathlon.random> <20041021182651.082e7f68.akpm@osdl.org>
In-Reply-To: <20041021182651.082e7f68.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410212155.52264.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, October 21, 2004 8:26 pm, Andrew Morton wrote:
> I'd be OK with wapping over to the watermark version, as long as we have
> runtime-settable levels.
>
> But I'd be worried about making the default values anything other than zero
> because nobody seems to be hitting the problems.

Yes, please keep the default at 0 regardless of the algorithm.  On the NUMA 
systems I'm aware of, an incremental min just doesn't make any sense.

Thanks,
Jesse
