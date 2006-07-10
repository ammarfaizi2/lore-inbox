Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422638AbWGJPGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422638AbWGJPGM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 11:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbWGJPGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 11:06:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:20290 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965014AbWGJPGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 11:06:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NhJub+gorsagM7yCmbgU/2QkuOwC5rmoorWtEOfYQolQat8PpCXn0mHuORDySA7B1Eg7bxSpzNSQpWN874kCuR9NMwtiR53SchETtq0Irru0osc5wI50HgiJqV/vjNANEJuPPbAFODodHt623F6MrNP8Rpp3If70eTRuDaPMPmE=
Message-ID: <787b0d920607100806u613e7594nb6a7a1e2965e11a6@mail.gmail.com>
Date: Mon, 10 Jul 2006 11:06:09 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Subject: Re: Opinions on removing /proc/tty?
Cc: ray-gmail@madrabbit.org, "Jon Smirl" <jonsmirl@gmail.com>,
       "Greg KH" <greg@kroah.com>, alan@lxorguk.ukuu.org.uk, efault@gmx.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0607101601470.5071@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920607082230w676ddc62u57962f1fc08cf009@mail.gmail.com>
	 <9e4733910607090704r68602194h3d2a1a91a4909984@mail.gmail.com>
	 <787b0d920607090923p65c417f2v71c8e72bf786f995@mail.gmail.com>
	 <2c0942db0607091000m259c1ed5m960821eb5237c4b0@mail.gmail.com>
	 <787b0d920607091226sb1db56dg9c0267f6ae8e2dc7@mail.gmail.com>
	 <20060709193133.GA32457@flint.arm.linux.org.uk>
	 <787b0d920607091257u52198c55sb8973a39bff3fcc8@mail.gmail.com>
	 <Pine.LNX.4.61.0607101601470.5071@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> >
> > Just do /proc/*/tty links and all will be good. This even
> > handles the case of two different names for the same dev_t.
> >
> Is this for the controlling tty? Then it should be ctty.

Eeeew, an extra byte so it can look ugly.
What other special tty is there?

It's always been "tty" in the kernel as far as I know.
See "struct tty_struct *tty" in sched.h's struct signal_struct.

Various "ps" programs have always used "TTY" or "TT".
This makes "tt" more reasonable than "ctty".
