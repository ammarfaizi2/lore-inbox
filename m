Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbUC2VzL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 16:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbUC2VzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 16:55:11 -0500
Received: from dsl081-235-061.lax1.dsl.speakeasy.net ([64.81.235.61]:44197
	"EHLO ground0.sonous.com") by vger.kernel.org with ESMTP
	id S262005AbUC2VzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 16:55:05 -0500
In-Reply-To: <Pine.LNX.4.53.0403291644200.3114@chaos>
References: <5516F046-81C1-11D8-A0A8-000A959DCC8C@sonous.com> <Pine.LNX.4.53.0403291602340.2893@chaos> <1CD69E8E-81C9-11D8-A0A8-000A959DCC8C@sonous.com> <Pine.LNX.4.53.0403291644200.3114@chaos>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <BB3FCEF5-81CB-11D8-A0A8-000A959DCC8C@sonous.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Lev Lvovsky <lists1@sonous.com>
Subject: Re: older kernels + new glibc?
Date: Mon, 29 Mar 2004 13:55:02 -0800
To: root@chaos.analogic.com
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 29, 2004, at 1:50 PM, Richard B. Johnson wrote:

> On Mon, 29 Mar 2004, Lev Lvovsky wrote:
>> I might be a bit confused here, but the problem with that, is that I'm
>> effectively working backwards.  I've reverted the kernel version, but
>> all other applications have been kept of course - this means that
>> though I can keep those sym-links pointing to the correct kernel
>> headers (those which were present when glibc was compiled), the 
>> current
>> kernel (the reverted one) will obviously have different include files.
>>
>> In order to compile the modules for the afformentioned hardware, those
>> symlinks need to point to the 2.2.x kernel directories - will this
>> break functionality of future compiled applications etc?
>>
>
> No No. Never! The modules never, ever, use glibc headers. Never!
>
> The compilation should set the -I (include) parameter to point
> to the kernel headers.
>
> Something like:
>
> VER	:= $(shell uname -r)
> INC= -I. -I/usr/src/linux-$(VER)
> DEF= -D__KERNEL__ -DMODULE
>
> gcc -c -Wall -O2 -fomit-frame-pointer $(INC) $(DEF) -m module.o 
> module.c

sorry, that was my mistake in wording - the modules point to the kernel 
headers.  However, the system as it was first made, had those 
directories symlinked to the 2.4.7 (?) kernel - I had to remove that 
package, and symlink the "asm", and "linux" directories to the 2.2.26 
kernel directories of the same name - I'm assuming this is the correct 
thing to do? (it did work ;)

thanks,
-lev

