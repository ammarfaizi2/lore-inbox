Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266225AbUBKWaO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 17:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266226AbUBKWaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 17:30:13 -0500
Received: from ns.suse.de ([195.135.220.2]:2207 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266225AbUBKWaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 17:30:07 -0500
To: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Cc: linux-kernel@vger.kernel.org
Subject: Re: printk and long long
References: <200402111604.49082.vda@port.imtp.ilyichevsk.odessa.ua>
	<Pine.LNX.4.44.0402111655170.17933-100000@gaia.cela.pl>
	<c0e0gr$mcv$1@terminus.zytor.com> <yw1xvfmdwe4s.fsf@kth.se>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I'm in LOVE with DON KNOTTS!!
Date: Wed, 11 Feb 2004 23:23:28 +0100
In-Reply-To: <yw1xvfmdwe4s.fsf@kth.se> 
 =?iso-8859-1?q?=28M=E5ns_Rullg=E5rd's?= message of "Wed, 11 Feb 2004 21:32:51 +0100")
Message-ID: <je8yj9cl27.fsf@sykes.suse.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mru@kth.se (Måns Rullgård) writes:

> What is the proper way to deal with printing an int64_t when int64_t
> can be either long or long long depending on machine?

PRId64 from <inttypes.h> (replace d with the desired format character).
This is for user space, not sure whether that is acceptable for kernel
code (<intttypes.h> is not one of the required headers for freestanding
implementations).

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
