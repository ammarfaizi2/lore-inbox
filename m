Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317566AbSGOS3A>; Mon, 15 Jul 2002 14:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317576AbSGOS27>; Mon, 15 Jul 2002 14:28:59 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:50142 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317566AbSGOS26>;
	Mon, 15 Jul 2002 14:28:58 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15667.5309.648214.700000@napali.hpl.hp.com>
Date: Mon, 15 Jul 2002 11:30:21 -0700
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: davidm@hpl.hp.com, rmk@arm.linux.org.uk (Russell King),
       torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
Subject: Re: HZ, preferably as small as possible
In-Reply-To: <200207151820.g6FIKVi215656@saturn.cs.uml.edu>
References: <15666.61141.799053.70367@napali.hpl.hp.com>
	<200207151820.g6FIKVi215656@saturn.cs.uml.edu>
X-Mailer: VM 7.03 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 15 Jul 2002 14:20:31 -0400 (EDT), "Albert D. Cahalan" <acahalan@cs.uml.edu> said:

  Albert> Perhaps you could explain how to access ELF notes from
  Albert> regular app code. That covers 2.4 kernels AFAIK, and so the
  Albert> hacks could go away as soon as Debian retires the 2.2
  Albert> kernel.

The ELF auxiliary info table is stored at the top of the user level
stack (above argv and envp).  &envp[num_envs] should get you there
(check on the alignment, though).

	--david
