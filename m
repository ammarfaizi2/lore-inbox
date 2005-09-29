Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbVI2TTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbVI2TTR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVI2TTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:19:17 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:16645 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932274AbVI2TTQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:19:16 -0400
Message-ID: <433C3E3B.80708@tmr.com>
Date: Thu, 29 Sep 2005 15:19:23 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Karel Kulhavy <clock@twibright.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CD writer is burning with open tray
References: <20050929141924.GA6512@kestrel>
In-Reply-To: <20050929141924.GA6512@kestrel>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karel Kulhavy wrote:
> Hello
> 
> I ran cdrecord -tao dev=ATAPI:0,0,0 speed=8 /home/clock/cdrom.iso on
> 2.6.12-gentoo-r10 and it burned a good CD.
> 
> Then I repeated the same command (press up and enter) and it
> 1) Burned two bad CD's with a strip near the central area
> 2) Third CD burned bad
> 3) When rerun cdrecord says
> cdrecord: Drive does not support TAO recording.
> cdrecord: Illegal write mode for this drive.
> 
> I should note here that I didn't hotplug the hardware - I can't
> understand how supported modes can change on the fly...

My guess is that your writer is bad, or at minimum needs a firmware 
upgrade. However, is this the real cdwrite program from Joerg Schilling, 
or is it one of the hacked versions which come with some distributions 
with mods to burn DVDs?

I would also specify the real device name, like dev=/dev/hdX, and drop 
the speed= option and let it choose one it likes. You may also want to 
use the -atip option to see what cdrecord thinks about your drive.
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
