Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265597AbTFXAaw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 20:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265573AbTFXAaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 20:30:52 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:48870 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265597AbTFXAat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 20:30:49 -0400
Subject: Re: 2.5.7[23]: wall-clock time advancing too rapidly?
From: john stultz <johnstul@us.ibm.com>
To: Andy Pfiffer <andyp@osdl.org>
Cc: Andreas Haumer <andreas@xss.co.at>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1056413771.1209.14.camel@andyp.pdx.osdl.net>
References: <1056039012.3879.5.camel@andyp.pdx.osdl.net>
	 <1056058206.18644.532.camel@w-jstultz2.beaverton.ibm.com>
	 <3EF32223.6000207@xss.co.at> <1056151705.1162.114.camel@andyp.pdx.osdl.net>
	 <1056154072.1027.13.camel@w-jstultz2.beaverton.ibm.com>
	 <1056413771.1209.14.camel@andyp.pdx.osdl.net>
Content-Type: text/plain
Organization: 
Message-Id: <1056415040.1028.82.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 Jun 2003 17:37:20 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-23 at 17:16, Andy Pfiffer wrote:
> Hmmm... I tried the patch in 2.5.73 and it appeared to have no effect.

Ah, just when I sent it off to Andrew. Well, I've been getting a number
of successful reports, so its still good to give it further testing. 


> The system continues to advance what it thinks is wall-clock time by
> about 7.25 seconds for every 15 seconds actual wall-clock time:
[snip]
> 
> None of the printk's in the patch have been printed on the console.

Yea, it clearly isn't triggering the code. 

> Adding "clock=pit" continues to work as a workaround.
> 
> I have attached the output of dmesg from the boot of the kernel with the
> patch present.

Looking over it again you're still not showing any of the signs of
changing cpu-frequency. But the symptoms are very similar. I'm curious,
this is the x220? Do you have a service processor installed in that box?
Maybe we're running into some sort of SMI trouble?

thanks
-john

