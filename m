Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbUFUBQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbUFUBQb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 21:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265517AbUFUBQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 21:16:31 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:13706 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262213AbUFUBQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 21:16:28 -0400
Message-ID: <40D636EA.7090704@opensound.com>
Date: Sun, 20 Jun 2004 18:16:26 -0700
From: 4Front Technologies <dev@opensound.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness
References: <40D232AD.4020708@opensound.com> <3217460000.1087518092@flay><40D23701.1030302@opensound.com> <1087573691.19400.116.camel@winden.suse.de><40D32C1D.80309@opensound.com> <20040618190257.GN14915@schnapps.adilger.int><40D34CB2.10900@opensound.com><200406181940.i5IJeBDh032311@turing-police.cc.vt.edu><Pine.LNX.4.60.0406181326210.3688@dlang.diginsite.com> <Pine.LNX.4.58.0406191148570.30038@zeus.compusonic.fi> <Pine.LNX.4.60.0406201506360.6470@dlang.diginsite.com>
In-Reply-To: <Pine.LNX.4.60.0406201506360.6470@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:

> 
> or they need to go through the process of getting their driver included 
> in the main kernel and these headaches go away.
> 

How would you handle the following modules that aren't drivers - like filesystems:

- ClusterFS
- Intermezzo
- Sistina

There are loads of other very specific drivers for embedded systems that
have no real applicability in the mainstream kernel like DSP boards, specialized
encryption board drivers, military grade video capture/display devices. There 
are other things like PCI-Express "development" drivers that aren't stable and 
developers need a way to build them outside the kernel.

Infact it's good programming practices to ensure that drivers/modules build 
independant of the kernel. There are too many companies like Win4Lin/VMWare that 
only offer support for Redhat or SuSE kernels with debian, gentoo and other's 
left out of the action.

You and others can keep suggesting that put the world+kitchen sink into the 
kernel and have the problems go away but it's not realistic. Many drivers are 
still maintained outside the kernel and you aren't providing a solution.

Right now the kernel configuration has become complex enough that someone ought
to write a cool program that probes the customer's hardware + OS system and be 
able to build an optimized kernel + drivers + modules with minimal user 
intervention. Make it a commercial app and mint money because there's such a 
dire need. Most Linux users aren't able to do this and this basically means you 
have little ability to test all kinds of kernel configuration combinations.

> 
> it's less likly that the people running the 6.x distros are going to be 
> installing the latest and greatest hardware that needs the new 
> out-of-kernel driver, but if you think you need to create modules that 
> will work with every kernel since 2.0 have fun.
> 

How about just dealing with Linux 2.6.0 to Linux 2.6.7?. It's become bad enough 
that you need stuff like ifdef REGPARM, ifdef NOREGPARM, ifdef GCC 3.2, ifdef 
GCC 3.4, ifdef SMP, and other ifdefs if you're doing a bunch of /proc types of 
sysadmin stuff

 >
> David Lang
> 


best regards
Dev Mazumdar
-----------------------------------------------------------
4Front Technologies
4035 Lafayette Place, Unit F, Culver City, CA 90232, USA.
Tel: (310) 202 8530		URL: www.opensound.com
Fax: (310) 202 0496 		Email: info@opensound.com
-----------------------------------------------------------
