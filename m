Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWHNHjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWHNHjw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 03:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751915AbWHNHjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 03:39:51 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:43968 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750867AbWHNHjv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 03:39:51 -0400
Date: Mon, 14 Aug 2006 11:31:54 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Neil Brown <neilb@suse.de>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       Daniel Phillips <phillips@google.com>,
       David Miller <davem@davemloft.net>, riel@redhat.com, tgraf@suug.ch,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, Mike Christie <michaelc@cs.wisc.edu>
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
Message-ID: <20060814073154.GB5161@2ka.mipt.ru>
References: <44DFA225.1020508@google.com> <20060813.165540.56347790.davem@davemloft.net> <44DFD262.5060106@google.com> <20060813185309.928472f9.akpm@osdl.org> <1155530453.5696.98.camel@twins> <20060813215853.0ed0e973.akpm@osdl.org> <1155531835.5696.103.camel@twins> <20060813222208.7e8583ac.akpm@osdl.org> <1155537940.5696.117.camel@twins> <17632.9097.195772.410011@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <17632.9097.195772.410011@cse.unsw.edu.au>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 14 Aug 2006 11:32:01 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 05:17:29PM +1000, Neil Brown (neilb@suse.de) wrote:
> Would it be too much waste to reserve one page for every idle socket? 
> 
> Does this have some fatal flaw?

Yep, in some cases number of sockets is unlimited, but number of total
memory they can eat is limited already as David mentioned by tcp_?mem[].

> NeilBrown

-- 
	Evgeniy Polyakov
