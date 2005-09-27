Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbVI0D7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbVI0D7m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 23:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbVI0D7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 23:59:42 -0400
Received: from mailhub.hp.com ([192.151.27.10]:36503 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S1750837AbVI0D7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 23:59:41 -0400
Subject: Re: [PATCH] sys_sendmsg() alignment bug fix
From: Alex Williamson <alex.williamson@hp.com>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <2cd57c90050926204022fb22ca@mail.gmail.com>
References: <1127764921.6529.60.camel@tdi>
	 <2cd57c90050926204022fb22ca@mail.gmail.com>
Content-Type: text/plain
Organization: OSLO R&D
Date: Mon, 26 Sep 2005 21:59:34 -0600
Message-Id: <1127793575.25276.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-27 at 11:40 +0800, Coywolf Qi Hunt wrote:
> On 9/27/05, Alex Williamson <alex.williamson@hp.com> wrote:
> >    The patch below adds an alignment attribute to the buffer used in
> > sys_sendmsg().  This eliminates an unaligned access warning on ia64.
> 
> Is this a warning fix or bug fix?

  Guess I'd have to classify it as a warning fix.  ia64 is fairly
verbose about unaligned accesses by default, so the warning is printed
out runtime.

	Alex

