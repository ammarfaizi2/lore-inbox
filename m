Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161111AbWGJNDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161111AbWGJNDx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 09:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161065AbWGJNDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 09:03:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:5986 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161090AbWGJNDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 09:03:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XoaMrdt0ArGZRiWfK/ExMqjqbxm7yrCgVoP9x7sWLvR1G1dO+QnzS3oDhjT3EBf84zYG1XDZ152eAgZaoJhRcqgZmQDxQfsQ1gJ1EnfSlWd+SkqLM2iWl6QhlIiWqwcxtK1vguE9rd6WefbpTLidFKB8IxpmHYlLmnUxazO017I=
Message-ID: <9e4733910607100603r5ae1a21ex1a2fa0f045424fd1@mail.gmail.com>
Date: Mon, 10 Jul 2006 09:03:49 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Clean up old names in tty code to current names
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Greg KH" <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <1152537049.27368.119.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910607092111i4c41c610u8b9df5b917cca02c@mail.gmail.com>
	 <1152524657.27368.108.camel@localhost.localdomain>
	 <9e4733910607100541i744dd744n16c35c50dae1e98d@mail.gmail.com>
	 <1152537049.27368.119.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Llu, 2006-07-10 am 08:41 -0400, ysgrifennodd Jon Smirl:
> > The whole naming scheme encoded into the tty code is incompatible with
> > udev. Udev allows renames and this code isn't aware of them.
>
> The idea is not to break stuff.

I agree with this. I made a mistake with the pts vs pty, why not just
help me fix the mistake instead of rejecting everything? Some the of
the info being reported in /proc/tty/drivers is wrong (vc./0 - from
the devfs attempt?). or missing.

> > It does seem that we are missing a user space library call for
> > converting a device number into a device name using the udev database.
>
> A very large number of users don't bother with udev. Relying on udev is
> not a wise thing to assume, especially in the embedded space.

I'm not going to solve this problem but it is something that needs to
be discussed. Are we really going to maintain parallel naming schemes,
one in-kernel and one out of kernel? I'm not even sure if USB will
work without udev anymore.

-- 
Jon Smirl
jonsmirl@gmail.com
