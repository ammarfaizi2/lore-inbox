Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbTFXWLR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 18:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTFXWLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 18:11:17 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:28940 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S263171AbTFXWLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 18:11:15 -0400
Message-ID: <3EF8D3A9.4040109@techsource.com>
Date: Tue, 24 Jun 2003 18:41:45 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: John Bradford <john@grabjohn.com>, felipe_alfaro@linuxmail.org,
       linux-kernel@vger.kernel.org
Subject: Re: O(1) scheduler & interactivity improvements
References: <200306231244.h5NCiE1Q000920@81-2-122-30.bradfords.org.uk> <20030623163234.GA1184@hh.idb.hist.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Helge Hafting wrote:
> On Mon, Jun 23, 2003 at 01:44:14PM +0100, John Bradford wrote:
> 
>>Well, no, opaque window moving is fine if the CPU isn't at 100%.  If
>>it is, I'd rather see choppy window movements than have a server
>>application starved of CPU.  That's just my preference, though.
>>
> 
> That could be an interesting hack to a window manager - 
> don't start the move in opaque mode when the load is high.

This isn't really an issue if the graphics engine is doing the work and 
the X server doesn't busy-wait on the bitblt to finish (ie. does DMA or 
calls ioctl to sleep until command-fifo-has-free-space interrupt).

