Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132042AbRDJT7x>; Tue, 10 Apr 2001 15:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132044AbRDJT7p>; Tue, 10 Apr 2001 15:59:45 -0400
Received: from ns.suse.de ([213.95.15.193]:60424 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132042AbRDJT70>;
	Tue, 10 Apr 2001 15:59:26 -0400
Date: Tue, 10 Apr 2001 21:59:24 +0200
From: Andi Kleen <ak@suse.de>
To: "Stephen D. Williams" <sdw@lig.net>
Cc: Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Mark Salisbury <mbs@mc.com>, Jeff Dike <jdike@karaya.com>,
        schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
Message-ID: <20010410215924.A24197@gruyere.muc.suse.de>
In-Reply-To: <20010410140202.A15114@gruyere.muc.suse.de> <E14mx0K-00049P-00@the-village.bc.nu> <20010410143216.A15880@gruyere.muc.suse.de> <3AD354BB.20F1CE33@lig.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AD354BB.20F1CE33@lig.net>; from sdw@lig.net on Tue, Apr 10, 2001 at 02:45:15PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 02:45:15PM -0400, Stephen D. Williams wrote:
> When this is rewritten, I would strongly suggest that we find a way to
> make 'gettimeofday' nearly free.  Certain applications need to use this
> frequently while still being portable.  One solution when you do have
> clock ticks is a read-only mapped Int.  Another cheap solution is
> library assembly that adds a cycle clock delta since last system call to
> a 'gettimeofday' value set on every system call return.

The upcoming x86-64 port supports vsyscalls for just that purpose.



-Andi
