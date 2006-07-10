Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422647AbWGJO5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422647AbWGJO5s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 10:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422646AbWGJO5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 10:57:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:5664 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422648AbWGJO5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 10:57:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kVMsLHoR6MFaZHEAteWHP7kfXDVctYN/w/B7selcazL6U7ii7kYY2zIOpafac85XhnokSqi+cDvPlvKspnbb5Tz1FMLGBQKJLC6ttUiDhZ9dJUpXiY2DcHgjDCtKtwh7PUi7c4h91pC5zE0Ktov7ym5IAeLJ/VnDsG9soToyDXQ=
Message-ID: <9e4733910607100757t4ddfaf93l1723580de551529b@mail.gmail.com>
Date: Mon, 10 Jul 2006 10:57:45 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] Clean up old names in tty code to current names
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
       "Greg KH" <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <44B26752.9000507@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910607092111i4c41c610u8b9df5b917cca02c@mail.gmail.com>
	 <1152524657.27368.108.camel@localhost.localdomain>
	 <9e4733910607100541i744dd744n16c35c50dae1e98d@mail.gmail.com>
	 <1152537049.27368.119.camel@localhost.localdomain>
	 <9e4733910607100603r5ae1a21ex1a2fa0f045424fd1@mail.gmail.com>
	 <1152539034.27368.124.camel@localhost.localdomain>
	 <9e4733910607100707g4810a86boa93a5b6b0b1a8d0a@mail.gmail.com>
	 <44B26752.9000507@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> > Before the change /proc/tty/drivers shows this:
> >
> > [jonsmirl@jonsmirl ~]$ cat /proc/tty/drivers
> > /dev/tty             /dev/tty        5       0 system:/dev/tty
> > /dev/console         /dev/console    5       1 system:console
> > /dev/ptmx            /dev/ptmx       5       2 system
> > /dev/vc/0            /dev/vc/0       4       0 system:vtmaster
>
> vtmaster was /dev/tty0 in 2.2.x, changed to /dev/vc/0 probably
> because of devfs. I would tend to agree with the change of at least
> this part.
>
> A few apps do rely on /proc/tty/drivers for the major-minor
> to device name mapping. /dev/vc/0 does not exist (unless
> created manually) without devfs.

This is why I questioned if /proc/tty was really in use, it contains
an entry that is obviously wrong for my system.

-- 
Jon Smirl
jonsmirl@gmail.com
