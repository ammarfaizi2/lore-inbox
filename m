Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbVFWEQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbVFWEQV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 00:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVFWEQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 00:16:20 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:59572 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262035AbVFWEQS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 00:16:18 -0400
References: <5009AD9521A8D41198EE00805F85F18F067F6A36@sembo111.teknor.com>
            <84144f020506221243163d06a2@mail.gmail.com>
            <20050622203211.GI8907@alpha.home.local>
In-Reply-To: <20050622203211.GI8907@alpha.home.local>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Willy Tarreau <willy@w.ods.org>
Cc: Pekka Enberg <penberg@gmail.com>,
       "Bouchard, Sebastien" <Sebastien.Bouchard@ca.kontron.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Lorenzini, Mario" <mario.lorenzini@ca.kontron.com>
Subject: Re: Patch of a new driver for kernel 2.4.x that need review
Date: Thu, 23 Jun 2005 07:16:17 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42BA3791.000006F9@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy, 

Willy Tarreau writes:
> I dont agree with you here : enums are good to simply specify an ordering.
> But they must not be used to specify static mapping. Eg: if REG4 *must* be
> equal to BASE+4, you should not use enums, otherwise it will render the
> code unreadable. I personnaly don't want to count the position of REG7 in
> the enum to discover that it's at BASE+7.

Sorry, what do you have to count with the following? 

enum {
       TLCLK_REG0 = TLCLK_BASE,
       TLCLK_REG1 = TLCLK_BASE+1,
       TLCLK_REG2 = TLCLK_BASE+2,
}; 

Please note that enums are a general way of specifying _constants_ with the 
type int, not necessarily named enumerations. 

Willy Tarreau writes:
> if you need something more verbose to say exactly "write 7 to port 123",
> it's better to use defines (or even variables sometimes) than enums.

I would agree on variables (for some special cases) but not for defines. The 
problem with defines is that you can override a constant without even 
noticing it. Therefore, always use enums when you can, and defines only when 
you must. 

                  Pekka 

