Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbWEBPze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWEBPze (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 11:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWEBPze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 11:55:34 -0400
Received: from stinky.trash.net ([213.144.137.162]:11684 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S964898AbWEBPzd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 11:55:33 -0400
Message-ID: <445780F2.8080102@trash.net>
Date: Tue, 02 May 2006 17:55:30 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, coreteam@netfilter.org,
       linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [netfilter-core] Re: [lockup] 2.6.17-rc3: netfilter/sctp: lockup
 in	sctp_new(), do_basic_checks()
References: <20060502113454.GA28601@elte.hu> <1146584081.19488.57.camel@localhost>
In-Reply-To: <1146584081.19488.57.camel@localhost>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcel Holtmann wrote:
> Hi Ingo,
> 
> 
>>running an "isic" stresstest on and against a testbox [which, amongst 
>>other things, generates random incoming and outgoing packets] on 
>>2.6.17-rc3 (and 2.6.17-rc3-mm1) over gigabit results in a reproducible 
>>lockup, after 5-10 minutes of runtime:
> 
> 
> does this lockup the local machine you run the stresstest on or the
> remote machine you run the test against?

It would lock up any machine with the SCTP conntrack module loaded.
I'll prepare a patch for -stable as well.

