Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbVHWOO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbVHWOO6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 10:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVHWOO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 10:14:58 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:60635 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932106AbVHWOO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 10:14:58 -0400
Date: Tue, 23 Aug 2005 10:14:56 -0400
To: Terry <tmacmill@rivernet.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Incorrect RAM Detected at kernel init
Message-ID: <20050823141456.GB28578@csclub.uwaterloo.ca>
References: <001001c5a6c9$7a0e1df0$6301a8c0@finian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001001c5a6c9$7a0e1df0$6301a8c0@finian.net>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2005 at 11:27:51PM -0400, Terry wrote:
> Not sure if I have provided enough info, or to much info, but here it goes:
> 
> [1.] One line summary of the problem:
> Not Detecting all the memory installed in the system.
> 
> [2.] Full description of the problem/report:
> I have Linux Kernel 2.4.31 running on a Compaq 5000R server with 2 PPro 200
> processors, 768M RAM, RealTeck 8139 Network Card, and Compaq Smart 2 Raid
> controller with 5 9.1G drives in Raid 5 configuration.
> The kernel appears to compile perfectly, installs fine, but after reboot it
> is only reporting 16M of RAM. I have tried with and without the mem=768M
> boot up option in the lilo.conf script. All other modules and boot up
> includes appear to run perfectly fine. I had a 2.4.18 kernel running on this
> box just fine, detected all 768M of RAM and ran perfectly. The 2.4.31 Kernel
> runs almost perfectly, the only hold back is the false detection of memory.

Compaq machines of that era are known to have non standard bios methods
for identifying ram.  Do a google search for how to pass memory maps to
2.6 kernels on a compaq.

ie something like:

mem=exactmap mem=640K@0 mem=1023M@1M

Add that to the kernel command line when booting and see what happens.

Len Sorensen
