Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265075AbUGGLsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265075AbUGGLsi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 07:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265083AbUGGLsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 07:48:38 -0400
Received: from web41103.mail.yahoo.com ([66.218.93.19]:16421 "HELO
	web41103.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265075AbUGGLsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 07:48:37 -0400
Message-ID: <20040707114836.29295.qmail@web41103.mail.yahoo.com>
Date: Wed, 7 Jul 2004 04:48:36 -0700 (PDT)
From: tom st denis <tomstdenis@yahoo.com>
Subject: Re: Prohibited attachment type (was 0xdeadbeef)
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0407070715380.17430@chaos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> Tom is correct. A literal constant defaults to 'int'.

I did a bit more messing around with GCC and it seems in 

int x = 4;
if (x == 0xDEADBEEF) { ... }

It will warn that 0xDEADBEEF is unsigned (which it isn't).  Either
there is an obscure clause in the C standard [I personally don't have a
copy of C99 nor do I plan on reading it for this] or GCC cause an
incorrect diagnostic [which isn't in violation of the standards...]

Really GCC should just warn that 0xDEADBEEF is not a valid int constant
[for portability sake...].   It's simple, any constant > 16-bits should
have a UL/L or ULL/LL suffix.

Tom


	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
