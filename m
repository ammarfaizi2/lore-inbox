Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266570AbUHOJun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266570AbUHOJun (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 05:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266569AbUHOJun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 05:50:43 -0400
Received: from out010pub.verizon.net ([206.46.170.133]:53217 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S266570AbUHOJu3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 05:50:29 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Sun, 15 Aug 2004 05:50:26 -0400
User-Agent: KMail/1.6.82
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408150009.45034.gene.heskett@verizon.net> <20040815084856.GD12308@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040815084856.GD12308@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408150550.26476.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [151.205.53.77] at Sun, 15 Aug 2004 04:50:27 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 August 2004 04:48, viro@parcelfarce.linux.theplanet.co.uk 
wrote:
>On Sun, Aug 15, 2004 at 12:09:44AM -0400, Gene Heskett wrote:
>> The only thing I've noted in the slabinfo reports is the
>> ext3_cache was well into 6 digits in kilobytes.  Now its only
>> 15,000 of its normal units (whatever they are) after the reboot.
>
And I just noticed this go by during the build:
----------
fs/buffer.c: In function `remove_inode_buffers':
fs/buffer.c:1079: warning: ISO C90 forbids mixed declarations and code
----------
Do we need to address this?  Its a line immediately below the BUG-ON 
patch that Marcelo had me put in most recently, and has probably been 
there all along.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
