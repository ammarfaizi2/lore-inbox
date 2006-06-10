Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbWFJCiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbWFJCiL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 22:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbWFJCiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 22:38:11 -0400
Received: from sccrmhc14.comcast.net ([204.127.200.84]:44426 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1030194AbWFJCiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 22:38:10 -0400
Date: Fri, 9 Jun 2006 21:37:19 -0500
From: Hui Zhou <hzhou@hzsolution.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Frustrating Random Reboots, seeking suggestions
Message-ID: <20060610023719.GA10857@smtp.comcast.net>
References: <20060609145757.GB1640@smtp.comcast.net> <Pine.LNX.4.64.0606091058320.4969@turbotaz.ourhouse>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606091058320.4969@turbotaz.ourhouse>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 11:01:22AM -0500, Chase Venters wrote:
>On Fri, 9 Jun 2006, Hui Zhou wrote:
>>I am running a linux machine with a self programmed pvr running on it. All 
>>is well until I reinstalled the linux system a few weeks ago. Now I am 
>>suffering from random reboots. The reboots does not leave any debug 
>>messages or clues. After some isolation, I finally narrowed it down to a 
>>blankscene marking program -- bkmark. Running bkmark against any recording 
>>randomly reboots the computer. By random, I mean  it may complete 
>>sucessfully once, but repeating it for a few times, the reboots will 
>>happen.  On average, it reboots every 2 - 3 runs.
>Try to knock out any hardware problems first (run memtest86, check for 
>high heat / crappy power).
>
>If you're still having trouble, purchase a serial cable. Plug it into 
>another computer with a terminal program. Enable serial console support in 
>your kernel (and on your kernel command line). When the kernel boots, use 
>SysRq on the serial console to turn the console messaging level up to 
>maximum. If you're lucky, you'll catch some sort of diagnostics message on 
>the serial console before this happens.
>

Thanks. memtest86 passes 6 times without errors. Serial console didn't 
show up anything (it just reboots). 

Anyway, I finally suspect the debian libmpeg binary is at fault. I 
manually build it from src and statically linked to the `bkmark' 
program. It seems cured the random reboots problem. It runs 
successfully for 4 times. However, the fifth time it ended up in a `D' 
state. The only system call it uses is libc file IO and some signal 
passing. Any comment on the cause?

-- 
Hui Zhou
