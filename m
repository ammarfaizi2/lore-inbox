Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264166AbTDKFAk (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 01:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264188AbTDKFAk (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 01:00:40 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:58770 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S264166AbTDKFAj convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 01:00:39 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BUG] settimeofday(2) succeeds for microsecond value more than USEC_PER_SEC and for negative value
Date: Fri, 11 Apr 2003 10:42:04 +0530
Message-ID: <94F20261551DC141B6B559DC491086723E0EB7@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG] settimeofday(2) succeeds for microsecond value more than USEC_PER_SEC and for negative value
Thread-Index: AcL/6OPOorCeX+eqSaqNS5lYbaKqBg==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <george@mvista.com>
Cc: <linux-kernel@vger.kernel.org>,
       "Chandrashekhar RS" <chandra.smurthy@wipro.com>
X-OriginalArrivalTime: 11 Apr 2003 05:12:04.0461 (UTC) FILETIME=[E42041D0:01C2FFE8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Settimeofday(2) should return EINVAL in case where tv.tv_usec parameter is more than 
USEC_PER_SEC (more than 10^6 ) or for negative values of tv.tv_usec. 
It returns 0 (success) instead.

Clock_settimeofday(2) (kernel/posix-timers.c) also uses do_sys_settimeofday() and faces the
Same problem.

I think this is a bug. If you confirm, I will send a patch.

Regards,
Aniruddha Marathe
WIPRO Technologies, India
