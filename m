Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289094AbSANWXO>; Mon, 14 Jan 2002 17:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289096AbSANWW7>; Mon, 14 Jan 2002 17:22:59 -0500
Received: from fly.HiWAAY.net ([208.147.154.56]:24590 "EHLO mail.hiwaay.net")
	by vger.kernel.org with ESMTP id <S289102AbSANWWd>;
	Mon, 14 Jan 2002 17:22:33 -0500
Date: Mon, 14 Jan 2002 16:22:30 -0600
From: Chris Adams <cmadams@hiwaay.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Hardwired drivers are going away?
Message-ID: <20020114222230.GA16490@HiWAAY.net>
In-Reply-To: <fa.g055bvv.qmq0hk@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ksahkuv.tg60gl@ifi.uio.no>
User-Agent: Mutt/1.3.25i
Organization: HiWAAY Internet Services
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <fa.ksahkuv.tg60gl@ifi.uio.no>, David Lang wrote:
>I can see a couple reasons for building a kernel without useing modules.
>
>1. security, if you don't need any modules you can disable modules entirly
>and then it's impossible to add a module without patching the kernel first
>(the module load system calls aren't there)

There is no security gain from disabling module loading.  If someone has
the level of access needed to load modules, they also have access to
/dev/mem.  Run-time patching of the kernel is something that can be done
(and probably is done by some rootkits).  For bonus points, patch in the
system call(s) required by insmod and voila: module loading now works
(instead of having to patch all your rootkit code into the running
kernel, patch in insmod and let the kernel load the code for you).
-- 
Chris Adams <cmadams@hiwaay.net>
Systems and Network Administrator - HiWAAY Internet Services
I don't speak for anybody but myself - that's enough trouble.
