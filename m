Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263279AbSLGNnF>; Sat, 7 Dec 2002 08:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263291AbSLGNnF>; Sat, 7 Dec 2002 08:43:05 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:42885 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S263279AbSLGNnE>;
	Sat, 7 Dec 2002 08:43:04 -0500
To: <linux-kernel@vger.kernel.org>
Cc: Greg Boyce <gboyce@rakis.net>
Subject: Re: Dazed and Confused
References: <Pine.LNX.4.42.0212061202230.7770-100000@egg>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 07 Dec 2002 00:33:45 +0100
In-Reply-To: <Pine.LNX.4.42.0212061202230.7770-100000@egg>
Message-ID: <m3znripvs6.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Boyce <gboyce@rakis.net> writes:

> Are the machines likely to give us problems with crashing and data
> corruption, or would it be safe to ignore the problem unless we started
> noticing odd behavior?

First of all, only RAM with parity bits (or ECC) can generate such NMI
(the motherboard must support this as well, of course).

Most motherboads can be configured in ECC mode, and they correct 1-bit
errors. 2-bit errors are reported and not corrected, but the probability
of such error is nearly zero in normal conditions (unless your hardware
is defective, of course).

CPU caches do ECC as well, and possibly can generate NMI requests. However,
they use static RAM (as opposed to dynamic) and bit errors should not
happen there.
-- 
Krzysztof Halasa
Network Administrator
