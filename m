Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275935AbTHONPJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 09:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275938AbTHONPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 09:15:09 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:44276 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S275935AbTHONPF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 09:15:05 -0400
Date: Fri, 15 Aug 2003 17:15:21 +0200
From: Clock <clock@twibright.com>
To: kenton.groombridge@us.army.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: nforce2 lockups
Message-ID: <20030815171521.A683@beton.cybernet.src>
References: <df962fdf9006.df9006df962f@us.army.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <df962fdf9006.df9006df962f@us.army.mil>; from kenton.groombridge@us.army.mil on Fri, Aug 15, 2003 at 09:12:17PM +0900
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 09:12:17PM +0900, kenton.groombridge@us.army.mil wrote:
> Hi,
> 
> I found your post looking for a solution to my lockups.  I bet if you do a dmesg, you will find that your nforce2 chipset revision is 162.

Yeah! Look:

NFORCE2: chipset revision 162

:)

> 
> I have found tons of people with this exact problem.  My Abit board will run
> Windows 2000 flawlessly, but lockup in a minute under Linux.

> 
> Currently I have a reward of $20 posted on two lists looking for a solution.  Currently looking to up the ante to $40.
> 
> http://www.nvnews.net/vbulletin/showthread.php?s=&threadid=16264
> 
> http://www.nforcershq.com/forum/viewtopic.php?t=27003
> 
> I don't think the problem is the the IDE.  I have used a promise controller
> and disabled the onboard IDE and still had lockups.  If you find a solution,
> please let me know.  If I find one, I will do likewise.

It looks like the problem is in APIC. When you disable it, it vanishes.
And, when you enable NMI watchdog, which is handled by APIC,
it doesn't work - it couts up to 15 in /proc/interrupts and then stops!

Cl<
