Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268120AbUH1XJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268120AbUH1XJL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 19:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268121AbUH1XJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 19:09:11 -0400
Received: from holomorphy.com ([207.189.100.168]:14762 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268120AbUH1XJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 19:09:06 -0400
Date: Sat, 28 Aug 2004 16:09:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [4/5] eliminate bh waitqueue hashtable
Message-ID: <20040828230903.GD5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040828200549.GR5492@holomorphy.com> <20040828200659.GS5492@holomorphy.com> <20040828200841.GT5492@holomorphy.com> <20040828200951.GU5492@holomorphy.com> <20040828201107.GV5492@holomorphy.com> <20040828153728.38e7f85a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828153728.38e7f85a.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 03:37:28PM -0700, Andrew Morton wrote:
> This is still all inlined.  Given that we're going to schedule away,
> don't you think we should out-of-line the slowpath?  As I said yesterday:
> static inline int wait_on_bit(...)
> {
> 	if (test_bit(...))
> 		return out_of_line_wait_on_bit(...);
> 	return 0;
> }
> I merged this latest batch into -mm.

Neither bit_waitqueue() nor __wait_on_bit() are inlined, but it is
possible to reduce things to only one call site. I'll send in that
update if you've not done it yourself after I get a chance to see
what's been merged.


-- wli
