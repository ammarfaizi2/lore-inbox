Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262891AbVAKVma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262891AbVAKVma (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 16:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262889AbVAKVmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 16:42:16 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:61112 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262885AbVAKViQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 16:38:16 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Chris Wright <chrisw@osdl.org>, "Jack O'Quin" <joq@io.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       paul@linuxaudiosystems.com, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20050111212823.GX2940@waste.org>
References: <20050107221059.GA17392@infradead.org>
	 <20050107142920.K2357@build.pdx.osdl.net> <87mzvkxxck.fsf@sulphur.joq.us>
	 <20050110212019.GG2995@waste.org> <87d5wc9gx1.fsf@sulphur.joq.us>
	 <20050111195010.GU2940@waste.org> <871xcr3fjc.fsf@sulphur.joq.us>
	 <20050111200549.GW2940@waste.org>
	 <1105475349.4295.21.camel@krustophenia.net>
	 <20050111124707.J10567@build.pdx.osdl.net>
	 <20050111212823.GX2940@waste.org>
Content-Type: text/plain
Date: Tue, 11 Jan 2005 16:38:14 -0500
Message-Id: <1105479495.4295.61.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-11 at 13:28 -0800, Matt Mackall wrote:
> But I'm also still not convinced this policy can't be most flexibly
> handled by a setuid helper together with the mlock rlimit.
> 

Quoting my message from a few days ago:

On Thu, 2005-01-06 at 17:18 -0800, Matt Mackall wrote:
> Why can't this be done with a simple SUID helper to promote given
> tasks to RT with sched_setschedule, doing essentially all the checks
> this LSM is doing? 
> 
> Objections of "because it requires dangerous root or suid" don't fly,
> an RT app under user control can DoS the box trivially. Never mind you
> need root to configure the LSM anyway..

Yes but a bug in an app running as root can trash the filesystem.  The
worst you can do with RT privileges is lock up the machine.

Lee

