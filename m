Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261781AbTCQQxA>; Mon, 17 Mar 2003 11:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261783AbTCQQxA>; Mon, 17 Mar 2003 11:53:00 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:53751 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261781AbTCQQw6>; Mon, 17 Mar 2003 11:52:58 -0500
Date: Mon, 17 Mar 2003 12:03:44 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: BOEBLINGEN LINUX390 <LINUX390@de.ibm.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [s390x] Patch for execve with a mode switch
Message-ID: <20030317120344.A10911@devserv.devel.redhat.com>
References: <OF4DCC5C2B.C044EACC-ONC1256CEC.004CE000@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF4DCC5C2B.C044EACC-ONC1256CEC.004CE000@de.ibm.com>; from LINUX390@de.ibm.com on Mon, Mar 17, 2003 at 04:20:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: "BOEBLINGEN LINUX390" <LINUX390@de.ibm.com>
> Date: Mon, 17 Mar 2003 16:20:37 +0100

> mm->free_area_cache can't cause any problems on s390x because it isn't
> used. [...]
> This patch is severly broken. It wouldn't even compile.

I am sorry, yes, please don't apply to 2.5. It is only needed
on later 2.4, which use the mm->free_area_cache (our old 2.4.9
works ok, but 2.4.20 doesn't).

I still think you are making a mistake defininig your own
arch_get_unmapped_area(), because: 1. sparc64 does it correctly
with the common code, so it can be done; 2. architecture
specific duplicates of common code may bitrot. But have it
your way, I won't resubmit, for the sake of staying aligned
with upstream.

-- Pete
