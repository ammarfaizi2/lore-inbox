Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVCNN0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVCNN0g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 08:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVCNN0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 08:26:36 -0500
Received: from [81.2.110.250] ([81.2.110.250]:6817 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261488AbVCNN0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 08:26:35 -0500
Subject: Re: select() doesn't respect SO_RCVLOWAT ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Felix Matathias <felix@nevis.columbia.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0503111434040.30914@shang.nevis.columbia.edu>
References: <Pine.LNX.4.61.0503101645190.29442@shang.nevis.columbia.edu>
	 <1110568180.17740.69.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0503111434040.30914@shang.nevis.columbia.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110806662.15927.108.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 14 Mar 2005 13:24:24 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-03-11 at 20:26, Felix Matathias wrote:
> Dear Alan,
> 
> I am positive. I can setsockopt, and then, getsockopt returns the value 
> that I requested.

Ok I misremembered - its SNDLOWAT that is locked to one in Linux.

> Stevens very clearly states that SO_RCVLOWAT has a direct impact on 
> select() and I assumed that this would be the case for Linux.
> What is the rationale for not complying with that ? Is it the micromanagement
> of select() that you dislike ? Isn't a significant reduction in the
> amount of read operations a real gain in high speed networking ?

I believe since we implement SO_SNDLOWAT that its a bug. Stevens and
1003.1g both agree with your expectations. The right list is probably
netdev@oss.sgi.com however.

Alan

