Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263030AbTCWLb6>; Sun, 23 Mar 2003 06:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263031AbTCWLb5>; Sun, 23 Mar 2003 06:31:57 -0500
Received: from holomorphy.com ([66.224.33.161]:36247 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263030AbTCWLb4>;
	Sun, 23 Mar 2003 06:31:56 -0500
Date: Sun, 23 Mar 2003 03:42:39 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: RPCSVC_MAXPAGES doesn't account for overhead(?) pages
Message-ID: <20030323114239.GF30140@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Zwane Mwaikambo <zwane@holomorphy.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.50.0303221116250.18911-100000@montezuma.mastecende.com> <Pine.LNX.4.50.0303221152060.18911-100000@montezuma.mastecende.com> <shs7kaqz5y6.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <shs7kaqz5y6.fsf@charged.uio.no>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

" " == Zwane Mwaikambo <zwane@holomorphy.com> writes:
>> -#define RPCSVC_MAXPAGES
>> ((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE + 1) + +#define
>> RPCSVC_MAXPAGES
>> (2+((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE+1))

On Sun, Mar 23, 2003 at 12:18:57PM +0100, Trond Myklebust wrote:
> Huh? RPCSVC_MAXPAYLOAD is set at 64k. Should be quite ample for a 32k
> read or write.

Sure, there's just a dependency on PAGE_SIZE we're trying to get sorted
out here. If PAGE_SIZE is 64KB (e.g. IA64, pgcl) then this trips a BUG().


-- wli
