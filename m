Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284916AbRLFBKl>; Wed, 5 Dec 2001 20:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284919AbRLFBKc>; Wed, 5 Dec 2001 20:10:32 -0500
Received: from pizda.ninka.net ([216.101.162.242]:7041 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S284916AbRLFBKT>;
	Wed, 5 Dec 2001 20:10:19 -0500
Date: Wed, 05 Dec 2001 17:09:53 -0800 (PST)
Message-Id: <20011205.170953.08321842.davem@redhat.com>
To: paulus@samba.org
Cc: rth@redhat.com, davidm@hpl.hp.com, schwab@suse.de,
        linux-ia64@linuxia64.org, marcelo@conectiva.com.br,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: alpha bug in signal handling
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15374.35262.151232.521493@argo.ozlabs.ibm.com>
In-Reply-To: <20011204190048.B8179@redhat.com>
	<20011205.032304.102576056.davem@redhat.com>
	<15374.35262.151232.521493@argo.ozlabs.ibm.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Paul Mackerras <paulus@samba.org>
   Date: Thu, 6 Dec 2001 07:55:26 +1100 (EST)
   
   I think David (Mosberger, not Miller :) is right here, and in fact
   this is also wrong on PPC at the moment.  However, the worst case is
   that the reschedule or signal delivery will get delayed until the next
   interrupt on that cpu (max 1/HZ seconds).  Since it is a pretty narrow
   window for the race I think it would be hard to observe the effect of
   the bug.

I understand now, thanks.  I've fixed up sparc64.

So it's a latency problem, not a correctness problem.
