Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267882AbUJLVx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267882AbUJLVx5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 17:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267903AbUJLVwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 17:52:41 -0400
Received: from canuck.infradead.org ([205.233.218.70]:50191 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S267882AbUJLVur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 17:50:47 -0400
Subject: Re: [PATCH] Support ia32 exec domains without CONFIG_IA32_SUPPORT
From: David Woodhouse <dwmw2@infradead.org>
To: Arun Sharma <arun.sharma@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
In-Reply-To: <416AF599.2060801@intel.com>
References: <41643EC0.1010505@intel.com>
	 <20041007142710.A12688@infradead.org> <4165D4C9.2040804@intel.com>
	 <mailman.1097223239.25078@unix-os.sc.intel.com>
	 <41671696.1060706@intel.com>
	 <mailman.1097403036.11924@unix-os.sc.intel.com>
	 <416AF599.2060801@intel.com>
Content-Type: text/plain
Date: Tue, 12 Oct 2004 22:50:24 +0100
Message-Id: <1097617824.5178.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 (2.0.1-4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-11 at 14:05 -0700, Arun Sharma wrote:
> I've prototyped a generic userland solution that covers just open and
> stat system calls (for completeness, all path walk related syscalls
> need to be covered) using the LD_PRELOAD approach.
> 
> I saw a 16% degradation in system time on this benchmark:
> 
> find /usr/src/linux -name '*.[chS]' | xargs grep fsck
> 
> mainly due to the doubling of the number of calls to open. Also, there
> was a slight increase in user time as well, due to malloc/free
> overhead.

The patch is entirely bogus. This isn't at all ia64-specific, and
doesn't live in arch/ia64. It's just as applicable on _all_ systems
where we may want to do CPU or OS emulation.

If you make it generic so that qemu can use it for emulating i386 even
on machines like ppc64, perhaps it would be saner.

-- 
dwmw2

