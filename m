Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281116AbRLIBWq>; Sat, 8 Dec 2001 20:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281077AbRLIBWf>; Sat, 8 Dec 2001 20:22:35 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:5382 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S281116AbRLIBWR>;
	Sat, 8 Dec 2001 20:22:17 -0500
Date: Sun, 9 Dec 2001 11:17:29 +1100
From: Anton Blanchard <anton@samba.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, davej@suse.de,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Linux HMT analysis
Message-ID: <20011209001729.GA3934@krispykreme>
In-Reply-To: <Pine.LNX.4.33.0112070033450.4486-100000@Appserv.suse.de> <E16C8Zk-0003if-00@the-village.bc.nu> <20011208214631.75573e9a.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011208214631.75573e9a.rusty@rustcorp.com.au>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Anton, can you put the dbench graphs somewhere public?

Here they are:

http://samba.org/~anton/linux/HMT/

The machine is a 4 way RS64 (ppc64) box, with HMT enabled so Linux
thinks it has 8 cpus.

Since HMT is not an intel only problem it would be nice to solve this in
a slightly more generic way than #if defined(__i386__) && defined(CONFIG_SMP).
Otherwise there will shortly be yet another hack in the scheduler
surrounded by #ifdef CONFIG_PPC64_HMT :)

Its pretty obvious what they are trying to achieve (its always
preferrable to schedule 2 tasks on separate physical cpus rather than
sharing the same one), but their change does not seem to have the
required outcome.

Do we have any results showing the improvement this change made or did
we just accept the changes?

Anton
