Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbVHLFDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbVHLFDM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 01:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbVHLFDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 01:03:12 -0400
Received: from [64.71.148.162] ([64.71.148.162]:208 "EHLO
	mail.linuxmachines.com") by vger.kernel.org with ESMTP
	id S1750773AbVHLFDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 01:03:11 -0400
Message-ID: <42FC2DE4.4010608@linuxmachines.com>
Date: Thu, 11 Aug 2005 22:04:36 -0700
From: Jeff Carr <jcarr@linuxmachines.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Need help in understanding x86 syscall
References: <4Ae73-6Mm-5@gated-at.bofh.it> <E1E3DJm-0000jy-0B@be1.lrz>	 <Pine.LNX.4.61.0508110954360.14541@chaos.analogic.com>	 <1123770661.17269.59.camel@localhost.localdomain>	 <2cd57c90050811081374d7c4ef@mail.gmail.com>	 <Pine.LNX.4.61.0508111124530.14789@chaos.analogic.com>	 <1123775508.17269.64.camel@localhost.localdomain>	 <1123777184.17269.67.camel@localhost.localdomain>	 <2cd57c90050811093112a57982@mail.gmail.com>	 <2cd57c9005081109597b18cc54@mail.gmail.com> <1123780681.17269.71.camel@localhost.localdomain>
In-Reply-To: <1123780681.17269.71.camel@localhost.localdomain>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2005 10:18 AM, Steven Rostedt wrote:

> It's vanilla 2.6.12-rc3 + Ingo's RT V0.7.46-02-rs-0.4 + some of my own
> customizations.  But I never touched the sysentry stuff and with a few
> printks I see it is being initialized.
> 
>>Also glibc support.
> 
> I'm using Debian unstable with a recent (last week) update.
> 
> -- Steve

But are you using libc6-i686? That enables NPTL. Perhaps the behavior
difference is there? I'm surprised int 80 doesn't really cause an
interrupt; it doesn't jump to the appropriate place in the x86 vector
table? Interesting.

Jeff


root@jcarr:~# dpkg -s libc6-i686
...
 This set of libraries is optimized for i686 machines, and will only be
 used if you are running a 2.6 kernel on an i686 class CPU (check the
 output of `uname -m').  This includes Pentium Pro, Pentium II/III/IV,
 Celeron CPU's and similar class CPU's (including clones such as AMD
 Athlon/Opteron, VIA C3 Nehemiah, but not VIA C3 Ezla).
 .
 This package includes support for NPTL.
 .
