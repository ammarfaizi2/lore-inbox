Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262516AbVAUVWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262516AbVAUVWU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 16:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262510AbVAUVWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 16:22:19 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:49918 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262519AbVAUVVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 16:21:25 -0500
To: Kevin Corry <kevcorry@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Benjamin LaHaise <bcrl@kvack.org>,
       Alasdair G Kergon <agk@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: device-mapper: fix TB stripe data corruption
X-Message-Flag: Warning: May contain useful information
References: <20050121181203.GI10195@agk.surrey.redhat.com>
	<20050121203354.GC2265@kvack.org>
	<200501211512.45524.kevcorry@us.ibm.com>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 21 Jan 2005 13:20:31 -0800
In-Reply-To: <200501211512.45524.kevcorry@us.ibm.com> (Kevin Corry's message
 of "Fri, 21 Jan 2005 15:12:45 -0600")
Message-ID: <52651qqy1s.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 21 Jan 2005 21:20:32.0113 (UTC) FILETIME=[09E78E10:01C4FFFF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Kevin> We have to take a mod of the chunk value and the number of
    Kevin> stripes (which can be a non-power-of-2, so a shift won't
    Kevin> work). It's been my understanding that you couldn't mod a
    Kevin> 64-bit value with a 32-bit value in the kernel.

If I understand you correctly, do_div() (defined in <asm/div64.h>)
does what you need.  Look at asm-generic/div64.h for a good
description of the precise semantics of do_div().

 - Roland
