Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263726AbUACSjf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 13:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263734AbUACSjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 13:39:35 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:29714 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263726AbUACSje
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 13:39:34 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Should struct inode be made available to userspace?
Date: Sat, 03 Jan 2004 13:39:41 -0500
Organization: TMR Associates, Inc
Message-ID: <bt71ip$cer$1@gatekeeper.tmr.com>
References: <200312292040.00409.mmazur@kernel.pl> <20031229195742.GL4176@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1073154457 12763 192.168.12.10 (3 Jan 2004 18:27:37 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <20031229195742.GL4176@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:

> struct inode and structures containing it should not be used outside of kernel.
> Moreover, foo_fs.h should be seriously trimmed down and everything _not_
> useful outside of kernel should be taken into fs/foo/*; other kernel code
> also doesn't give a fsck for that stuff, so it should be private to filesystem
> instead of polluting include/linux/*.

Moving the definitions is fine, but some user programs, like backup 
programs, do benefit from direct interpretation of the inode. Clearly 
that's not a normal user program, but this information is not only 
useful inside the kernel.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
