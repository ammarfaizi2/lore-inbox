Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVGUJl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVGUJl7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 05:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbVGUJl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 05:41:59 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:57574 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261727AbVGUJlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 05:41:52 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: amd64-agp vs. swsusp
Date: Thu, 21 Jul 2005 11:41:46 +0200
User-Agent: KMail/1.8.1
Cc: Andreas Steinmetz <ast@domdv.de>, Pavel Machek <pavel@suse.cz>,
       Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
References: <42DD67D9.60201@stud.feec.vutbr.cz> <200507210123.16537.rjw@sisk.pl> <42DEF96E.60103@stud.feec.vutbr.cz>
In-Reply-To: <42DEF96E.60103@stud.feec.vutbr.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507211141.47316.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 21 of July 2005 03:25, Michal Schmidt wrote:
> Rafael J. Wysocki wrote:
> > On Thursday, 21 of July 2005 00:07, Michal Schmidt wrote:
> >>I also tried putting a printk before restore_processor_state(), but I'm 
> >>not sure if it is safe to use printk there.
> > 
> > 
> > Yes, it is, but you may be unable to see the message if the box reboots before
> > it can be displayed.
> 
> OK, but then I also tried putting a 5s long busy wait there and the 
> reset was not delayed. Therefore, the reset must be occurring before 
> restore_processor_state().
> Or is there a reason why
> 	for(i=0; i<5000; i++)
> 		udelay(1000);
> wouldn't work as expected?

No, it should work, AFAIK.  Then it looks like something gets copied into a wrong
place or in a wrong order while restoring the image.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
