Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263323AbTD0DPO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 23:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263337AbTD0DPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 23:15:14 -0400
Received: from colin.muc.de ([193.149.48.1]:12555 "HELO colin.muc.de")
	by vger.kernel.org with SMTP id S263323AbTD0DPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 23:15:13 -0400
Message-ID: <20030427052713.19557@colin.muc.de>
Date: Sun, 27 Apr 2003 05:27:13 +0200
From: Andi Kleen <ak@muc.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Alternative patching for prefetches & cleanup
References: <20030427051451.43064@colin.muc.de> <Pine.LNX.4.44.0304262021190.25498-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.88e
In-Reply-To: <Pine.LNX.4.44.0304262021190.25498-100000@home.transmeta.com>; from Linus Torvalds on Sun, Apr 27, 2003 at 05:22:58AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 27, 2003 at 05:22:58AM +0200, Linus Torvalds wrote:
> 
> On Sun, 27 Apr 2003, Andi Kleen wrote:
> > 
> > Hmm. I thought using the Fibonaci sequence for this was clever :-)
> 
> That's not the fibonacci sequence, that's just a regular sigma(i)  
> (i=1..n) sequence. And if you were to generate the sequence numbers at
> compile-time I might agree with you, if you also were to avoid using 
> inline asms.

True %)

The real reason I did it was to avoid having two sets of macros - one
with .byte 0x... and another with string "\x..\x..."

Now it needs duplication.

-Andi
