Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbUJYUab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbUJYUab (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 16:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbUJYUaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 16:30:15 -0400
Received: from cantor.suse.de ([195.135.220.2]:57828 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261301AbUJYUY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 16:24:59 -0400
Date: Mon, 25 Oct 2004 22:23:05 +0200
From: Andi Kleen <ak@suse.de>
To: linux-os@analogic.com
Cc: Andi Kleen <ak@suse.de>, Corey Minyard <minyard@acm.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Race betwen the NMI handler and the RTC clock in practially all kernels
Message-ID: <20041025202305.GH9142@wotan.suse.de>
References: <417D2305.3020209@acm.org.suse.lists.linux.kernel> <p73u0sik2fa.fsf@verdi.suse.de> <Pine.LNX.4.61.0410251553400.3949@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410251553400.3949@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One should never use the write-offset-address/read-value
> sequence of the CMOS as some kind of timer. You don't

Linux doesn't use it as timer. It just wants to change the 
NMI enable bit, which for some unknown reason is in the same register.

-Andi
