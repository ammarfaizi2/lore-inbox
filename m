Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267378AbUITWUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267378AbUITWUr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 18:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267380AbUITWUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 18:20:47 -0400
Received: from holomorphy.com ([207.189.100.168]:1474 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267378AbUITWUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 18:20:38 -0400
Date: Mon, 20 Sep 2004 15:20:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: Andrew Morton OSDL <akpm@osdl.org>, Craig Small <csmall@debian.org>,
       Joshua Kwan <joshk@triplehelix.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc2-mm1
Message-ID: <20040920222026.GY9106@holomorphy.com>
References: <20040916024020.0c88586d.akpm@osdl.org> <20040920023452.GR9106@holomorphy.com> <1095653925.4969.100.camel@cube> <20040920074731.GS9106@holomorphy.com> <1095692447.4969.174.camel@cube> <20040920210159.GW9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040920210159.GW9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2004 at 02:01:59PM -0700, William Lee Irwin III wrote:
> (e) This should have been rather easily anticipated given that you're
> 	shifting (pid+1) << BITS_PER_LONG/2. I expect the maintainers
> 	of most/all arches with 32-bit emulation (essentially all
> 	64-bit except alpha) to have conniption fits if this gets
> 	anywhere near mainline. Such shifts are tantamount to 32-bit
> 	emulated stat(2) always returning -EOVERFLOW in lieu of results.

I've confirmed that backing out fake_ino-fixes.patch repairs 32-bit
emulated userspace.

akpm, please back out fake_ino-fixes.patch.


-- wli
