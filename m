Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266431AbUFQJ0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266431AbUFQJ0i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 05:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266435AbUFQJ0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 05:26:38 -0400
Received: from forty.greenhydrant.com ([208.48.139.185]:20381 "EHLO
	forty.greenhydrant.com") by vger.kernel.org with ESMTP
	id S266431AbUFQJ0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 05:26:36 -0400
Message-ID: <40D163C8.30507@greenhydrant.com>
Date: Thu, 17 Jun 2004 02:26:32 -0700
From: David Rees <drees@greenhydrant.com>
User-Agent: Mozilla Thunderbird 0.7 (Windows/20040616)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Wainwright <prw@ceiriog1.demon.co.uk>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: Irix NFS servers, again :-)
References: <1087411925.30092.35.camel@ceiriog1.demon.co.uk>
In-Reply-To: <1087411925.30092.35.camel@ceiriog1.demon.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Wainwright wrote, On 6/16/2004 11:52 AM:
> I just upgraded one of my machines to Fedora Core 2, including
> kernel 2.6.5. I found myself bitten on the bum by a bug I thought
> had expired long ago, namely the Irix server readdir bug, or
> 32/64-bit cookie problem.
 >
> It seems the relevant patch
> http://www.fys.uio.no/~trondmy/src/2.4.18/linux-2.4.18-seekdir.dif
> was never incorporated in the mainstream kernel; however, Red Hat
> did incorporate a similar patch (called, I believe,
> linux-2.4.18-irixnfs.patch) in the later 2.4 kernel RPMS. However,
> it seems that this has been omitted from the 2.6 kernels in Fedora.
> So, I have the old problem: in a directory listing from an NFS
> directory mounted from an Irix server, some entries may be
> missing.
> 
> So, my question is: what happened to this patch? Is there a
> 2.6 version available somewhere on the net? Was it not
> incorporated into the mainstream kernel because it is not the
> "right thing" to do (and maybe there is no "right thing" until
> we are all running on 64 bits)? If this is the opinion of
> the kernel developers I shall chase Red Hat to see if they can
> resurrect it when 2.6 kernels appear in their RHEL product.
> Some of us unfortunately still need to interoperate with Irix
> and other strange systems :-)
> 
> If the list is interested, I have "sort of" ported the patch
> to Linux 2.6.6 myself - just before I left work this afternoon;
> It seems functional, but I need to have another look on my network
> at work (where I have the SGI system) before I post it; there may be
> other bits that need patching, though I hope my minimal patch will
> suffice.

I ran across the same problem the other day.  Maybe someone on the nfs 
list have a better idea on what the proper solution is.  My temporary 
solution was to go back to a 2.4 kernel with the seekdir.dif patch.

Looking at Trond's 2.6 NFS patches, there doesn't appear to be any sort 
of seekdir patch for those kernels.

As I understand it the real problem is actually in glibc.  I have to 
double check, but I think the software which showed this bug when I 
experienced it on FC2 was statically linked with an older version of 
glibc.  I can't seem to reproduce it using `ls` which I remember being 
able to last time I had the problem so that would explain it.  What 
software showed the problem for you?

See this message from the nfs list.  There is more data in the archives 
if you look.
http://marc.theaimsgroup.com/?l=linux-nfs&m=105158098101612&w=2

-Dave
