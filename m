Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275576AbRJBQjt>; Tue, 2 Oct 2001 12:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275583AbRJBQjk>; Tue, 2 Oct 2001 12:39:40 -0400
Received: from ns.suse.de ([213.95.15.193]:31756 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S275576AbRJBQjc> convert rfc822-to-8bit;
	Tue, 2 Oct 2001 12:39:32 -0400
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Ian Grant <Ian.Grant@cl.cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.10 build failure - atomic_dec_and_lock export
In-Reply-To: <E15oRJg-00005z-00@wisbech.cl.cam.ac.uk>
	<shs669yvwty.fsf@charged.uio.no>
X-Yow: Do you need any MOUTH-TO-MOUTH resuscitation?
From: Andreas Schwab <schwab@suse.de>
Date: 02 Oct 2001 18:39:57 +0200
In-Reply-To: <shs669yvwty.fsf@charged.uio.no> (Trond Myklebust's message of "02 Oct 2001 18:19:21 +0200")
Message-ID: <jepu86j8rm.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.0.107
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> writes:

|> >>>>> " " == Ian Grant <Ian.Grant@cl.cam.ac.uk> writes:
|> 
|>      > Trond,
|>      > 2.4.10 won't link with CONFIG_SMP and i386 CPU selected. I
|>      >        believe the problem
|>      > lies in in the #ifndef atomic_dec_and_lock in
|>      > lib/dec_and_lock.c. As far as I can see this symbol is always
|>      > defined because it's exported.
|> 
|> This patch looks very redundant.
|> 
|> If you have CONFIG_SMP defined then atomic_dec_and_lock will never get
|> defined

Unless you use CONFIG_MODVERSIONS, which causes atomic_dec_and_lock to be
versioned and defined as a macro via <linux/modversions.h>.

Andreas.

-- 
Andreas Schwab                                  "And now for something
Andreas.Schwab@suse.de				completely different."
SuSE Labs, SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
