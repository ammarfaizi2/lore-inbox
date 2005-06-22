Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbVFVRAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVFVRAw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 13:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVFVQ4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 12:56:53 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:54351 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261587AbVFVQ4L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 12:56:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ecjStPTlvVh5DpdV4TsgHZpIbSF6y22/QmGimMoRHZRRBWfb0eGv+Ztiz8+4x/WJZTm1aX9o3nPMaaDv16GeGfADXBNdusgZ2CaoqYOtHasV5MWSbv80fo8YwE+03LWge1JhJpawYqx3O7swsvtQwFdMCSQug75v1YBQMDs6/OA=
Message-ID: <a4e6962a05062209564d053393@mail.gmail.com>
Date: Wed, 22 Jun 2005 11:56:06 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: -mm -> 2.6.13 merge status (fuse)
Cc: Pavel Machek <pavel@ucw.cz>, Miklos Szeredi <miklos@szeredi.hu>,
       akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1119458579.11528.93.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050620235458.5b437274.akpm@osdl.org>
	 <E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu>
	 <20050621142820.GC2015@openzaurus.ucw.cz>
	 <E1DkkRE-0005mt-00@dorka.pomaz.szeredi.hu>
	 <20050621220619.GC2815@elf.ucw.cz>
	 <a4e6962a05062207435dd16240@mail.gmail.com>
	 <20050622150839.GB1881@elf.ucw.cz>
	 <a4e6962a050622085021cdfb9d@mail.gmail.com>
	 <1119458579.11528.93.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > 1) only allow user's to mount/bind on directories/files where they
> > have unconditional write access.
> 
> Like say /tmp. Build a bizarre behaving /tmp and I can do funky stuff
> with some third party suid apps. Its a good start but you probably want
> a stronger policy and one enforced by the user space side not kernel (eg
> "Below ~")
>

Well in the original discussions Miklos had classified directories
that had the sticky bit set (such as /tmp) as out-of-bounds for
user-mounts.  However, its a point well taken.   I had originally
proposed having some sort of a policy file (sort of like an extended
fstab with regular expressions) to give more granular control over
where users could and couldn't mount (along with what types of
devices, network servers, and file systems they could mount from). 
However, this leans more towards the "super-mount" suid-application
which I think many found undesirable.  An alternative would be some
way for the kernel to consult with an application about different
mount policies.  I don't know what the right thing is here.
 
> > 2) enforce NOSUID mount options on user-mounts
> 
> 2 is unneccessarily crude. Just enforce suid owner/owner group.
> 

I'm dense this morning, not sure what you mean here.
 
    -eric
