Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWHCMQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWHCMQs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 08:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWHCMQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 08:16:48 -0400
Received: from wx-out-0102.google.com ([66.249.82.195]:4968 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932363AbWHCMQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 08:16:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Nl/3bogr+ooq/vHT0ZJOXaWF9MOCNhiQpjsCKyIRw39at+c50I+d2AkKcVasavZbRNSiEx6w/EXIBcDw6di8G/iK0D/v7XfVQUVqVXODj0RmtHYME+zYky9WctLM4kS34Ds0ntKQeftDVqVUKDCiVzgKCfyWbzbw34sShsdVmnQ=
Message-ID: <69304d110608030516y16f7d1fdiaccfbe4ecca3084a@mail.gmail.com>
Date: Thu, 3 Aug 2006 14:16:46 +0200
From: "Antonio Vargas" <windenntw@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>,
       "Zachary Amsden" <zach@vmware.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Linus Torvalds" <torvalds@osdl.org>, greg@kroah.com,
       "Andrew Morton" <akpm@osdl.org>,
       "Christoph Hellwig" <hch@infradead.org>,
       "Rusty Russell" <rusty@rustcorp.com.au>, "Jack Lo" <jlo@vmware.com>
Subject: Re: A proposal - binary
In-Reply-To: <1154603822.2965.18.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44D1CC7D.4010600@vmware.com>
	 <1154603822.2965.18.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Thu, 2006-08-03 at 03:14 -0700, Zachary Amsden wrote:
> > I would like to propose an interface for linking a GPL kernel,
> > specifically,
> > Linux, against binary blobs.  Stop.  Before you condemn this as evil,
> > let me
> > explain in precise detail what a binary blob is.
>
>
> Hi,
>
> you use a lot of words for saying something self contradictory. It's
> very simple; based on your mail, there's no reason the VMI gateway page
> can't be (also) GPL licensed (you're more than free obviously to dual,
> tripple or quadruple license it). Once your gateway thing is gpl
> licensed, your entire proposal is moot in the sense that there is no
> issue on the license front. See: it can be very easy. Much easier than
> trying to get a license exception (which is very unlikely you'll get)...
>
>
> Now you can argue for hours about if such an interface is desirable or
> not, but I didn't think your email was about that.
>
> Greetings,
>     Arjan van de Ven
>
> --
> if you want to mail me at work (you don't), use arjan (at) linux.intel.com

If the essence of using virtual machines is precisely that the machine
acts just as if it was a real hardware one, then we should not need
any modifications to the kernel. So, it would be much better if the
hypervirsor was completely transparent and just emulated a native cpu
and a common native set of hardware, which would then work 100% with
the native code in the kernel. This keeps the smarts of virtual
machine management on the hypervisor.

For example, TBL and pagetable handling can be done with 2 interfaces,
one standard via intercepting normal cpu instructions, and a batched
one via a hardware driver with a FIFO on shared memory just like many
graphics card do to send commands and data to the GPU. I recall this
design was the one used in the mac-on-linux hypervisor for ppc
architecture. Why not for x86 with vt/pacifica extensions? What about
using the same design than on the Sparc T1 port?

-- 
Greetz, Antonio Vargas aka winden of network

http://network.amigascne.org/
windNOenSPAMntw@gmail.com
thesameasabove@amigascne.org

Every day, every year
you have to work
you have to study
you have to scene.
