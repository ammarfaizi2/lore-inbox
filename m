Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267140AbRHJLNi>; Fri, 10 Aug 2001 07:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267018AbRHJLNT>; Fri, 10 Aug 2001 07:13:19 -0400
Received: from osc.edu ([192.148.249.4]:43438 "EHLO osc.edu")
	by vger.kernel.org with ESMTP id <S267009AbRHJLNI>;
	Fri, 10 Aug 2001 07:13:08 -0400
Date: Fri, 10 Aug 2001 07:13:17 -0400
From: Pete Wyckoff <pw@osc.edu>
To: Ray Lischner <lisch@tempest-sw.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What does MAP_EXECUTABLE do?
Message-ID: <20010810071317.B9627@bigger.osc.edu>
In-Reply-To: <01080916444603.27109@sycorax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01080916444603.27109@sycorax>; from lisch@tempest-sw.com on Thu, Aug 09, 2001 at 04:44:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lisch@tempest-sw.com said:
> Running man mmap produces the enlightening text, "Linux also knows 
> about ... MAP_EXECUTABLE ..." but does nto tell me what MAP_EXECUTABLE 
> actually does, and how it differs from using PROT_EXEC. Reading the 
> source code has not helped me much.

PROT_EXEC tells the VM system the area is executable code.

MAP_EXECUTABLE says this mapping is the actual executable file itself,
not a shared library, trampoline, or other executable thing.

Only used for /proc/pid/exe link and /proc/pid/status VmExe field.

You can't set it via mmap() from userspace; the kernel uses it
internally when execing an elf or a.out file.

		-- Pete
