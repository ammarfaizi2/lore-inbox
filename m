Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261708AbSJNOn7>; Mon, 14 Oct 2002 10:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261824AbSJNOn7>; Mon, 14 Oct 2002 10:43:59 -0400
Received: from stingr.net ([212.193.32.15]:48651 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S261708AbSJNOn6>;
	Mon, 14 Oct 2002 10:43:58 -0400
Date: Mon, 14 Oct 2002 18:49:41 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: kernel BUG at arch/i386/kernel/apm.c:1699!
Message-ID: <20021014144941.GA1217@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------------[ cut here ]------------
kernel BUG at arch/i386/kernel/apm.c:1699!

#ifdef CONFIG_SMP
        /* 2002/08/01 - WT
         * This is to avoid random crashes at boot time during initialization
         * on SMP systems in case of "apm=power-off" mode. Seen on ASUS A7M266D.
         * Some bioses don't like being called from CPU != 0.
         * Method suggested by Ingo Molnar.
         */
        if (smp_processor_id() != 0) {
                current->cpus_allowed = 1;
                schedule();
                if (unlikely(smp_processor_id() != 0))
                        BUG();
        }
#endif

Why ? :()

2.5.42-mm2, 2xPPro-233, etc ...


-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
  When you're invisible, the only one really watching you is you (my keychain)
