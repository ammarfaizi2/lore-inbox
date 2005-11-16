Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965245AbVKPHN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965245AbVKPHN2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 02:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbVKPHN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 02:13:28 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:46767 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1751458AbVKPHN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 02:13:27 -0500
Subject: Re: [linux-pm] [RFC] userland swsusp
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Greg KH <greg@kroah.com>
Cc: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20051116061459.GA31181@kroah.com>
References: <20051115212942.GA9828@elf.ucw.cz>
	 <20051115222549.GF17023@redhat.com> <20051115233201.GA10143@elf.ucw.cz>
	 <1132115730.2499.37.camel@localhost>  <20051116061459.GA31181@kroah.com>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1132120845.25230.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 16 Nov 2005 17:00:45 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2005-11-16 at 17:14, Greg KH wrote:
> On Wed, Nov 16, 2005 at 06:35:30AM +0200, Dumitru Ciobarcianu wrote:
> > ??n data de Mi, 16-11-2005 la 00:32 +0100, Pavel Machek a scris:
> > > ...but how do you provide nice, graphical progress bar for swsusp
> > > without this? People want that, and "esc to abort", compression,
> > > encryption. Too much to be done in kernel space, IMNSHO.
> > 
> > Pavel, you really should _listen_ when someone else is talking about the
> > same things in different implementations. suspend2 has this feature
> > (nice graphical progress bars in userspace) for a long time now and it's
> > compatible with the fedora kernels.
> 
> It's also implemented in the kernel, which is exactly the wrong place
> for this.  Pavel is doing this properly, why do you doubt him?

You yourself called it a hack not long ago. I'm not sure why you think
the userspace is the right place for suspending. It seems to me that the
very fact that it requires access to structures that are normally only
visible to the kernel is pretty telling. To be fair, it is true at the
same time that graphical interfaces don't belong in the kernel - but the
vast majority of it - calculating what to write and doing the writing
does. It's only by hamstringing himself and the user - limiting the
image to half of memory that Pavel (and dropping support for writing to
swap) that Pavel can make this work.

> > Why don't you and Nigel (of suspend2) can just work together on this ?
> > It's a shame that much work is wasted in duplicated effort.
> 
> It's not duplicated, Nigel knows what need to be done to work together,
> if he so desires.

I know that Pavel and I have such different ideas about what should be
done that it's not worth the effort.

Regards,

Nigel

> thanks,
> 
> greg k-h
> 
> ______________________________________________________________________
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
-- 


