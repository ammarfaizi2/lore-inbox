Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbUDAReU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 12:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262983AbUDAReU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 12:34:20 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:40835
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262972AbUDAReS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 12:34:18 -0500
Date: Thu, 1 Apr 2004 19:34:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-ID: <20040401173417.GO18585@dualathlon.random>
References: <20040401135920.GF18585@dualathlon.random> <20040401164825.GD791@holomorphy.com> <20040401165952.GM18585@dualathlon.random> <20040401171625.GE791@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401171625.GE791@holomorphy.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it's not compiling:

security/sysctl_capable.c:273: error: redefinition of `capability_sysctl_zero'
security/sysctl_capable.c:68: error: `capability_sysctl_zero' previously defined here
security/sysctl_capable.c:274: error: redefinition of `capability_sysctl_one'
security/sysctl_capable.c:69: error: `capability_sysctl_one' previously defined here
security/sysctl_capable.c:278: error: redefinition of `capability_sysctl_table'
security/sysctl_capable.c:73: error: `capability_sysctl_table' previously defined here
security/sysctl_capable.c:315: error: redefinition of `capability_sysctl_root_table'
security/sysctl_capable.c:110: error: `capability_sysctl_root_table' previously defined here
security/sysctl_capable.c:327: error: redefinition of `capability_sysctl_ops'
security/sysctl_capable.c:122: error: `capability_sysctl_ops' previously defined here
security/sysctl_capable.c:348: error: redefinition of `capability_sysctl_capable'
security/sysctl_capable.c:143: error: `capability_sysctl_capable' previously defined here
security/sysctl_capable.c:374: error: redefinition of `capability_sysctl_proc_init'
security/sysctl_capable.c:169: error: `capability_sysctl_proc_init' previously defined here
security/sysctl_capable.c:384: error: redefinition of `capability_sysctl_init'
security/sysctl_capable.c:179: error: `capability_sysctl_init' previously defined here
security/sysctl_capable.c:398: error: redefinition of `capability_sysctl_fini'
security/sysctl_capable.c:193: error: `capability_sysctl_fini' previously defined here
security/sysctl_capable.c:406: error: redefinition of `__initcall_capability_sysctl_init'
security/sysctl_capable.c:201: error: `__initcall_capability_sysctl_init' previously defined here
security/sysctl_capable.c:407: error: redefinition of `__initcall_capability_sysctl_proc_init'
security/sysctl_capable.c:202: error: `__initcall_capability_sysctl_proc_init' previously defined here
security/sysctl_capable.c:408: error: redefinition of `__exitcall_capability_sysctl_fini'
security/sysctl_capable.c:203: error: `__exitcall_capability_sysctl_fini' previously defined here
security/sysctl_capable.c:348: warning: `capability_sysctl_capable' defined but not used
make[1]: *** [security/sysctl_capable.o] Error 1
make: *** [security] Error 2

I'm still dealing with the swapsuspend crashes so I cannot look into the
above just now. The swapsuspend now crashes in a different place, but I
believe with my last patch the VM is ok now (there is no more sign of
crashes in radix tree or pagecache operations).
