Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268849AbUHLWcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268849AbUHLWcE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 18:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268837AbUHLWcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 18:32:03 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:11396 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S268870AbUHLWbR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 18:31:17 -0400
Message-ID: <411BF083.8060406@tmr.com>
Date: Thu, 12 Aug 2004 18:34:43 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: mail.linux-kernel
To: Con Kolivas <kernel@kolivas.org>
CC: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk, dwmw2@infradead.org,
       schilling@fokus.fraunhofer.de, axboe@suse.de
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <1092099669.5759.283.camel@cube> <cone.1092113232.42936.29067.502@pc.kolivas.org>
In-Reply-To: <cone.1092113232.42936.29067.502@pc.kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

> It was a hard lockup and randomly happened during a cd write, creating 
> my first coaster in a long time... in rt mode ironically which is how it 
> is recommended to be run. So I removed the foolish superuser bit and 
> have had no problem since. Yes it was unaltered cdrecord source and it 
> was the so-called alpha branch and... Not much else I can say about it 
> really?

I said I'd never seen this (true), but it could happen if you were 
burning an audio CD using the ide-scsi or ATA: interface. In 2.6 the 
ATAPI: interface uses DMA. I don't know what the program does if you 
just say dev=/dev/hdx, I don't normally use it that way (I got into the 
habit of using ATAPI:). Given a fast burner and the interface using PIO, 
I guess you could slow the system down some!

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
