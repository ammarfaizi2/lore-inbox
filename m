Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277983AbRJRTFB>; Thu, 18 Oct 2001 15:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277986AbRJRTEv>; Thu, 18 Oct 2001 15:04:51 -0400
Received: from quark.didntduck.org ([216.43.55.190]:19469 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S277983AbRJRTEn>; Thu, 18 Oct 2001 15:04:43 -0400
Message-ID: <3BCF27D5.CE4C53DE@didntduck.org>
Date: Thu, 18 Oct 2001 15:04:53 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Gregory Ade <gkade@bigbrother.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.2.x process limits (NR_TASKS)?
In-Reply-To: <Pine.LNX.4.33.0110181139380.30308-100000@tigger.unnerving.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Ade wrote:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> We're running into what appears to be a 256-process-per-user limit on one
> of our webservers, due to the number of processes running as a specific
> user for our application.  I'd like to increase the process limit, and
> *THINK* that to do so i need to increase NR_TASKS in
> /usr/src/linux/include/linux/tasks.h.
> 
> Is this correct?  What other things do I need to watch out for when making
> this modification?
> 
> Also, where can this limit be changed in 2.4.x?
> 
> Thanks ahead of time.
> 

2.2.x has a hard limit of 512 tasks on the x86 because it uses hardware
task switching.  2.4.x allows an unlimited number of tasks, and is
configurable via /proc/sys/kernel/threads-max and ulimit.

--

				Brian Gerst
