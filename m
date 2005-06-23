Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262102AbVFWEuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbVFWEuy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 00:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVFWEuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 00:50:54 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:65036 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262102AbVFWEua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 00:50:30 -0400
Date: Thu, 23 Jun 2005 06:49:52 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: Pekka Enberg <penberg@gmail.com>,
       "Bouchard, Sebastien" <Sebastien.Bouchard@ca.kontron.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Lorenzini, Mario" <mario.lorenzini@ca.kontron.com>
Subject: Re: Patch of a new driver for kernel 2.4.x that need review
Message-ID: <20050623044952.GA21017@alpha.home.local>
References: <5009AD9521A8D41198EE00805F85F18F067F6A36@sembo111.teknor.com> <84144f020506221243163d06a2@mail.gmail.com> <20050622203211.GI8907@alpha.home.local> <courier.42BA3791.000006F9@courier.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <courier.42BA3791.000006F9@courier.cs.helsinki.fi>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pekka,

On Thu, Jun 23, 2005 at 07:16:17AM +0300, Pekka J Enberg wrote:
> Hi Willy, 
> 
> Willy Tarreau writes:
> >I dont agree with you here : enums are good to simply specify an 
> >ordering.
> >But they must not be used to specify static mapping. Eg: if REG4 *must* 
> >be
> >equal to BASE+4, you should not use enums, otherwise it will render the
> >code unreadable. I personnaly don't want to count the position of REG7 in
> >the enum to discover that it's at BASE+7.
> 
> Sorry, what do you have to count with the following? 
> 
> enum {
>       TLCLK_REG0 = TLCLK_BASE,
>       TLCLK_REG1 = TLCLK_BASE+1,
>       TLCLK_REG2 = TLCLK_BASE+2,
> }; 

Sorry for the noise, I replied in a second mail that I was perfectly OK
with this usage. What I though you wanted to propose was the simplest for
of enum where only the first value is specified, and which is a nightmare
to debug afterwards. Bill Gatliff also suggested that gdb can display and
use the symbolic values while it's not the case on defines.
 
Regards,
Willy

