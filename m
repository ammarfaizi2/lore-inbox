Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261489AbTCGC61>; Thu, 6 Mar 2003 21:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261490AbTCGC61>; Thu, 6 Mar 2003 21:58:27 -0500
Received: from smtp08.iddeo.es ([62.81.186.18]:39874 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id <S261489AbTCGC60>;
	Thu, 6 Mar 2003 21:58:26 -0500
Date: Fri, 7 Mar 2003 04:08:58 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [RFC] i386-arch fixes/enhancements
Message-ID: <20030307030858.GA19479@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

This is  set of small patches that allow a finer tuning of i386 arch, and fix a
small bug:

- 20-x86-p4-prefetch: enables prefetch also for p4. This is a pending bug, IMHO.
- 21-x86-pII: splits Pentium-II as a separate config option; yes some of us
  still have oldies and would like a slightly better optimized kernel
- 22-x86-check_gcc: use check_gcc also for Intel CPUs (like others already do)
  to get better gcc flags.
- 23-x86-mb: implement memory barriers with specific instructions in p3 and p4
  (credits go to Zwane Mwaikambo <zwane@linux.realnet.co.sz>)

Could this ever get into mainline ? Perhaps the only questionable piece is
the mb changes. How about next -pre ?

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre4-jam1 (gcc 3.2.2 (Mandrake Linux 9.1 3.2.2-1mdk))
