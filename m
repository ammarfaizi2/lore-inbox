Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWGLRgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWGLRgy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 13:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWGLRgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 13:36:54 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:51073 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932152AbWGLRgx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 13:36:53 -0400
Date: Wed, 12 Jul 2006 08:23:12 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Rene Herman <rene.herman@keyaccess.nl>
cc: Olaf Hering <olaf@aepfle.de>, "H. Peter Anvin" <hpa@zytor.com>,
       Roman Zippel <zippel@linux-m68k.org>, torvalds@osdl.org,
       klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [klibc] klibc and what's the next step?
In-Reply-To: <44B3B680.4040101@keyaccess.nl>
Message-ID: <Pine.LNX.4.63.0607120805060.14192@qynat.qvtvafvgr.pbz>
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.060
 6271316220.17704@scrub.home> <20060711044834.GA11694@suse.de>
 <44B3B680.4040101@keyaccess.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2006, Rene Herman wrote:

> Olaf Hering wrote:
>
>> I do not want to see kinit merged.
>
> For what it's worth -- I as a user am violently opposed to kinit not being in 
> the source tree, if _anything_ is merged.
>
> Given that's it's intended to take over kernel functionality, kinit would be 
> a tightly coupled piece of software and a number of problems 2.6 has seen are 
> with tightly coupled software (udev, alsa-lib) getting out of sync with the 
> kernel. I believe someone from redhat complained about it last. Adding 
> another tightly coupled external app to the mix is just going to worsen the 
> situation. Please don't do that.
>
> And yes, then there's the issue of keeping distributions all using the same 
> thing which I saw someone else remark on as well. If klibc/kinit is the way 
> forward, please make sure kinit is in the kernel source tree.

I first started useing linux in the 0.88 days, and have been useing it heavily 
for the last 10 years (with custom kernels throughout, first due to the need, 
later for other reasons). During all of that time I have avoided useing 
initramfs or initrd on the several hundred machines I have managed over that 
time.

I personally don't like the idea of booting stuff out of the kernel into a 
userspace 'thing' that needs to be built and maintained in addition to the 
kernel (for that matter I have almost entirely avoided the use of modules as 
well).

however, if kinit/klibc are included with the kernel and a make && make install 
(or similar) will end up createing a blob that will boot, I won't care if the 
blob is entirely kernel or is kernel+initrd with some functionality in 
userspace.

Ted makes a good point that distros will want to further tweak the boot process 
and that the right way is to give them hooks to add their custom stuff. we don't 
want every distro to throw out the thing that the kernel compiles to put in 
their own.

David Lang
