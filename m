Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbUKDNBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbUKDNBf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 08:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbUKDNBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 08:01:34 -0500
Received: from webapps.arcom.com ([194.200.159.168]:16902 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S262194AbUKDNBL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 08:01:11 -0500
Subject: Re: is killing zombies possible w/o a reboot?
From: Ian Campbell <icampbell@arcom.com>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org, Jan Knutar <jk-lkml@sci.fi>,
       Tom Felker <tfelker2@uiuc.edu>
In-Reply-To: <200411040739.01699.gene.heskett@verizon.net>
References: <200411030751.39578.gene.heskett@verizon.net>
	 <200411040657.10322.gene.heskett@verizon.net>
	 <200411041412.42493.jk-lkml@sci.fi>
	 <200411040739.01699.gene.heskett@verizon.net>
Content-Type: text/plain
Organization: Arcom Control Systems
Date: Thu, 04 Nov 2004 13:01:06 +0000
Message-Id: <1099573266.2856.40.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Nov 2004 13:01:55.0375 (UTC) FILETIME=[75EB1BF0:01C4C26E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-04 at 07:39 -0500, Gene Heskett wrote:
> On Thursday 04 November 2004 07:12, Jan Knutar wrote:
> >On Thursday 04 November 2004 13:57, Gene Heskett wrote:
> >> I'e had that turned on since forever Jan, but usually, when its
> >> hung someplace, its well and truely hung, and hardware reset
> >> button time.
> >
> >Are you saying that these zombies (or tasks stuck in state D) also
> > make sysrq-T hang, and not list all tasks?
> 
> I thought I'd test it right now while the system is runnng normally, 
> but I got only a beep from the console, so I went to 
> Documentation/sysrq.txt to make sure I was doing it right, and it is 
> _not_ working right now.  But it is compiled in according to a make 
> xconfig, or a grep of the .config.

It can also be enabled/disabled at runtime, Documentation/sysrq.txt says
that the default now is on (but that it used to default to off). Perhaps
it is getting turned off somewhere in your boot scripts etc. 

You can check with

$ cat /proc/sys/kernel/sysrq
1

> The keyboard is a cheap ($24) M$ with a few extra buttons that don't 
> do anything along the top.  And getting a bit creaky in its old age, 
> a lot like me, but I'm about 68 years older than the keyboard :)

Documentation/sysrq.txt also says:

*  How do I use the magic SysRq key?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
On x86   - You press the key combo 'ALT-SysRq-<command key>'. Note - Some
           keyboards may not have a key labeled 'SysRq'. The 'SysRq' key is
           also known as the 'Print Screen' key. Also some keyboards cannot
           handle so many keys being pressed at the same time, so you might
           have better luck with "press Alt", "press SysRq", "release Alt",
           "press <command key>", release everything.

Perhaps your keyboard is one of those that can't cope with all those
keys?

Ian.

-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200

