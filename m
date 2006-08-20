Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWHTQ3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWHTQ3t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 12:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWHTQ3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 12:29:49 -0400
Received: from mother.openwall.net ([195.42.179.200]:16065 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S1750762AbWHTQ3s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 12:29:48 -0400
Date: Sun, 20 Aug 2006 20:25:50 +0400
From: Solar Designer <solar@openwall.com>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set*uid() must not fail-and-return on OOM/rlimits
Message-ID: <20060820162550.GB20249@openwall.com>
References: <20060820003840.GA17249@openwall.com> <87veonqtp8.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87veonqtp8.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 06:04:51PM +0200, Florian Weimer wrote:
> Distributors have already begun to patch userland to check for error
> returns.  Arguably, this is the correct approach, but I fear it takes
> far too long to fix all callers.

My opinion is that both userland apps need to (be patched to) check for
error returns from set*[ug]id() and the kernel must not let these calls
fail-and-return when the caller is appropriately privileged.

Alexander
