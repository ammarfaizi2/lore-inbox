Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265408AbSJSAQr>; Fri, 18 Oct 2002 20:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265414AbSJSAQr>; Fri, 18 Oct 2002 20:16:47 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61387 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265408AbSJSAQq>;
	Fri, 18 Oct 2002 20:16:46 -0400
Date: Fri, 18 Oct 2002 17:15:04 -0700 (PDT)
Message-Id: <20021018.171504.96943359.davem@redhat.com>
To: ak@suse.de
Cc: jun.nakajima@intel.com, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, asit.k.mallick@intel.com,
       sunil.saxena@intel.com
Subject: Re: [PATCH] fixes for building kernel using Intel compiler
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <p73u1jjnvea.fsf@oldwotan.suse.de>
References: <F2DBA543B89AD51184B600508B68D4000E6ADE5B@fmsmsx103.fm.intel.com.suse.lists.linux.kernel>
	<p73u1jjnvea.fsf@oldwotan.suse.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: 19 Oct 2002 02:07:41 +0200
   
   > -/* Enable FXSR and company _before_ testing for FP problems. */
   > -       /*
   > -        * Verify that the FXSAVE/FXRSTOR data will be 16-byte aligned.
   > -        */
   > -       if (offsetof(struct task_struct, thread.i387.fxsave) & 15) {
   > -               extern void __buggy_fxsr_alignment(void);
   > -               __buggy_fxsr_alignment();
   > -       }
   
   Why does that not work? IMHO it is legal ISO-C

Depending upon the compiler to optimize away the non-existent function
reference is not ISO-C :-)  Although the fact the Intel compiler isn't
doing this is amusing.
