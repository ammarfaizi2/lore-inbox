Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUCMHru (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 02:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbUCMHru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 02:47:50 -0500
Received: from [64.62.253.241] ([64.62.253.241]:64785 "EHLO staidm.org")
	by vger.kernel.org with ESMTP id S262329AbUCMHrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 02:47:49 -0500
Date: Fri, 12 Mar 2004 23:49:35 -0800
From: Bryan Rittmeyer <bryan@staidm.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] ppc32 copy_to_user dcbt fixup
Message-ID: <20040313074934.GA15019@staidm.org>
References: <20040313041547.GB11512@staidm.org> <1079153403.2348.82.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079153403.2348.82.camel@gaston>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 03:50:03PM +1100, Benjamin Herrenschmidt wrote:
> It would be wise to make the dcbz as long as possible in "advance"
> before the actual write to the cache line.

I guess we could try "pre-dcbz" ala the dcbt prefetch code.
Even dcbz right before stw is probably cheaper than RAM
loading data that will be totally overwritten. It's hard to
lose eliminating bus I/O (especially reads).

Any comments on the dcbt prefetch patch?

-Bryan

