Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267223AbUFZXII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267223AbUFZXII (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 19:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267226AbUFZXIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 19:08:07 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:1037 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S267223AbUFZXIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 19:08:04 -0400
Date: Sun, 27 Jun 2004 01:08:01 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Oliver Neukum <oliver@neukum.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Pete Zaitcev <zaitcev@redhat.com>,
       greg@kroah.com, arjanv@redhat.com, jgarzik@redhat.com,
       tburke@redhat.com, linux-kernel@vger.kernel.org,
       stern@rowland.harvard.edu, mdharm-usb@one-eyed-alien.net,
       david-b@pacbell.net
Subject: Re: drivers/block/ub.c
Message-ID: <20040626230801.GF5526@pclin040.win.tue.nl>
References: <20040626130645.55be13ce@lembas.zaitcev.lan> <200406262235.15688.oliver@neukum.org> <20040626225435.GE5526@pclin040.win.tue.nl> <200406270059.04436.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406270059.04436.oliver@neukum.org>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : kweetal.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2004 at 12:59:04AM +0200, Oliver Neukum wrote:

>>>>+	cmd->cdb[2] = block >> 24;
>>>>+	cmd->cdb[3] = block >> 16;
>>>>+	cmd->cdb[4] = block >> 8;
>>>>+	cmd->cdb[5] = block;
>>> 
>>> we have macros for that.
>>> 
>>>>+	cmd->cdb[7] = nblks >> 8;
>>>>+	cmd->cdb[8] = nblks;
>>> 
>>> dito
>>
>> Yes, we have macros. Using those macros would not at all be an improvement here.
> 
> How do you arrive at that unusual conclusion?

The above writes clearly and simply what one wants.
I expect that you propose writing

	*((u32 *)(cmd->cdb + 2)) = cpu_to_be32(block);

or some similar unspeakable ugliness.
If you had something else in mind, please reveal what.
