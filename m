Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbVK0Ojj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbVK0Ojj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 09:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbVK0Ojj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 09:39:39 -0500
Received: from eastrmmtao06.cox.net ([68.230.240.33]:25343 "EHLO
	eastrmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751082AbVK0Ojj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 09:39:39 -0500
In-Reply-To: <20051127105700.GO11266@alpha.home.local>
References: <9c21eeae0511261352u33e32343wf50062ba3038ef06@mail.gmail.com> <200511270138.25769.s0348365@sms.ed.ac.uk> <29495f1d0511261746y12a0c356ueb3d5bb08aa6f6a@mail.gmail.com> <200511270151.21632.s0348365@sms.ed.ac.uk> <9c21eeae0511261756r65d0f4b7l96b0e1089c4c62bc@mail.gmail.com> <29495f1d0511261827s7984bea8l92149b8a3091e6d8@mail.gmail.com> <9c21eeae0511261838ncec563v1739a1230347365b@mail.gmail.com> <20051127060937.GN11266@alpha.home.local> <9c21eeae0511270122h38cfb4a4y5d242347cbf9a21e@mail.gmail.com> <20051127105700.GO11266@alpha.home.local>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B6DD0BF3-A19D-4E14-A634-B8A1C8FAAC5F@mac.com>
Cc: David Brown <dmlb2000@gmail.com>,
       Nish Aravamudan <nish.aravamudan@gmail.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: linux-2.6.14.tar.bz2 permissions
Date: Sun, 27 Nov 2005 09:39:37 -0500
To: Willy Tarreau <willy@w.ods.org>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 27, 2005, at 05:57:00, Willy Tarreau wrote:
> On Sun, Nov 27, 2005 at 01:22:26AM -0800, David Brown wrote:
>> I agree compiling the kernel as a non-root user is perfered but  
>> sometimes it doesn't happen that way...
>
> Sudo generally helps here. It's even easy to put $SUDO in front of  
> sensible commands in build scripts and have SUDO=${SUDO-sudo} at  
> the beginning of the script.

Even nicer:  On Debian there's a "make-kpkg" command for building or  
cross-compiling a kernel source tree and creating a debian package  
from the result, and it can use "fakeroot" for all of the  
intermediate steps.  As a result, I can build a complete kernel  
package with "make-kpkg --rootcmd=fakeroot [...]" as an ordinary  
user, and then later install it as root with only one command: "dpkg - 
i linux-image-2.6.15-rc2_2.6.15-rc2-1_powerpc.deb".

Cheers,
Kyle Moffett
