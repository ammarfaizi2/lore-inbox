Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265094AbUADFqL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 00:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265137AbUADFqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 00:46:11 -0500
Received: from mail5.speakeasy.net ([216.254.0.205]:21439 "EHLO
	mail5.speakeasy.net") by vger.kernel.org with ESMTP id S265094AbUADFqJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 00:46:09 -0500
Message-Id: <6.0.1.1.0.20040103214203.038dceb0@no.incoming.mail>
X-Mailer: QUALCOMM Windows Eudora Version 6.0.1.1
Date: Sat, 03 Jan 2004 21:45:47 -0800
To: viro@parcelfarce.linux.theplanet.co.uk
From: Jeff Woods <kazrak+kernel@cesmail.net>
Subject: Re: Should struct inode be made available to userspace?
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040103185712.GV4176@parcelfarce.linux.theplanet.co.uk>
References: <200312292040.00409.mmazur@kernel.pl>
 <20031229195742.GL4176@parcelfarce.linux.theplanet.co.uk>
 <bt71ip$cer$1@gatekeeper.tmr.com>
 <20040103185712.GV4176@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 1/3/2004 06:57 PM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
>On Sat, Jan 03, 2004 at 01:39:41PM -0500, Bill Davidsen wrote:
>>Moving the definitions is fine, but some user programs, like backup 
>>programs, do benefit from direct interpretation of the inode. Clearly 
>>that's not a normal user program, but this information is not only useful 
>>inside the kernel.
>
>No, they do not.  They care about on-disk structures, not the in-core ones 
>fs driver happens to build.

They may if trying to do an online backup of open files, especially if 
attempting to maintain transactional integrity (i.e. make the backup 
logically atomic).

--
Jeff Woods <kazrak+kernel@cesmail.net> 


