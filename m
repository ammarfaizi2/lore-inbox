Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266051AbTGNQCH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 12:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268308AbTGNQCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 12:02:07 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:12776 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266051AbTGNQB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 12:01:56 -0400
To: "" <simon@baydel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPC 440 System
References: <3F12A1B9.3086.614B56@localhost>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 14 Jul 2003 09:16:38 -0700
In-Reply-To: <3F12A1B9.3086.614B56@localhost>
Message-ID: <524r1pw0bd.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 14 Jul 2003 16:16:40.0749 (UTC) FILETIME=[4F136DD0:01C34A23]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    simon> If I remove /sbin/init from the nfs root the kernel panics
    simon> as expected, so I assume root is mounted ok. I have tried
    simon> to build a minimum root filesystem which contains
    simon> /dev/console, /dev/ttyS0 and a statically linked
    simon> /sbin/init. The init just does a printf but I do not see
    simon> this message. Does anyone know it this should work ?

Yes, a static /sbin/init should work.

    simon> Initially I tried to build a root filesystem from files on
    simon> a Mac Clone running Yellow Dog Linux. I believe this has a
    simon> PPC 604e processor. Should this systems binaries/libraries
    simon> run on the 440GP ?

    simon> Can I expect a statically linked executable, made on the
    simon> Mac, to run on the 440GP?

Probably not.  The 440GP has no floating point hardware, so you will
need (at least) to build a special glibc without FP instructions and
also make sure your gcc is set up not to generate FP instructions.

Your best bet is probably to download ELDK (a free Embedded Linux
Development Kit) from www.denx.de.  Dan Kegel also has some good PPC
4xx cross development information at www.kegel.com.

Best,
  Roland
