Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbVLFUm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbVLFUm0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 15:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbVLFUm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 15:42:26 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:42998 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030230AbVLFUmZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 15:42:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R/O8m6jVQShXEemdlG7STrPsSqOhMotbxJ8FNJmcShQmEgTCdfYLxmJlau+gCFDYyiaoqxa1QdnDRXVOXpomKUzCFzWTiJfELFPqk8byUOrzmkbWSoaF1D+EqJjxr3wfNcnYKleSVd3IErEkICrT6KQ78k+/5dxEcTd3B27qDxE=
Message-ID: <37219a840512061242m31bba119p16ab232394ff936a@mail.gmail.com>
Date: Tue, 6 Dec 2005 15:42:24 -0500
From: Michael Krufky <mkrufky@gmail.com>
To: Prakash Punnoor <prakash@punnoor.de>
Subject: Re: [PATCH] b2c2: make front-ends selectable and include noob option
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
In-Reply-To: <200512062139.16846.prakash@punnoor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200512062053.00711.prakash@punnoor.de>
	 <37219a840512061220w17388551jd54c189973e23355@mail.gmail.com>
	 <200512062139.16846.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/05, Prakash Punnoor <prakash@punnoor.de> wrote:
> Am Dienstag Dezember 6 2005 21:20 schrieb Michael Krufky:
> > On 12/6/05, Prakash Punnoor <prakash@punnoor.de> wrote:
> > > Hi,
> > >
> > > this patch probably needs some touch-up but mainly I am sking the dvb
> > > guys why
> > > don't they do something like this. Current situation:
> > >
> >
> > NACK.
> >
> > You are going to run into some problems with this patch... For instance,
> > What if the user chooses to compile the b2c2-flexcop driver in-kernel, but
> > only compiles the frontend drivers as modules...  Then, the frontend
> > support will be built into the flexcop driver, but the module will not yet
> > be available at the time when the kernel is looking for it...
>
> Well, I said it needed touch up. ;-) After all I didn't seriously believe it
> gets merged in current state (and yes, I didn't think about the module issue,
> but you're right , of course). But it simply didn't seem like dvb guys are
> caring about the problem. I once (probably half a year ago already) mailed to
> linux-dvb and got zero response. That told me everything.
>
> Personally I won't invest more time in perfecting the patch. I just wanted to
> get some attention to this problem and will use the patch privately for my
> own happiness...
>
> Thanks for your input.

Okay, that sounds reasonable... I will make it a point to discuss this
issue with Johannes, and either

a) revert my frontend selection patch

or

b) apply the same logic that I employed to [cx88,saa7134]-dvb to the
other drivers.

Thanks,

Michael
