Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265763AbUGDTxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265763AbUGDTxJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 15:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265764AbUGDTxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 15:53:09 -0400
Received: from twin.uoregon.edu ([128.223.214.27]:34511 "EHLO twin.uoregon.edu")
	by vger.kernel.org with ESMTP id S265763AbUGDTxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 15:53:05 -0400
Date: Sun, 4 Jul 2004 12:53:04 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Fawad Lateef <fawad_lateef@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Need help in creating 8GB RAMDISK
In-Reply-To: <20040704092523.58214.qmail@web20806.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0407041247590.20955-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jul 2004, Fawad Lateef wrote:

> Hello
> 
> I am creating a RAMDISK of 7GB (from 1GB to 8GB). I
> reserved the RAM by changing the code in
> arch/i386/mm/init.c .......... 
> 
> But I am not able to access the RAM from 1GB to 8GB in
> a kernel module ........ after crossing the 4GB RAM,
> the system goes into standby state. But if I insert
> the same module 2 times means one for 1GB to 4GB and
> other for 4GB to 8GB. and mount them seprately both
> works fine ............ 

on a non-64bit intel architecture you can only grab 4GB of ram per 
process because that's how big the page table is. There are 16 4GB page 
tables for the 64GB ram that intel machines are capable of addressing.
 
> Can any one tell me the reason behind this ??? I think
> that in a single module we can't access more than 4GB
> RAM ...... If this is the reason then what to do ??? I
> need 7GB RAMDISK as a single drive ....
> 
> Thanks and Regards,
> 
> Fawad Lateef
> 
> 
> 		
> __________________________________
> Do you Yahoo!?
> Yahoo! Mail - You care about security. So do we.
> http://promotions.yahoo.com/new_mail
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu    
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2


