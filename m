Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbTIPRV6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 13:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbTIPRV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 13:21:57 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:27540 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262349AbTIPRVx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 13:21:53 -0400
Date: Tue, 16 Sep 2003 18:21:24 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: richard.brunner@amd.com, alan@lxorguk.ukuu.org.uk, zwane@linuxpower.ca,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-ID: <20030916172124.GB28457@mail.jlokier.co.uk>
References: <20030916115050.GG26576@mail.jlokier.co.uk> <Pine.LNX.3.96.1030916094133.26515A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1030916094133.26515A-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> I'm not sure which way you're going here, those have their own config
> entries, does that mean that you are advocating just making the Athlon
> fixup a config option the user must set, or that all of these should be
> on by default and appear in the delete-features menu, and/or be
> controlled by my proposed option to build only for the target CPU. Or
> was this just an informational comment?
> 
> I'm not looking to disagree with any of those suggestions, if you were
> making one.

I'm suggesting the prefetch workaround be on by default, and also the
option would only by visible if someone selects the new "compile only
for cpu XXX" feature.

There's no danger in turning the option off, as long as the init code
always detects AMD prefetch, and turns off in-kernel prefetching if
the workaround isn't configured in.  That's just a performance hit.

We already have a mechanism for removing prefetch instructions when
SSE isn't present, and should be used to handle this too.

-- Jamie
