Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbTLMW1N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 17:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264556AbTLMW1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 17:27:13 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:60803 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264238AbTLMW1M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 17:27:12 -0500
Date: Sat, 13 Dec 2003 22:26:26 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Peter Horton <pdh@colonel-panic.org>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: Possible shared mapping bug in 2.4.23 (at least MIPS/Sparc)
Message-ID: <20031213222626.GA20153@mail.shareable.org>
References: <20031213114134.GA9896@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031213114134.GA9896@skeleton-jack>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Horton wrote:
> A quick look at sparc and sparc64 seem to show the same problem.

D-cache incoherence with unsuitably aligned multiple MAP_FIXED
mappings is also observed on SH4, SH5, PA-RISC 1.1d.  The kernel may
have the same behaviour on those platforms: allowing a mapping that
should not be allowed.

On some ARM and m68k boxes, incoherence is observed independent of
alignment, for multiple mappings of a page in the same user memory
space.

-- Jamie

