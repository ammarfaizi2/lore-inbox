Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262918AbVFXO4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbVFXO4g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 10:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262919AbVFXO4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 10:56:36 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:10663 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262918AbVFXOz7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 10:55:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qqzKPcEf4yzwngvV3wO/nD8sbDjK+Im8ja5iGCaQjIW2KmQGRsyep8sUF2GwHdGOa2+WE9Lw1nm7BV9a4CDNSun2of+2mrTanfHMwrm6/BqNExHR+2KH6NKnYPS3w0+BnQynTf87ksIL+YluXR31g0EGJxPJA3QnnZ+joeh8QIc=
Message-ID: <5fc59ff30506240755149b048@mail.gmail.com>
Date: Fri, 24 Jun 2005 07:55:58 -0700
From: Ganesh Venkatesan <ganesh.venkatesan@gmail.com>
Reply-To: Ganesh Venkatesan <ganesh.venkatesan@gmail.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: e1000 driver works on UP, bt not SMP x86_64 (2.6.7 -2.6.12)
Cc: David Lang <david.lang@digitalinsight.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200506220038.05869.adobriyan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.62.0506191642440.12697@qynat.qvtvafvgr.pbz>
	 <200506220038.05869.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David:

Does this not happen with kernels earlier than 2.6.7 or you have not
tried them? After you ifconfig the fourth port what does
/proc/interrupts look like? Any additional info in syslog?

ganesh.

On 6/21/05, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> On Monday 20 June 2005 03:55, David Lang wrote:
> > I have some systems with three Intel quad gig-E cards in them that
> > function with the attached UP config, but port 4 of each card doesn't work
> > properly with a SMP kernel (otherwise the same config).
> >
> > on a SMP kernel when I do an ifconfig of the fourth port I get the
> > following error
> > SIOCSIFFLAGS: Function not implemented
> >
> > doing an ifconfig of the interface then looks proper, but no network route
> > is added.
> >
> > I first ran into this problem with a 2.6.7 kernel and tried several
> > kernels from there to 2.6.12, all of which showed the same problem on SMP
> > kernels. the problem happens with the driver built-in and as a module.
> >
> > the systems are dual Opteron 246, 2G ram MPT fusion SCSI drives.
> 
> I've filed a bug at kernel bugzilla, so your report won't be lost.
> See http://bugzilla.kernel.org/show_bug.cgi?id=4774
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
