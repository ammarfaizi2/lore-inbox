Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751503AbWFDO6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbWFDO6I (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 10:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbWFDO6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 10:58:08 -0400
Received: from wx-out-0102.google.com ([66.249.82.204]:10200 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751503AbWFDO6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 10:58:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a58N8C3rxhjgumJuoBV6B/o+SOKmhgIwgKH/dq+gR2r0wbqGcZx/rdA2mKMmVJccKw0phnf80u+fGw1ub/yCuwq8yJaxtNXdrvIAmjFr7hRV5wD7S0ToT8Huds2MS39DSDqx5KH99SJTBRDiEDNLwMZk+3snZOJXgEKlpCyXSow=
Message-ID: <beee72200606040758h13e8a2d5ia815f44521e21230@mail.gmail.com>
Date: Sun, 4 Jun 2006 16:58:05 +0200
From: "davor emard" <davoremard@gmail.com>
To: "Con Kolivas" <kernel@kolivas.org>
Subject: Re: SMP HT + USB2.0 crash
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <beee72200606040729u4c660583g1b7e669b85db5bca@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <beee72200606040322w2960e5f9j1716addc39949ccb@mail.gmail.com>
	 <200606042142.01879.kernel@kolivas.org>
	 <beee72200606040729u4c660583g1b7e669b85db5bca@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tested it with kernel 2.6.15.7 with nvidia
7174 drivers from which syslog's this oops capture
probably came from but the same thing but less frequently
happens with kernel 2.6.16.19 without nvidia drivers
(nvidia 7174 can't be compiled for 2.6.16.19).

For 2.6.15.7 it takes 2-10 minutes to crash, while for 2.6.16.19
it takes 1-2 days to crash. Yes it is more stable.
Usually it reports the similar oops like I supplied, but sometimes
also 2.6.16.19 reports SMP type crash - sorry I didn't have serial
console connected and didn't write it down - it looks different than
usual oops, contains less registers and no call traces showing
where in the source it crashed (I have never seen such oops before).

2.6.16.19 was running in console only mode and only with
drivers shipped in kernel. No external binary for nvidia, no
external source for ethernet. As the crash location report was
not indicatve to which module caused it, I was removing
one by one suspect module (dvb, firewire ethernet etc) and
reinserting them again until I narrowed it down to the
combination of SMP and EHCI that caused the crash.
Removing either of them makes the machine stable


On 6/4/06, davor emard <davoremard@gmail.com> wrote:
> I tested this _A_LOT_ and it doesn't matter if I
> use "nvidia" binary drivers or x.org's free "nv" or
> have just a text console with no X at all.
> It happens on a production machine :(
>
> Most easily to trigger this bug is to use USB2.0 epson
> scanner over and have scanbuttond running - it will poll
> scan buttons via usb2.0 and crash
>
> On 6/4/06, Con Kolivas <kernel@kolivas.org> wrote:
> > On Sunday 04 June 2006 20:22, davor emard wrote:
> > > Usually SMP + EHCI crashes like this
> >
> > Unless you can reproduce your crash without binary only drivers such as
> the
> > nvidia one your bug report cannot be acted upon.
> >
> > --
> > -ck
> >
>
