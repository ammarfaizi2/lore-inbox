Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267703AbUHPPkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267703AbUHPPkY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 11:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267732AbUHPPYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 11:24:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:12442 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267699AbUHPPQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 11:16:29 -0400
Subject: Re: 2.6.8 (or 7?) regression: sleep on older tibooks broken
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David N. Welton" <davidw@dedasys.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>, j.s@lmu.de,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <873c2n41hs.fsf@dedasys.com>
References: <873c2ohjrv.fsf@dedasys.com> <1092569364.9539.16.camel@gaston>
	 <873c2n41hs.fsf@dedasys.com>
Content-Type: text/plain
Message-Id: <1092668911.9539.55.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 17 Aug 2004 01:08:32 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I made the video driver's sleep routing return 0 immediately.
> 
> That was enough to at least get a couple of reports from xmon about a
> vector 200 corresponding to an address in powerbook_sleep_Core99...
> Still investigating, but this is new territory for me, and it's
> certainly at a tricky moment in the life of the kernel.  Suggestions
> appreciated as to what might have changed and what to look for.

Ouch, that's pretty bad. 200 is a machine check, looks like the
HW shoked which shouldn't happen there. Can you get me the actual
xmon output and eventually backtrace ? (you can disable the adb
sleep code to get the kbd working in xmon)

Ben.


