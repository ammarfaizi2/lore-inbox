Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263019AbTCWLIA>; Sun, 23 Mar 2003 06:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263020AbTCWLIA>; Sun, 23 Mar 2003 06:08:00 -0500
Received: from mons.uio.no ([129.240.130.14]:44244 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S263019AbTCWLH7>;
	Sun, 23 Mar 2003 06:07:59 -0500
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: RPCSVC_MAXPAGES doesn't account for overhead(?) pages
References: <Pine.LNX.4.50.0303221116250.18911-100000@montezuma.mastecende.com>
	<Pine.LNX.4.50.0303221152060.18911-100000@montezuma.mastecende.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 23 Mar 2003 12:18:57 +0100
In-Reply-To: <Pine.LNX.4.50.0303221152060.18911-100000@montezuma.mastecende.com>
Message-ID: <shs7kaqz5y6.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Zwane Mwaikambo <zwane@holomorphy.com> writes:


     > -#define RPCSVC_MAXPAGES
     > ((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE + 1) + +#define
     > RPCSVC_MAXPAGES
     > (2+((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE+1))
 
Huh? RPCSVC_MAXPAYLOAD is set at 64k. Should be quite ample for a 32k
read or write.

Cheers,
  Trond
