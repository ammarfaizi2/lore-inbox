Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbWHNXKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbWHNXKv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 19:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbWHNXKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 19:10:50 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:57057 "EHLO
	pd2mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S965045AbWHNXKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 19:10:50 -0400
Date: Mon, 14 Aug 2006 17:09:07 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Getting 'sync' to flush disk cache?
In-reply-to: <fa.PWNfC1odploxRBgLE1vdR69UF9s@ifi.uio.no>
To: Jens Axboe <axboe@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Arjan van de Ven <arjan@infradead.org>
Message-id: <44E10293.7000508@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.W0uMWcngieRXsM23OSdM5c2wdZI@ifi.uio.no>
 <fa.qZ/OWlxPTq6xK9TZx+9e39itX9k@ifi.uio.no>
 <fa.PWNfC1odploxRBgLE1vdR69UF9s@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Mon, Aug 14 2006, Arjan van de Ven wrote:
>> On Mon, 2006-08-14 at 14:39 -0400, Jeff Garzik wrote:
>>> So...  has anybody given any thought to enabling fsync(2), fdatasync(2), 
>>> and sync_file_range(2) issuing a [FLUSH|SYNCHRONIZE] CACHE command?
>>>
>>> This has bugged me for _years_, that Linux does not do this.  Looking at 
>>> forums on the web, it bugs a lot of other people too.
>> eh afaik 2.6.17 and such do this if you have barriers enabled...
> 
> That is correct, but it only works on reiserfs and XFS and user space
> really cannot tell whether it did the right thing or not. File system
> developers really should take this more seriously...
> 

I was under the impression that this just worked under recent kernels. 
I'm disappointed to hear that it doesn't. It always annoys me that 
issues like this sometimes just seem to stick around forever in the 
kernel without getting the attention they should (and tend not to be 
well documented either..)

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

