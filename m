Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267859AbUHESxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267859AbUHESxE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 14:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267768AbUHESv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 14:51:57 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:30848 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S267904AbUHESud
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 14:50:33 -0400
Message-ID: <4112823C.4070703@tmr.com>
Date: Thu, 05 Aug 2004 14:53:48 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: mail.linux-kernel
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jens Axboe <axboe@suse.de>, Zinx Verituse <zinx@epicsol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd problems
References: <20040804050144.GB8139@suse.de><20040731153609.GG23697@suse.de> <1091721152.8042.16.camel@localhost.localdomain>
In-Reply-To: <1091721152.8042.16.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mer, 2004-08-04 at 06:01, Jens Axboe wrote:
> 
>>Absolutely not. I've already outlined why in my previous mails I don't
>>want to see anything like this, and this patch is even worse than
>>filtering. Additionally, you risk breaking existing programs.
> 
> 
> Existing broken programs. 
> 
> Once you do filtering so you don't need CAP_SYS_RAWIO to lob some
> commands at a device that becomes the place to enforce sensible policies
> because the filter knows what is "read" and what is "write" so it can do
> different checks for say "eject" (read) "write" (write) and "erase
> firmware" (raw I/O)

Would it be reasonable to have a general list (SCSI-II standard or so) 
and then a list of vendor commands in the driver? I really think that 
legitimate user programs will be using well-defined commands, after all 
that's why there is a standard. So requiring raw access for that may not 
be an issue.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
