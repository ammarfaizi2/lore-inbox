Return-Path: <linux-kernel-owner+w=401wt.eu-S1754684AbXAATpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754684AbXAATpT (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 14:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754700AbXAATpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 14:45:19 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.8]:3553 "EHLO
	mcr-smtp-002.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754684AbXAATpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 14:45:17 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ken Moffat <zarniwhoop@ntlworld.com>
Subject: Re: x86 instability with 2.6.1{8,9}
Date: Mon, 1 Jan 2007 19:45:43 +0000
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20070101160158.GA26547@deepthought> <20070101170758.GA28015@deepthought> <20070101191329.GA29826@deepthought>
In-Reply-To: <20070101191329.GA29826@deepthought>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701011945.43305.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 January 2007 19:13, Ken Moffat wrote:
> On Mon, Jan 01, 2007 at 05:07:58PM +0000, Ken Moffat wrote:
> > On Mon, Jan 01, 2007 at 04:48:55PM +0000, Alistair John Strachan wrote:
> > > Obviously papering over a severe bug, but why is it necessary for you
> > > to run a 32bit kernel to test 32bit userspace? If your 64bit kernel is
> > > stable, use the IA32 emulation surely?
> >
> >  My 64-bit is pure64 on this machine, so it doesn't have any
> > suitable libs or tools.  Anyway, I really do need a 32-bit kernel
> > to test some linuxfromscratch build instructions.
>
>  Sorry, I think last night is still interfering with my own logic
> circuits.  Yes, I could use 'linux32' to change the personality as a
> work-around now that I've built the system.  Mainly, I was hoping
> somebody would notice something bad in the config, but I might use
> the work-around in the meantime.  Thanks for reminding me about it.

Personally when I built an embedded LFS for a customer, I wrote a dummy "arch" 
and "uname" and then bootstrapped the 32bit LFS book, then built a cross 
compiler with the CLFS book and built a 64bit kernel. Seemed to work okay.

However, there isn't 100% compatibility in a 64bit kernel for all syscalls, I 
think one of the VFAT syscall wrappers is currently broken.

[ 5807.639755] ioctl32(war3.exe:4998): Unknown cmd fd(9) cmd(82187201){02} 
arg(00221000) on /home/alistair/.wine/drive_c/Program Files/Warcraft III

Other than that, I've had no problem with running a purely 32bit userspace.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
