Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263478AbTJLMTa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 08:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263479AbTJLMTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 08:19:30 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:38286 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263478AbTJLMT3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 08:19:29 -0400
Date: Sun, 12 Oct 2003 13:18:44 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andrew Morton <akpm@osdl.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: current_is_kswapd is a function
Message-ID: <20031012121844.GF13427@mail.shareable.org>
References: <20031012021750.GA772@holomorphy.com> <20031012050223.0d270c8f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031012050223.0d270c8f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> It would probably be worthwhile teaching the compiler to generate a warning
> in this case; I doubt if anyone is likely to want to find out at runtime
> whether the linker happened to place a particular function at address zero.
> I shall suggest that.

I agree it would be a very useful warning.

Testing the address is useful occasionally, to ask whether the target
of a weak linkage reference was linked in, so a syntax is needed to
suppress the warning, such as "&function != 0".

-- Jamie
