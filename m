Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266403AbUAVSmx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 13:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266405AbUAVSmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 13:42:53 -0500
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:57205 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266403AbUAVSmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 13:42:51 -0500
Message-ID: <40108A2B.3080605@yahoo.com>
Date: Thu, 22 Jan 2004 18:42:51 -0800
From: Brandon Ehle <azverkan@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Aaron Mulder <ammulder@alumni.princeton.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Strange pauses in 2.6.2-rc1 / AMD64
References: <Pine.LNX.4.44.0401212107010.24057-100000@www.princetongames.org>
In-Reply-To: <Pine.LNX.4.44.0401212107010.24057-100000@www.princetongames.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Mulder wrote:

>	I tried out 2.6.2-rc1 today, and saw some very strange behavior
>with Java.  I run a 30s build process (Java/Ant), and it would basically
>stop in the middle.  If I run a "top" next to it (this was all in X),
>during the pauses, the CPUs would go down to nearly 100% idle, and all the
>Java processes disappeared from the top of the list.  If I moved my mouse
>at all, the Java build would wake up for a bit, then stop again 10 or 15
>seconds later.  The build would easily take several minutes if I didn't
>move my mouse much (or hang indefinitely if I didn't move my mouse at
>all).  If I consistently jiggled my mouse through the entire build, the
>performance was approximately what I would expect (35-40s).
>
>  
>

I was running into the same thing last night.  In order to get the 
kernel to boot on my machine, I had also been passing idle=poll on the 
commandline.  According to an earlier message, I turned off "Legacy USB 
Support" in the BIOS and the kernel booted fine without passing the 
idle=poll parameter and the pauses no longer happen for me.

This is on a Athlon 64 3000+ on a K8V Deluxe, 1GB RAM, Gentoo for x86_64.

>	I tried the same thing under my normal kernel (SuSE
>2.4.21-178-smp) and the build ran continuously with no pauses (35s).
>
>	The pauses on 2.6.2-rc1 occured with both 32-bit (Sun) and 64-bit
>(Blackdown) Java implementations.
>
>	I can't explain it, but if there's any pertinent info I can
>provide, I'll be happy to.
>
>Thanks,
>	Aaron
>
>2x Opteron 248, Tyan Thunder K8W, 4GB RAM, SuSE 9.0 for AMD64
>  
>

