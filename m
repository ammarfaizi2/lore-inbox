Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWGLRJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWGLRJH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 13:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWGLRJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 13:09:07 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:23992 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932093AbWGLRJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 13:09:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VpawJ+D80CaW1jhzU3l/83z+XF8hVRAVTOnEMoGncBI19Xjhv1aYzsUq461DXs7UGP7YxRo2MJhl3HDLKWWU/c6cicNSN+PkBllBAaohY3eMYHu5cWthJsQb6gjUK1j+9XY5LE+Jkp2wwfle+ryGPAFISpxiPi6ObSm4aepv7IM=
Message-ID: <2c0942db0607121009l1fc00764ye0b98d686700a74c@mail.gmail.com>
Date: Wed, 12 Jul 2006 10:09:05 -0700
From: "Ray Lee" <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: "Alan Stern" <stern@rowland.harvard.edu>
Subject: Re: annoying frequent overcurrent messages.
Cc: "Dave Jones" <davej@redhat.com>,
       "Kernel development list" <linux-kernel@vger.kernel.org>,
       "David Brownell" <david-b@pacbell.net>
In-Reply-To: <Pine.LNX.4.44L0.0607121012570.6607-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607111747.13529.david-b@pacbell.net>
	 <Pine.LNX.4.44L0.0607121012570.6607-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/06, Alan Stern <stern@rowland.harvard.edu> wrote:
> Dave Jones wrote:
> > I have a box that's having its dmesg flooded with..
> >
> > hub 1-0:1.0: over-current change on port 1
> > hub 1-0:1.0: over-current change on port 2
> > hub 1-0:1.0: over-current change on port 1
> > hub 1-0:1.0: over-current change on port 2
> ...
>
> > over and over again..
> > The thing is, this box doesn't even have any USB devices connected to it,
> > so there's absolutely nothing I can do to remedy this.
>
> Since you're not using the UHCI controller on that computer, you could
> simply rmmod uhci-hcd (or modify /etc/modprobe.conf to prevent it from
> being loaded in the first place).  That would stop the constant interrupts
> and the syslog spamming.

For the syslog spamming, you could jus emit the message once when the
state is first noticed, then emit a everything good message when it
clears up. There's no need to log it repeatedly during the problem
period.

Ray
