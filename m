Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267131AbTBUEa2>; Thu, 20 Feb 2003 23:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267128AbTBUEa2>; Thu, 20 Feb 2003 23:30:28 -0500
Received: from pizda.ninka.net ([216.101.162.242]:49357 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267126AbTBUEa1>;
	Thu, 20 Feb 2003 23:30:27 -0500
Date: Thu, 20 Feb 2003 20:24:38 -0800 (PST)
Message-Id: <20030220.202438.10564686.davem@redhat.com>
To: ak@suse.de
Cc: sim@netnation.com, linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Longstanding networking / SMP issue? (duplextest)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030220093422.GA16369@wotan.suse.de>
References: <p73r8a3xub5.fsf@amdsimf.suse.de>
	<20030220092043.GA25527@netnation.com>
	<20030220093422.GA16369@wotan.suse.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: Thu, 20 Feb 2003 10:34:22 +0100

   On Thu, Feb 20, 2003 at 01:20:43AM -0800, Simon Kirby wrote:
   > Hmm...and this is considered desired behavior?  It seems like an odd way
   > of handling packets intended to test latency and reliability. :)
   
   IP is best-effort. Dropping packets in odd cases to make locking simpler
   is not unreasonable. Would you prefer an slower kernel?

True.

But this is a quality of implementation issue and I doubt the kernel
would be slower if we fixed this silly behavior.

Frankly, the locking is due to lazyness, rather than a specific design
decision.  So let's fix it.
