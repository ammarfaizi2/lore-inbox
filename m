Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265890AbUFDRW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265890AbUFDRW7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 13:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265886AbUFDRW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 13:22:59 -0400
Received: from mx2.elte.hu ([157.181.151.9]:38842 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265896AbUFDRVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 13:21:16 -0400
Date: Fri, 4 Jun 2004 19:22:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andy Lutomirski <luto@myrealbox.com>, Andi Kleen <ak@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, arjanv@redhat.com,
       suresh.b.siddha@intel.com, jun.nakajima@intel.com
Subject: Re: [announce] [patch] NX (No eXecute) support for x86,   2.6.7-rc2-bk2
Message-ID: <20040604172227.GA5175@elte.hu>
References: <20040602205025.GA21555@elte.hu> <20040603230834.GF868@wotan.suse.de> <20040604092552.GA11034@elte.hu> <200406040826.15427.luto@myrealbox.com> <Pine.LNX.4.58.0406040830200.7010@ppc970.osdl.org> <20040604160628.GA32375@elte.hu> <20040604172008.GA4993@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604172008.GA4993@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> the patch below implements this simple and pretty robust logic ontop of
> the -AF NX patch.

this also means we finally reach the end of the road - in typical
applications strictly those mappings are executable that contain code:

 saturn:~> cat /proc/self/maps | grep xp
 00aca000-00adf000 r-xp 00000000 03:41 3434109    /lib/ld-2.3.3.so
 00ae3000-00bf8000 r-xp 00000000 03:41 3434110    /lib/tls/libc-2.3.3.so
 08048000-0804c000 r-xp 00000000 03:41 4431437    /bin/cat

	Ingo
