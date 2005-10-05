Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932586AbVJEJMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586AbVJEJMS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 05:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbVJEJMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 05:12:17 -0400
Received: from [85.21.88.2] ([85.21.88.2]:40610 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S932586AbVJEJMR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 05:12:17 -0400
Message-ID: <4343994B.6060306@ru.mvista.com>
Date: Wed, 05 Oct 2005 13:13:47 +0400
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org,
       spi-devel-general@lists.sourceforge.net, basicmark@yahoo.com,
       stephen@streetfiresound.com, dpervushin@gmail.com,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH/RFC 1/2] simple SPI framework
References: <20051004180241.0EAA5EE8D1@adsl-69-107-32-110.dsl.pltn13.pacbell.net> <4343898D.1060904@ru.mvista.com> <20051005090129.GB7208@flint.arm.linux.org.uk>
In-Reply-To: <20051005090129.GB7208@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>The third parameter is obsolete and should only be used to select _one_
>of the tree suspend calls you will get.
>
>Any additional suspend calls should _not_ create extra usage of this
>parameter.  It's a left over from Pat's first driver model incarnation
>which is specific to the platform device drivers.  (Mainly it exists
>because no one can be bothered to clean it up.)
>
>  
>
Oops... I mixed it with state parameter.
We need to track down the state parameter to setup wakeups.
The mixture was mostly provocated by using 'pm_message_t' instead of 
'state' in David's suspend fucntion which doesn't look right to me by 
itself.

Vitaly

