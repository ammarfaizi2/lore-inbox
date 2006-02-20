Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161173AbWBTWhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161173AbWBTWhI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 17:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbWBTWgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 17:36:21 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:38950 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932689AbWBTWgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 17:36:09 -0500
Message-ID: <43FA4412.6010303@cfl.rr.com>
Date: Mon, 20 Feb 2006 17:34:58 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: vamsi krishna <vamsi.krishnak@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Process states inside the linux kernel. [Especially about the
 STATE D]
References: <3faf05680602201419v3a6172a1j80e4210dde4c54cf@mail.gmail.com>
In-Reply-To: <3faf05680602201419v3a6172a1j80e4210dde4c54cf@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Feb 2006 22:37:11.0178 (UTC) FILETIME=[30546EA0:01C6366E]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14280.000
X-TM-AS-Result: No--6.350000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vamsi krishna wrote:
> Hello All,
> 
>  I have been debugging a program which takes huge memory around 12Gb
> (On a 64-bit machine). I was trying to monitor the VmSize and RSS
> sizes using top command for this process. I frequently see that the
> process STATUS changes its state from 'D' to 'R' most of the time its
> in the state 'D'.
> 
>  I looked at the manual it says D  uninterruptable sleep state (I have
> googled on this but could'nt find much information about this stage).
> As far as my text book knowledge, the process is either 1). Running 
> 'R'  2.) Ready 'Re' 3.) Wait (for I/O) W .
> 
>  So what is 'uninterruptable sleep state' D ? when does the process is
> put in this state?
> 
>  Can someone releate me the states cycle of the process in linux kernel.
> 
>  Really appreciate your time and effort.
> 

It is called D because originally it stood for Disk, and was used for 
when the process was blocked waiting to be swapped back in from the 
disk. These days it is still mostly used for when the process is blocked 
either handling a page fault or in a system call that does blocking disk 
IO.


