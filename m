Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUADFnK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 00:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265063AbUADFnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 00:43:10 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:54932
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S264917AbUADFnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 00:43:07 -0500
Message-ID: <3FF7A7F2.9060009@tmr.com>
Date: Sun, 04 Jan 2004 00:43:14 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: linux-kernel@vger.kernel.org
Subject: Re: Should struct inode be made available to userspace?
References: <200312292040.00409.mmazur@kernel.pl> <20031229195742.GL4176@parcelfarce.linux.theplanet.co.uk> <bt71ip$cer$1@gatekeeper.tmr.com> <20040103185712.GV4176@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040103185712.GV4176@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Sat, Jan 03, 2004 at 01:39:41PM -0500, Bill Davidsen wrote:
> 
>>viro@parcelfarce.linux.theplanet.co.uk wrote:
>>
>>
>>>struct inode and structures containing it should not be used outside of 
>>>kernel.
>>>Moreover, foo_fs.h should be seriously trimmed down and everything _not_
>>>useful outside of kernel should be taken into fs/foo/*; other kernel code
>>>also doesn't give a fsck for that stuff, so it should be private to 
>>>filesystem
>>>instead of polluting include/linux/*.
>>
>>Moving the definitions is fine, but some user programs, like backup 
>>programs, do benefit from direct interpretation of the inode. Clearly 
>>that's not a normal user program, but this information is not only 
>>useful inside the kernel.
> 
> 
> No, they do not.  They care about on-disk structures, not the in-core
> ones fs driver happens to build.

Pardon, I thought that was exactly what was being suggested to hide.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
