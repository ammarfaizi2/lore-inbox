Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262411AbVCBSVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262411AbVCBSVR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 13:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbVCBSRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 13:17:42 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:36053 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S262399AbVCBSOm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 13:14:42 -0500
From: Bernd Schubert <bernd-schubert@web.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: x86_64: 32bit emulation problems
Date: Wed, 2 Mar 2005 19:14:24 +0100
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@muc.de>, Andreas Schwab <schwab@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200502282154.08009.bernd.schubert@pci.uni-heidelberg.de> <200503021233.57341.bernd-schubert@web.de> <1109782387.9667.11.camel@lade.trondhjem.org>
In-Reply-To: <1109782387.9667.11.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200503021914.25376.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 March 2005 17:53, Trond Myklebust wrote:
> on den 02.03.2005 Klokka 12:33 (+0100) skreiv Bernd Schubert:
> > > I can see no good reason for truncating inode number values on
> > > platforms that actually do support 64-bit inode numbers, but I can see
> > > several
> >
> > Well, at least we would have a reason ;)
>
> A 32-bit emulation mode is clearly a "platform" which does NOT support
> 64-bit inode numbers, however there is (currently) no way for the kernel
> to detect that you are running that. Any extra truncation should
> therefore ideally be done by the emulation layer rather than the kernel
> itself.
>

I already found the function in glibc and it looks as if it would be rather 
easy to do it there. I only hope the glibc maintainers will accept this kind 
of fixes (hope they won't say that nobody needs this).


Cheers,
 Bernd


PS: Also many thanks for fixing other bugs in the NFS client. Until 2.6.9 init 
somehow could not open /dev/console on a readonly mountpoint. With 2.6.11 
this problem has disappeared, thanks a lot for fixing this and other 
problems. I never had the time to write a bugreport for that.


-- 
Bernd Schubert
Physikalisch Chemisches Institut / Theoretische Chemie
Universität Heidelberg
INF 229
69120 Heidelberg
e-mail: bernd.schubert@pci.uni-heidelberg.de
