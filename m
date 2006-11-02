Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752648AbWKBXM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648AbWKBXM0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 18:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbWKBXM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 18:12:26 -0500
Received: from sp604005mt.neufgp.fr ([84.96.92.11]:46728 "EHLO smtp.Neuf.fr")
	by vger.kernel.org with ESMTP id S1750698AbWKBXMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 18:12:25 -0500
Date: Fri, 03 Nov 2006 00:10:20 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: New filesystem for Linux
In-reply-to: <Pine.LNX.4.63.0611022346450.14187@alpha.polcom.net>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       linux-kernel@vger.kernel.org
Message-id: <454A7ADC.4030203@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
 <Pine.LNX.4.63.0611022346450.14187@alpha.polcom.net>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Kulewski a écrit :
> Hi,
> 
> On Thu, 2 Nov 2006, Mikulas Patocka wrote:
>> As my PhD thesis, I am designing and writing a filesystem, and it's 
>> now in a state that it can be released. You can download it from 
>> http://artax.karlin.mff.cuni.cz/~mikulas/spadfs/
> 
> "Disk that can atomically write one sector (512 bytes) so that the sector
> contains either old or new content in case of crash."
> 
> Well, maybe I am completly wrong but as far as I understand no disk 
> currently will provide such requirement. Disks can have (after halted 
> write):
> - old data,
> - new data,
> - nothing (unreadable sector - result of not full write and disk 
> internal checksum failute for that sector, happens especially often if 
> you have frequent power outages).
> 

I believe some vendors have such devices. Mikulas called them 'disk', but it's 
in fact a (disk(s), controler, ram, battery)

Some controlers are even able to write into flash memory the un-written data 
when/if the battery/power is about to fail. When power goes up, controler can 
finaly do the writes on disks.


> And possibly some broken drives may also return you something that they 
> think is good data but really is not (shouldn't happen since both disks 
> and cables should be protected by checksums, but hey... you can never be 
> absolutely sure especially on very big storages).
> 
> So... isn't this making your filesystem a little flawed in design?

Well... even RAM can fail :) In this case isnt linux flawed in design ?


