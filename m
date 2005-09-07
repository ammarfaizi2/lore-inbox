Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbVIGLkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbVIGLkq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 07:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbVIGLkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 07:40:45 -0400
Received: from mail.dvmed.net ([216.237.124.58]:13293 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932119AbVIGLkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 07:40:45 -0400
Message-ID: <431ED1B9.7040407@pobox.com>
Date: Wed, 07 Sep 2005 07:40:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E0rius_Mont=F3n?= <Marius.Monton@uab.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: 'virtual HW' into kernel (SystemC)
References: <431EC16B.2040604@uab.es>
In-Reply-To: <431EC16B.2040604@uab.es>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Màrius Montón wrote:
> Hello all,
> 
> I'm a PhD student and I'm focusing on HW/SW co-design.
> 
> First of all, a brief introduction to problem:
> Nowadays, we can use C++ libraries, called SystemC, to describe HW
> behavior, and synthesize with commercial tools.
> 
> A SystemC description can be simulated using its own simulator kernel,
> and we can indeed wrap a module with its simulator kernel into a C++
> class, so we can use it as a 'normal' C++ code...
> 
> Our main problem now appears: if we develop a PCI device using SystemC
> we cannot start to develop and test the device driver until we have a
> real prototype,
> and hence, we cannot test our HW with SW.
> 
> Our proposal is to develop a set of tools (kernel module, daemon, ...) in
> order to use a SystemC model of HW as a virtual device.
> 
> With this set of code, when we have SystemC description finished (and
> only SystemC code, nor prototype, nor real HW), we will able to start
> developing driver, and testing our "virtual HW" with complete SW suite.
> 
> At this point, we plan to develop a pci device driver to act as a bridge
> between kernel PCI subsystem and SystemC simulator (in user space).

No need for a set of tools.  As long as your SystemC simulator simulates 
an entire platform -- CPU, DRAM, etc. -- then you can boot Linux on the 
simulated platform.

If you can boot Linux on the simulated platform, then you can easily 
develop a Linux driver long before real HW is available.

	Jeff


