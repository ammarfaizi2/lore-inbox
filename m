Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313004AbSC0NKf>; Wed, 27 Mar 2002 08:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313006AbSC0NKP>; Wed, 27 Mar 2002 08:10:15 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:12051 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S313004AbSC0NKJ>; Wed, 27 Mar 2002 08:10:09 -0500
Date: Wed, 27 Mar 2002 14:10:01 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre4-ac1 vmware and emu10k1 problems
Message-ID: <20020327131001.GA25086@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020326160638.A2103@trianna.upcommand.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2002, Malcolm Mallardi wrote:

> The vmware modules will not compile properly under 2.4.19-pre4-ac1, or
> under 2.4.19-pre2-ac2, but compile fine on their mainline kernel
> counterparts.  Here is the errors that I get from vmware-config.pl:
> 
> Building the vmmon module.
> 
> make: Entering directory `/tmp/vmware-config1/vmmon-only'
> make[1]: Entering directory `/tmp/vmware-config1/vmmon-only'
> make[2]: Entering directory
> `/tmp/vmware-config1/vmmon-only/driver-2.4.19-pre4-ac1'
> In file included from .././linux/driver.c:38:
> /lib/modules/2.4.19-pre4-ac1/build/include/linux/malloc.h:4: #error
> linux/malloc.h is deprecated, use linux/slab.h instead.
> make[2]: *** [driver.d] Error 1
> make[2]: Leaving directory
> `/tmp/vmware-config1/vmmon-only/driver-2.4.19-pre4-ac1'
> make[1]: *** [deps] Error 2
> make[1]: Leaving directory `/tmp/vmware-config1/vmmon-only'
> make: *** [auto-build] Error 2
> make: Leaving directory `/tmp/vmware-config1/vmmon-only'
> Unable to build the vmmon module.

Replace all #include <linux/malloc.h> by #include <linux/slab.h> as the
#error says -- I tried that, and it works for me with 2.4.19-pre3-ac4.
