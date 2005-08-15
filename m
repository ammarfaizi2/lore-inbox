Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbVHOWcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbVHOWcp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 18:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbVHOWcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 18:32:45 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:3083 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S965018AbVHOWco
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 18:32:44 -0400
Message-ID: <430118E9.30803@tmr.com>
Date: Mon, 15 Aug 2005 18:36:25 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>
Subject: Re: libata PATA todo list
References: <42FBBB10.9020407@pobox.com>
In-Reply-To: <42FBBB10.9020407@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Since there's been some recent interest in the subject, I thought I 
> would post the PATA todo list for libata.  Some of these items are from 
> my memory, and some are from a list Alan was kind enough to create.  The 
> items verbatim from Alan are prefixed "Alan: ".


> 2) Simplex DMA
> 
> PCI IDE specification has a 'simplex' DMA bit, which should be tested. 
> Simplex means that only one command can be outstanding, for BOTH port0 
> and port1, at any given time.
> 
> Possibly some hosts also need Simplex DMA, but may not assert the 
> standard PCI IDE Simplex DMA capability bit.  I don't know.

I remember using devices which require this. Not recently.


> 4) Alan:  Command filter
> 
> Alan -- explanation?
> 
> I know one line item here, at least:  Promise controllers snoop SET 
> FEATURES - XFER MODE command.  We must stop command processing on ALL 
> ports when this command is issued, to avoid corruption.

The last time I tried, cdrecord was allowed to burn the first session of 
a multi-session CD as a user (with correct device permissions) but not 
to read the multisession info (current ISO size) to burn another 
session. I haven't tried it in the last few months, I changed my script 
to do something else. However, it really should work.

I will test this if you like, but I'm on 7x24 coverage this week and 
7x24 vacation after that, so not soon.


> 10) ATAPI DMA alignment (discussed elsewhere)
> 
> Needed even for PATA, AFAICT.

Thanks for keeping the list!

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
