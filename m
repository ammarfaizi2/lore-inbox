Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbUCKWBa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 17:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbUCKWB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 17:01:29 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:2991 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S261753AbUCKWBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 17:01:25 -0500
Date: Thu, 11 Mar 2004 13:59:55 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Joe Thornber <thornber@redhat.com>
Cc: Andi Kleen <ak@muc.de>, Mickael Marchand <marchand@kde.org>,
       linux-kernel@vger.kernel.org, dm@uk.sistina.com
Subject: Re: 2.6.4-mm1
Message-ID: <20040311215955.GC18020@ca-server1.us.oracle.com>
Mail-Followup-To: Joe Thornber <thornber@redhat.com>,
	Andi Kleen <ak@muc.de>, Mickael Marchand <marchand@kde.org>,
	linux-kernel@vger.kernel.org, dm@uk.sistina.com
References: <1ysXv-wm-11@gated-at.bofh.it> <1yxuq-6y6-13@gated-at.bofh.it> <m3hdwnawfi.fsf@averell.firstfloor.org> <200403111445.35075.marchand@kde.org> <20040311144829.GA22284@colin2.muc.de> <20040311214354.GM18345@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040311214354.GM18345@reti>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2004 at 09:43:54PM +0000, Joe Thornber wrote:
> struct dm_ioctl {			0
>         uint32_t version[3];		
>         uint32_t data_size;  		4
> 
>         uint32_t data_start;
> 
>         uint32_t target_count;
>         int32_t open_count;
>         uint32_t flags;		8
>         uint32_t event_nr;
>         uint32_t padding;		10 ***

	Here's probably the problem.  Many 64bit arches align 64bit
numbers on a 64bit boundary.  So it is adding 2 more words of padding to
start the u64 at offset 12.

>         uint64_t dev;			
> 
>         char name[DM_NAME_LEN];
>         char uuid[DM_UUID_LEN];
> };

Joel

-- 

Life's Little Instruction Book #313

	"Never underestimate the power of love."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
