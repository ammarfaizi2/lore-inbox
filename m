Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVDQSvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVDQSvr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 14:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVDQSvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 14:51:47 -0400
Received: from nevyn.them.org ([66.93.172.17]:29098 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261408AbVDQSvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 14:51:45 -0400
Date: Sun, 17 Apr 2005 14:51:43 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 & x86_64: Live Patching Funcion on 2.6.11.7
Message-ID: <20050417185143.GA5002@nevyn.them.org>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>,
	linux-kernel@vger.kernel.org
References: <4261DC62.1070300@lab.ntt.co.jp> <20050416234439.5464e188.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050416234439.5464e188.davem@davemloft.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 16, 2005 at 11:44:39PM -0700, David S. Miller wrote:
> 
> Takashi-san, have you ever investigated using kprobes to
> implement this feature?  It seems a perfect fit, and would
> allow support on several architectures other than just x86
> and x86_64.
> 
> If kprobes does not meet your needs completely, it could
> be trivially extended to do so.
> 
> I think implementing something like this from scratch is
> not a good idea when we have much of the needed logic and
> infrastructure already.

Takashi-san's description was not very clear, but it sounds like it's a
patching mechanism for userspace applications - not for kernel space.
So kprobes would not be a good fit.

If I'm right, I'm not sure why some of the bits of it were done
separately instead of via the existing ptrace mechanism.  And GDB
would appreciate a mechanism for mmap/munmap/mprotect in a debugged
process, also.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
