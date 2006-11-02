Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752719AbWKBWyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719AbWKBWyZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 17:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752721AbWKBWyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 17:54:25 -0500
Received: from alpha.polcom.net ([83.143.162.52]:5040 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S1752719AbWKBWyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 17:54:24 -0500
Date: Thu, 2 Nov 2006 23:54:17 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
In-Reply-To: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.63.0611022346450.14187@alpha.polcom.net>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2 Nov 2006, Mikulas Patocka wrote:
> As my PhD thesis, I am designing and writing a filesystem, and it's now in a 
> state that it can be released. You can download it from 
> http://artax.karlin.mff.cuni.cz/~mikulas/spadfs/

"Disk that can atomically write one sector (512 bytes) so that the sector
contains either old or new content in case of crash."

Well, maybe I am completly wrong but as far as I understand no disk 
currently will provide such requirement. Disks can have (after halted 
write):
- old data,
- new data,
- nothing (unreadable sector - result of not full write and disk internal 
checksum failute for that sector, happens especially often if you have 
frequent power outages).

And possibly some broken drives may also return you something that they 
think is good data but really is not (shouldn't happen since both disks 
and cables should be protected by checksums, but hey... you can never be 
absolutely sure especially on very big storages).

So... isn't this making your filesystem a little flawed in design?


Thanks,

Grzegorz Kulewski

