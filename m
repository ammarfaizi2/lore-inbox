Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWBQBp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWBQBp6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 20:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWBQBp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 20:45:58 -0500
Received: from node-4024215a.mdw.onnet.us.uu.net ([64.36.33.90]:28660 "EHLO
	found.lostlogicx.com") by vger.kernel.org with ESMTP
	id S1750725AbWBQBp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 20:45:57 -0500
Date: Thu, 16 Feb 2006 19:45:52 -0600
From: Brandon Low <lostlogic@lostlogicx.com>
To: Tony Mantler <nicoya@ubb.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_MK6 = lsof hangs unkillable
Message-ID: <20060217014552.GA6861@lostlogicx.com>
References: <6951EFDF-9499-40D5-AD09-2AE217A0A579@ubb.ca> <59A5E944-6499-47D4-B875-C0DE75E27701@ubb.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59A5E944-6499-47D4-B875-C0DE75E27701@ubb.ca>
X-Operating-System: Linux found 2.6.16-rc3
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had this happen earlier today, but at the moment I can't reproduce it.

The offending kernel was 2.6.16-rc3 with CONFIG_MK7=y

I'll post an oops and config if it happens again.

Brandon

On Mon, 01/16/06 at 16:58:55 -0600, Tony Mantler wrote:
> 
> On 15-Jan-06, at 10:43 PM, Tony Mantler wrote:
> 
> >I'm having trouble running lsof on 2.6.15.1 when the kernel is  
> >compiled with CONFIG_MK6. When run as root, lsof will segfault, and  
> >when run as a user lsof will hang unkillable.
> >
> >The same kernel, same machine, but compiled with CONFIG_MK7 runs  
> >just lsof just fine.
> 
> To follow up on this, it appears that things are getting stuck while  
> reading /proc/*/maps, specifically it hangs in fs/proc/task_mmu.c in  
> m_start() at down_read(&mm->mmap_sem). The same thing happens when  
> trying to readlink /proc/*/exe.
> 
> I'm really not sure why this lock is getting stuck. Can anyone  
> reproduce this?
> 
> --
> Tony 'Nicoya' Mantler -- Master of Code-fu -- nicoya@ubb.ca
> --  http://nicoya.feline.pp.se/  --  http://www.ubb.ca/  --
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
