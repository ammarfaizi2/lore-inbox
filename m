Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbVCRPaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVCRPaP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 10:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVCRP0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 10:26:33 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:45288 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261639AbVCRP0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 10:26:00 -0500
Date: Fri, 18 Mar 2005 10:25:54 -0500
To: Hong Kong Phoey <hongkongphoey@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DM9000 network driver
Message-ID: <20050318152554.GH17865@csclub.uwaterloo.ca>
References: <20050318133143.GA20838@metis.extern.pengutronix.de> <4f6c1bdf0503180711148b8f02@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f6c1bdf0503180711148b8f02@mail.gmail.com>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2005 at 08:41:52PM +0530, Hong Kong Phoey wrote:
> Sacrificing readibility a little bit, you could do something useful.
> Instead of those ugly switch statements you could define function
> pointer arrays and call appropriate function
> 
> switch(foo) {
> 
>   case 1:
>              f1();
>   case2 :
>              f2();
> };
> 
> could well become
> 
> void (*func)[] = { f1, f2 };
> 
> func(i);

Ewww!

How about sticking with obvious readable code rather than trying to save
a couple of conditional branches.  If it is an obvious good
optimization, let the compiler do it.  of course if you ever needed to
pass different parameters to f1 and/or f2 it would have to be rewritten
back to the original again.

Len Sorensen
