Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWC0ATm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWC0ATm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 19:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWC0ATm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 19:19:42 -0500
Received: from ns.suse.de ([195.135.220.2]:20415 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932266AbWC0ATk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 19:19:40 -0500
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] fix delay_tsc (was Re: delay_tsc(): inefficient delay loop (2.6.16-mm1))
Date: Mon, 27 Mar 2006 01:18:52 +0200
User-Agent: KMail/1.8
Cc: Ray Lee <madrabbit@gmail.com>, Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@brodo.de>, John Stultz <johnstul@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <200603261647_MC3-1-BB98-CB09@compuserve.com>
In-Reply-To: <200603261647_MC3-1-BB98-CB09@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603270118.53102.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm running a system with this applied now.  I think there are still
> problems if someone uses huge delays, though.  What keeps someone from
> trying to delay for > 2^31 cycles?

You shouldn't. The caller has a compile time check for that. And if you pass 
in dynamic values you get what you deserve.

-Andi
