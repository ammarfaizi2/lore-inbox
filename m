Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbULFUBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbULFUBy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 15:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbULFUBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 15:01:54 -0500
Received: from holomorphy.com ([207.189.100.168]:58328 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261631AbULFUBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 15:01:44 -0500
Date: Mon, 6 Dec 2004 12:01:19 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jan Panteltje <panteltje@yahoo.com>
Cc: linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: 2.6.9 slows down everything
Message-ID: <20041206200119.GR2714@holomorphy.com>
References: <41B463BA.5080008@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B463BA.5080008@yahoo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2004 at 02:50:50PM +0100, Jan Panteltje wrote:
> Slow slow slow, compile takes looooong time..../
> even with all modules removed.
> Even the mouse becomes sluggy
> top shops no excessive CPU usage.
> I am back to 2.4.25,

I've heard of several MTRR issues with 2.6.x, of which this is likely
an instance.

The pattern seemed to involve attempts to cover the final portion of
RAM with numerous fragments decreasing in size with ascending
physical address, and failure to cover the final 4-8MB RAM. Odder
still, the affected systems seemed to only have 1GB RAM, and for some
reason 2.4.x was not affected.

I've walked about 3 or 4 users through manually correcting the MTRR
settings over the past 2 weeks.


-- wli
