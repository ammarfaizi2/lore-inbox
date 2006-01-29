Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbWA2M3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWA2M3D (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 07:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbWA2M3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 07:29:03 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:271 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750852AbWA2M3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 07:29:02 -0500
Date: Sun, 29 Jan 2006 13:29:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Christoph Hellwig <hch@infradead.org>, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Keyrings] Re: [PATCH 01/04] Add multi-precision-integer maths library
Message-ID: <20060129122901.GX3777@stusta.de>
References: <1138312694656@2gen.com> <1138312695665@2gen.com> <6403.1138392470@warthog.cambridge.redhat.com> <20060127204158.GA4754@hardeman.nu> <20060128002241.GD3777@stusta.de> <20060128104611.GA4348@hardeman.nu> <1138466271.8770.77.camel@lade.trondhjem.org> <20060128165732.GA8633@hardeman.nu> <1138504829.8770.125.camel@lade.trondhjem.org> <20060129113320.GA21386@hardeman.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060129113320.GA21386@hardeman.nu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2006 at 12:33:20PM +0100, David Härdeman wrote:
> On Sat, Jan 28, 2006 at 10:20:29PM -0500, Trond Myklebust wrote:
> >On Sat, 2006-01-28 at 17:57 +0100, David Härdeman wrote:
> >>What about the first paragraph of what I wrote? You are going to want to 
> >>keep often-used keys around somehow, proxy certificates is not a 
> >>solution for your own use of your personal keys and with the exception 
> >>of hardware solutions such as smart cards, the keys will be safer in the 
> >>kernel than in a user-space daemon...
> >
> >I don't get this explanation at all.
> >
> >Why would you want to use proxy certificates for you own use? Use your
> >own certificate for your own processes, and issue one or more proxy
> >certificates to any daemon that you want to authorise to do some limited
> >task.
> 
> I meant that you can't use proxy certs for your own use, so you still need 
> to store your own cert/key somehow...and I still believe that the kernel 
> keyring is the best place...


You are taking the wrong approach.

The _only_ question that matters is:
Why is it technically impossible to do the same in userspace?

If it's technically possible to do the same in userspace, it must not be 
done in the kernel.

That's exactly the reason why e.g. kernel 2.6 does not contain a 
webserver.


> >...and what does this statement about "keys being safer in the kernel"
> >mean?
> 
> swap-out to disk, ptrace, coredump all become non-issues. And in 
> combination with some other security features (such as disallowing 
> modules, read/write of /dev/mem + /dev/kmem, limited permissions via
> SELinux, etc), it becomes pretty hard for the attacker to get your 
> private key even if he/she manages to get access to the root account.
>...


Which part of this is technically impossible when doing key management 
in usespace?


> Re,
> David

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

