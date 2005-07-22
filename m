Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbVGVJJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbVGVJJh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 05:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVGVJJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 05:09:37 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:29551 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262071AbVGVJJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 05:09:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=mF+CViJt5povxcNl2oR410gmFGGB9tLX1Jsacx3tTms+pG8HN8QtlKPtYJCXxA30gCoN2lp6zxpdG3wc+ZxwzyzM0j44MrcpnLzGY46nL04tgOAHZ3BvrR8ixUsWqEBTjv5FCkLfQd6ENyLhzSTTwxKPDcSwOpCsVLJLM06vjtc=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: steve_wooding@keysounds.co.uk
Subject: Re:=?iso-8859-1?Q?[COMPILE_ERROR]_realtime-preempt-2=2E6=2E12-final-V0=2E7=2E51-33_on_x86_64_SMP_system
Date: Fri, 22 Jul 2005 11:13:02 +0200
User-Agent: KMail/1.8.1
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507221113.02246.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve,

to make it compile and build replace
 arch/x86_64/kernel/smpboot.c: line 191
with this:
<snip>
static __cpuinitdata raw_spinlock_t tsc_sync_lock = RAW_SPIN_LOCK_UNLOCKED;
</snip>

or alternativly:
<snip>
static DEFINE_RAW_SPINLOCK(tsc_sync_lock);
</snip>

    Karsten

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
