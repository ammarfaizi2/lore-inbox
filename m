Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262732AbVDPTBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262732AbVDPTBK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 15:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbVDPTBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 15:01:10 -0400
Received: from waste.org ([216.27.176.166]:5594 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262732AbVDPTBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 15:01:09 -0400
Date: Sat, 16 Apr 2005 12:00:35 -0700
From: Matt Mackall <mpm@selenic.com>
To: linux@horizon.com
Cc: jlcooke@certainkey.com, linux-kernel@vger.kernel.org, tytso@mit.edu
Subject: Re: Fortuna
Message-ID: <20050416190035.GB21897@waste.org>
References: <20050415170450.GB23277@certainkey.com> <20050416100555.25344.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050416100555.25344.qmail@science.horizon.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 16, 2005 at 10:05:55AM -0000, linux@horizon.com wrote:
> MErging e-mails, first from mpm@selenic.com:
> > You really ought to look at the _current_ implementation. There is no
> > SHA1 code in random.c. 
> 
> So I'm imagining the call to sha_transform() in 2.6.12-rc2's
> extract_buf()?  The SHA1 code has been moved to lib/sha1.c, so there's
> no SHA1 code *lexically* in random.c, but that's a facile response;
> it's a cryptologically meaningless change.

No, it's exactly to the point: he's forked random.c before a large set
of changes that he needs to be aware of. The SHA1 code is now shared
by cryptolib and obviously no longer suffers from the (non-existent)
weakness he referenced.

-- 
Mathematics is the supreme nostalgia of our time.
