Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263203AbUDAVdj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 16:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbUDAVc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 16:32:58 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:60501 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263203AbUDAVb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 16:31:29 -0500
Date: Thu, 1 Apr 2004 13:30:33 -0800
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: remove bitmap_shift_*() bitmap length limits
Message-Id: <20040401133033.435a3857.pj@sgi.com>
In-Reply-To: <20040330081142.GL791@holomorphy.com>
References: <20040330065152.GJ791@holomorphy.com>
	<20040330073604.GK791@holomorphy.com>
	<20040330081142.GL791@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The primary effect of the patch is to remove the MAX_BITMAP_BITS

I'm all in favor of that, and this appears one of the two
reasonable alternatives to accomplish that.

The other, perhaps, would be a single bit loop, but one
that went directly into the destination buffer.

That would be slower, smaller and easier to see by
inspection that it was probably right.

This bitmap shift routines receive limited use at present.
Offhand, I see only one use -- a bitmap_shift_right() in
bitmap_scnprintf(), and a few physids_shift macros, that
are in turn themselves unused.

This might argue for the slow, stupid, small solution ...

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
