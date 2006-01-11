Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932618AbWAKSul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618AbWAKSul (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 13:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbWAKSul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 13:50:41 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:41743 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932618AbWAKSuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 13:50:40 -0500
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1 of 3] Introduce __raw_memcpy_toio32
X-Message-Flag: Warning: May contain useful information
References: <adaslrw3zfu.fsf@cisco.com>
	<1136909276.32183.28.camel@serpentine.pathscale.com>
	<20060110170722.GA3187@infradead.org>
	<1136915386.6294.8.camel@serpentine.pathscale.com>
	<20060110175131.GA5235@infradead.org>
	<1136915714.6294.10.camel@serpentine.pathscale.com>
	<20060110140557.41e85f7d.akpm@osdl.org>
	<1136932162.6294.31.camel@serpentine.pathscale.com>
	<20060110153257.1aac5370.akpm@osdl.org>
	<1137000032.11245.11.camel@camp4.serpentine.com>
	<20060111172216.GA18292@mars.ravnborg.org>
	<20060111093019.097d156a.akpm@osdl.org>
	<1137001400.11245.31.camel@camp4.serpentine.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 11 Jan 2006 10:49:38 -0800
In-Reply-To: <1137001400.11245.31.camel@camp4.serpentine.com> (Bryan
 O'Sullivan's message of "Wed, 11 Jan 2006 09:43:19 -0800")
Message-ID: <adairsq1tx9.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 11 Jan 2006 18:49:39.0934 (UTC) FILETIME=[C707E7E0:01C616DF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bryan> I'll take a look at whether the extra call/ret indirection
    Bryan> affects performance in a measurable fashion.

Your current implementation is out-of-line, right?

I would be surprised if calling a function has any overhead on x86_64,
since the function call is a jump that can be predicted perfectly.
The only issue is the code to shuffle values into the right registers.

 - R.
