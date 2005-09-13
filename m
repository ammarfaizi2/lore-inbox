Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbVIMEAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbVIMEAe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 00:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbVIMEAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 00:00:34 -0400
Received: from dvhart.com ([64.146.134.43]:5762 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S932134AbVIMEAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 00:00:33 -0400
Date: Mon, 12 Sep 2005 21:00:35 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm2
Message-ID: <254410000.1126584034@[10.10.2.4]>
In-Reply-To: <20050912170852.17579ed5.akpm@osdl.org>
References: <20050908053042.6e05882f.akpm@osdl.org><201750000.1126494444@[10.10.2.4]><20050912050122.GA3830@muc.de><150330000.1126548402@flay><20050912185120.GA78614@muc.de><210290000.1126565170@flay> <20050912170852.17579ed5.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Andrew Morton <akpm@osdl.org> wrote (on Monday, September 12, 2005 17:08:52 -0700):

> "Martin J. Bligh" <mbligh@mbligh.org> wrote:
>> 
>> 
>> 
>> --On Monday, September 12, 2005 20:51:20 +0200 Andi Kleen <ak@muc.de> wrote:
>> 
>> >> Crashes on boot
>> >> 
>> >> http://test.kernel.org/12589/debug/console.log
>> >> 
>> >> May or may not be anything to do with what you were doing.
>> > 
>> > Easily tested by reverting dma32*. Does it help?
>> 
>> No. Yet *another* bug. Sigh.
>> 
> 
> You should see all the ones I fixed.

Yeah, sorry, I know. Don't know how you cope at all.
 
> Suggest you skip -mm2 altogether.  We already know that
> scheduler-cache-hot-autodetect.patch is bad, and that was dropped from mm3.

-mm3 looks much better, seems to work on ia32 and x86_64 at least.

PPC64 is still broken by the tty cleanup stuff. there were some fixes
going back and forth ... hopefully someone will gather them and push
to you soon, would nice to be testing that again.

drivers/char/hvc_console.c: In function `hvc_poll':
drivers/char/hvc_console.c:600: error: `count' undeclared (first use in this function)
drivers/char/hvc_console.c:600: error: (Each undeclared identifier is reported only once
drivers/char/hvc_console.c:600: error: for each function it appears in.)
drivers/char/hvc_console.c:636: error: structure has no member named `flip'

Thanks for everything ... testing just makes one bitter ;-)

M.

