Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263398AbUJ2PiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263398AbUJ2PiL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 11:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263392AbUJ2Pgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 11:36:50 -0400
Received: from siaag1ac.compuserve.com ([149.174.40.5]:14748 "EHLO
	siaag1ac.compuserve.com") by vger.kernel.org with ESMTP
	id S263401AbUJ2PHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 11:07:50 -0400
Date: Fri, 29 Oct 2004 11:04:36 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [RFC] Linux 2.6.9.1-pre1 contents
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <200410291107_MC3-1-8D7A-1644@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2004 at 12:33:04 +0100 Alan Cox wrote:

>> ide_maxtor_probe.patch
>>         Another Maxtor IDE drive serial number oddity
>
> This is definitely wrong,

  It just went into mainline as rev 1.87 to ide-probe.c  :(

  Your "Integrated Technology Express" addition is missing but I'm
going to add it here.


> the others look fairly sane although there are
> a lot that are for such obscure cases they seem to add not reduce risk.

  I've been including one-liners even if they only fix rare cases or
aren't strictly bugfixes, but the larger ones are riskier:

    - backport of the rq-lock patch almost certainly created a profiling
      bug if the retry path is taken.

    - the timers-and-signals patch fixes three things; only one is urgent.

  And Hugh's VM accounting patches look very worthwhile (they just went into
mainline.)  I took one and might merge the other two - but they change
statm reporting.


  Getting them to merge and compile is the easy part...


--Chuck Ebbert  29-Oct-04  11:02:40
