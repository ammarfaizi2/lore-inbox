Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWIPEpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWIPEpm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 00:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbWIPEpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 00:45:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35718 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750882AbWIPEpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 00:45:41 -0400
Date: Sat, 16 Sep 2006 13:44:50 +0900
From: Stephen Hemminger <shemminger@osdl.org>
To: jim@gibbons.com
Cc: Miguel Ojeda <maxextreme@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: request for ioctl range for private devices
Message-ID: <20060916134450.50398540@localhost.localdomain>
In-Reply-To: <450B48CC.6060604@gibbons.com>
References: <450B31BF.4050604@gibbons.com>
	<653402b90609151726l230e9bafg5d06a36e7cd7b32c@mail.gmail.com>
	<450B48CC.6060604@gibbons.com>
X-Mailer: Sylpheed-Claws 2.1.1 (GTK+ 2.8.17; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2006 17:43:56 -0700
Jim Gibbons <jim@gibbons.com> wrote:

> I can see that I wasn't as clear as I should have been.  Thank you for 
> trying to figure it out anyway.
> 
> Please let me try again to explain.  We are using a driver interface to 
> our kernel level code.  Our kernel level code is a loadable module.  We 
> have no intention of modifying the kernel or of releasing our code.  We 
> accept the implied maintenance responsibility on this private, embedded 
> platform.

Then why should the main kernel developers do anything to help you
with your private effort?

> We will, however, use code from the public Linux sources.  We are 
> planning to use 2.6 at the moment, but we hope to update in the future.  
> We also expect that we will update our platform, possibly adding new, 
> publicly supported devices to it.


So it is by definition a derived work under GPL

> In this environment, we want to allow our daemons to communicate with 
> our kernel module via its driver interface.
> 
> With all this having been said, we would like to find a range of ioctls 
> to use for this communication.  We don't want to reserve a range for 
> ourselves.  That would be silly, since this is such a private 
> situation.  We do think that such embedded use might be common, though, 
> and we would like to see a range of ioctls reserved for private and 
> experimental uses like ours.
> 
> I hope that such an ioctl range might be reserved, so that we can avoid 
> conflict with other public devices in the future.
> 
> Thanks for your help.
> 
> Miguel Ojeda wrote:
> > On 9/16/06, Jim Gibbons <jim@gibbons.com> wrote:
> >>
> >> I would like to use an ioctl range that would be safe, now and in the
> >> future.  Given that we won't be putting this driver on any general
> >> computing platforms, it seems inappropriate to reserve an ioctl range
> >> for this device.
> >>
> >
> > I'm trying to get a patch accepted, and I just modified the file to
> > appear in the ioctl-number list, so if they apply the patch, the magic
> > number will be automatically reserved.
> >
> > I think it's the right approach. Anyway, you should write and send the
> > device driver first, for review, because some people disagree with
> > your ioctl use, and maybe they can ask you for use another way to
> > communicate special commands to your device.
> >
> > If you are not going to submit the driver code ever, I think it will
> > be much more difficult to get a ioctl just for your private use. If
> > I'm right, you will have to keep your patch update on your own, as it
> > doesn't belong to linux at all.
> >
> >      Miguel Ojeda
> 
> -- 
> Jim Gibbons
> 	jim@gibbons.com
> Gibbons and Associates, Inc.
> 	TEL: (408) 984-1441
> 900 Lafayette, Suite 704, Santa Clara, CA
> 	FAX: (408) 247-6395
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
