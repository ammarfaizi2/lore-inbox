Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWH0SDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWH0SDW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 14:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWH0SDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 14:03:22 -0400
Received: from smtpout.mac.com ([17.250.248.181]:18922 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932221AbWH0SDV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 14:03:21 -0400
In-Reply-To: <20060827171728.GB3502@wohnheim.fh-wedel.de>
References: <20060824134430.GB17132@wohnheim.fh-wedel.de> <20060827053245.GA15747@gen.formicary.org> <20060827171728.GB3502@wohnheim.fh-wedel.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <E23E222F-25F8-4C2A-8E16-D4B30C01AFDB@mac.com>
Cc: Ian Lindsay <iml@formicary.org>, fsdevel@wohnheim.fh-wedel.de,
       linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Content-Transfer-Encoding: 8BIT
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: LogFS
Date: Sun, 27 Aug 2006 14:02:51 -0400
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAQAAA+k=
X-Language-Identified: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 27, 2006, at 13:17:28, Jörn Engel wrote:
> On Sun, 27 August 2006 01:32:45 -0400, Ian Lindsay wrote:
>>  +/* FIXME: This should really be somewhere in the 64bit area. */
>>  +#define LOGFS_LINK_MAX (2^30)
>>
>> Interesting choice of constant.
>
> Yes.  I didn't spend a long time thinking about whether it should  
> be 2^31 or 2^31-1 or 2^31-2.  It will be a while before it becomes  
> an issue in real life anyway. :)

Uhm, I think his point is that "^" is the xor operation:
   2^30   == 28
   2^31   == 29
   2^21-1 == 28
   2^21-2 == 31

Probably what you wanted was something more like this:

   # define LOGFS_LINK_MAX (1<<30)

Cheers,
Kyle Moffett

