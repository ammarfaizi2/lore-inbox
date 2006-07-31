Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbWGaRsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbWGaRsN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 13:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbWGaRsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 13:48:13 -0400
Received: from web57002.mail.re3.yahoo.com ([66.196.97.106]:36444 "HELO
	web57002.mail.re3.yahoo.com") by vger.kernel.org with SMTP
	id S1030290AbWGaRsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 13:48:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rocketmail.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=h/OZPBwjG+TZcvDjwTSUBw1QUfAKrXJ0GUDPiR+cpwIua2KlfHjGu8O7zMa/zNC2JR4GNsh1BGkCjqUV1jo+14oFBHo74yoop6PrMimyi+fJ6rkyf6NTrNEXhr+WcckuB5C3AfMxGYRPGvEL3oiIHw76WZK+xeJw3p/2laW+Yz0=  ;
Message-ID: <20060731174811.45958.qmail@web57002.mail.re3.yahoo.com>
Date: Mon, 31 Jul 2006 10:48:11 -0700 (PDT)
From: Stephen Lynch <Stephen_Lynch@rocketmail.com>
Reply-To: Stephen Lynch <Stephen_Lynch@rocketmail.com>
Subject: Re: BUG: unable to handle kernel paging request at virtual address
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200607311707.20373.ioe-lkml@rameria.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

I thought that oringally and ran memtest on it for 8hrs. Not a long time I know, but there were no errors. If you reckon running it for 24hrs solid might display a memory problem I will try again.

This is my only machine running linux, so I dont have any identical hardware to test against.

Thanks,
Stephen

----- Original Message ----
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Stephen Lynch <Stephen_Lynch@rocketmail.com>
Cc: linux-kernel@vger.kernel.org
Sent: Monday, July 31, 2006 4:07:19 PM
Subject: Re: BUG: unable to handle kernel paging request at virtual address

Hi Stephen,

On Monday, 31. July 2006 16:48, Stephen Lynch wrote:
> I've had the two crashes below in the past couple of weeks. 
> On one occasion it was while I was copying large amounts of files 
> from one drive to another when it happened, 
> which lead me to believe it is related to my hdd. 
> I have ran the manufacturer's diagnostic utils on it and it came back clean, 
> but im not sure whether to trust it or not. 
> Can anybody tell me what they reckon is causing the issue.      
> 
> Jul 13 13:14:53 dublin kernel: BUG: unable to handle kernel paging request at virtual address 00080000

This might be single bit (memory) error leading to failed NULL checks.

e.g. 

if (pointer == NULL) 
   goto bail_out;

will fail.

Could you run memtest on this machine?

Did you see it on any other machine with identical hardware?
Did see it on any other machine at all?


Regards

Ingo Oeser
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



