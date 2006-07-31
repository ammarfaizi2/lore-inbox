Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWGaPHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWGaPHa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 11:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWGaPHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 11:07:30 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:44749 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751182AbWGaPH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 11:07:29 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Stephen Lynch <Stephen_Lynch@rocketmail.com>
Subject: Re: BUG: unable to handle kernel paging request at virtual address
Date: Mon, 31 Jul 2006 17:07:19 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060731144810.91843.qmail@web57012.mail.re3.yahoo.com>
In-Reply-To: <20060731144810.91843.qmail@web57012.mail.re3.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607311707.20373.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
