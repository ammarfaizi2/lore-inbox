Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751542AbWE0Om2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbWE0Om2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 10:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbWE0Om2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 10:42:28 -0400
Received: from smtpout.mac.com ([17.250.248.184]:55763 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751533AbWE0Om1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 10:42:27 -0400
In-Reply-To: <20060526093530.A20928@openss7.org>
References: <e55715+usls@eGroups.com> <1148596163.31038.30.camel@mindpipe> <1148653797.3579.18.camel@laptopd505.fenrus.org> <20060526093530.A20928@openss7.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0E42EDC8-3CC3-4161-8032-9599CA0ED63A@mac.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Lee Revell <rlrevell@joe-job.com>,
       devmazumdar <dev@opensound.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: How to check if kernel sources are installed on a system?
Date: Sat, 27 May 2006 10:41:28 -0400
To: bidulock@openss7.org
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 26, 2006, at 11:35:30, Brian F. G. Bidulock wrote:
> On Fri, 26 May 2006, Arjan van de Ven wrote:
>> /boot/config-`uname -r`
>
> Debian (Woody), OTOH strips extra names of their kernels, so 3 or 4  
> different releases of the same upstream kernel version all install  
> with the same name and report `uname -r` the same.  If multiple of  
> these kernels and a vanilla kernel are installed, their config  
> files will be difficult to distinguish.  dpkg can be used (similar  
> to above for rpm) to test the condition.

Huh?  My Debian system here has:

   /boot/config-2.6.15-1-powerpc-smp

This corresponds to the config of the currently installed version and  
revision ("2.6.15-8") of the "linux-image-2.6.15-1-powerpc-smp"  
package.  Since you can only have one version of a given package  
installed at once, this poses no problems.

If I upgrade to a new one (say "2.6.15-9") that changes the config  
slightly or adds a new distro patch, then that config and kernel  
image would replace the currently installed one.  If I use make-kpkg  
to build and install a custom kernel tuned for "host":

   make-kpkg [args] --append-to-version -zeus1-1-powerpc-smp -- 
revision 1 kernel_image

Now I get a package "linux-image-2.6.15-zeus1-1-powerpc-smp" version  
"2.6.15-1", with:

   /boot/config-2.6.15-zeus1-1-powerpc-smp

I see no potential for confusion or mismatch here.

Cheers,
Kyle Moffett

