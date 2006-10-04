Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422713AbWJDSDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422713AbWJDSDt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 14:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422714AbWJDSDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 14:03:49 -0400
Received: from gateway-1237.mvista.com ([63.81.120.155]:42174 "EHLO
	imap.sh.mvista.com") by vger.kernel.org with ESMTP id S1422713AbWJDSDr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 14:03:47 -0400
Message-ID: <4523F77B.1030908@ru.mvista.com>
Date: Wed, 04 Oct 2006 22:03:39 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in libata-dev.git
References: <20060911132250.GA5178@havoc.gtf.org> <45056627.7030202@ru.mvista.com> <4523F602.6070608@rtr.ca>
In-Reply-To: <4523F602.6070608@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Mark Lord wrote:

>>>       [ATA] Increase lba48 max-sectors from 200 to 256.

>>    So was it for LBA28 or for LBA48?
>>    As for LBA28, it might be quite dangerous. Particularly, I know 
>> that IBM drives used to mistreated 256 as 0 in the past (bumped into 
>> that on a 8-year old drive which is still alive though).

> ..

>> The exact model was IBM DHEA-34331.

> I've been travelling for the past month, so pardon the late tuning in here.
> I've *never* encountered a drive that had this problem.
> Controllers, yes, and those are easily dealt with in the chipset drivers.
> 
> But never drives.  Not since 1992 when I first took up Linux IDE stuff.
> 
> I have some 7-year old IBM drives here, and they certainly don't have
> this problem either (but they do have working TCQ etc..).

    That was 8-year old Ultra33 drive, what TCQ? :-)

> I suspect Sergei simply had a bad controller card at the time.

    I can hardly imagine the reason why a PCI IDE controller (that was 
something like VT82C586 I think) would need to mess with the sector count reg. 
in PIO mode and return "command aborted" in the error reg... That was the 
exact sympthom IIRC.

> Cheers

WBR, Sergei
