Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264936AbSLTTwY>; Fri, 20 Dec 2002 14:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264969AbSLTTwY>; Fri, 20 Dec 2002 14:52:24 -0500
Received: from ns.suse.de ([213.95.15.193]:62737 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S264936AbSLTTwX>;
	Fri, 20 Dec 2002 14:52:23 -0500
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>, bjorn_helgaas@hp.com
Subject: Re: [PATCH] Fix CPU bitmask truncation
References: <200212161213.29230.bjorn_helgaas@hp.com>
	<20021220103028.GB9704@holomorphy.com> <je7ke4yje3.fsf@sykes.suse.de>
	<1040408597.1867.24.camel@ixodes.goop.org>
X-Yow: I'm reporting for duty as a modern person.  I want to do
 the Latin Hustle now!
From: Andreas Schwab <schwab@suse.de>
Date: Fri, 20 Dec 2002 21:00:23 +0100
In-Reply-To: <1040408597.1867.24.camel@ixodes.goop.org> (Jeremy
 Fitzhardinge's message of "20 Dec 2002 10:23:17 -0800")
Message-ID: <je3cosxxyg.fsf@sykes.suse.de>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.3.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge <jeremy@goop.org> writes:

|> On Fri, 2002-12-20 at 04:17, Andreas Schwab wrote:
|> > This is useless.  Assigning -1 to any unsigned type is garanteed to give
|> > you all bits one, and with two's complement this also holds for any signed
|> > type.
|> 
|> Only if the -1 is the same size as the unsigned type.  Otherwise it will
|> be 0-extended.

Wrong.  Unsigned arithmetics is defined as modulo MAX+1, and -1 equals MAX
modulo MAX+1 for every MAX.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
