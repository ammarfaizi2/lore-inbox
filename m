Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269690AbUJMMsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269690AbUJMMsP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 08:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269692AbUJMMsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 08:48:15 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:9954 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S269690AbUJMMsK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 08:48:10 -0400
Message-ID: <416D2406.1040002@drzeus.cx>
Date: Wed, 13 Oct 2004 14:48:06 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040919)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Choosing scatter/gather limits
References: <416A6623.9000105@drzeus.cx> <20041013122234.A23105@flint.arm.linux.org.uk>
In-Reply-To: <20041013122234.A23105@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>On Mon, Oct 11, 2004 at 12:53:23PM +0200, Pierre Ossman wrote:
>  
>
>>I've been adding scatter/gather support for the MMC host driver I'm 
>>writing. I cannot find any documentation on how to chose the limits though.
>>    
>>
>
>It seems that you have to read the block layer code to find out what's
>going on with these limits.  There's some documentation on it in
>Documentation/block/bio.txt.  If it's lacking, then please send
>comments to the block layer people to add the necessary information.
>
>  
>
I just wanted to make sure I don't pick values that causes problems 
somewhere else. I'll make an attempt to dig through the bio code though.

>Please also note that I'm intending to make the MMC host drivers
>know nothing about block IO stuff, so all you'll be passed is the
>MMC commands and a scatter gather list - so making sure that your
>driver always uses blk_rq_map_sg() and works from the SG list will
>ensure that your driver remains easy to update.
>
>  
>
Shouldn't be a problem. The SGIO support in the driver is done. Just 
need to get rid of all bugs.

Rgds
Pierre


