Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbUAMDdC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 22:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbUAMDdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 22:33:02 -0500
Received: from vitelus.com ([64.81.243.207]:19921 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id S263462AbUAMDc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 22:32:59 -0500
Date: Mon, 12 Jan 2004 19:32:34 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Eric Youngdale <eric@andante.org>, Eric Youngdale <ericy@cais.com>
Subject: Re: [PATCH] stronger ELF sanity checks v2
Message-ID: <20040113033234.GD2000@vitelus.com>
References: <Pine.LNX.4.56.0401130228490.2265@jju_lnx.backbone.dif.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0401130228490.2265@jju_lnx.backbone.dif.dk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 02:55:07AM +0100, Jesper Juhl wrote:
> Here's the second version of my patch to add better sanity checks for
> binfmt_elf

I assume this breaks Brian Raiter's tiny ELF executables[1]. Even
though these binaries are evil hacks that don't comply to standards
and serve no serious purpose, I'm not sure what the purpose of the
sanity checks is. Are there any risks associated with running
non-compliant ELF executables? (Now that I mention it, the
proof-of-concept exploit for the brk() hole comes to mind, but I don't
know offhand if that did anything against the spec.) I don't mean to
question the usefulness of your work, especially as I don't know much
about ELF, but I'm personally curious about why you think additional
sanity checks are worth a slight increase in code complexity.

1. http://www.muppetlabs.com/~breadbox/software/tiny/
