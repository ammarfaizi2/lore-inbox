Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262780AbVBCNjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262780AbVBCNjc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 08:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbVBCNjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 08:39:31 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:48033 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262780AbVBCNgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 08:36:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=OwkphZG/k79DJLoW0gERu/c5rzSNZKRYPc/sBeQZugiAEUniA+yii1S0NKeyPJcdZ5mxjypJ1sHZvvW5xLW9TLVzaKa08MnB2qO1yZh27IhCDqbJE5Cblf31yBrWHS3mnAmI07KemCgS+Q6xiQPjo1Lg3hM/n5HeF/Np6m7IWm8=
Message-ID: <58cb370e050203053421b571be@mail.gmail.com>
Date: Thu, 3 Feb 2005 14:34:29 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [ide-dev 3/5] generic Power Management for IDE devices
Cc: Pavel Machek <pavel@suse.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1107332644.14782.115.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.GSO.4.58.0501220004050.23959@mion.elka.pw.edu.pl>
	 <20050122184124.GL468@openzaurus.ucw.cz>
	 <58cb370e05020115032fdb8b59@mail.gmail.com>
	 <1107332644.14782.115.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Feb 2005 10:03:00 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Maw, 2005-02-01 at 23:03, Bartlomiej Zolnierkiewicz wrote:
> > On Sat, 22 Jan 2005 19:41:24 +0100, Pavel Machek <pavel@suse.cz> wrote:
> > > Why do you need to have state-machine? During suspend we are running
> > > single-threaded, it should be okay to just do the calls directly.
> > >                                 Pavel
> >
> > If we are running single-threaded I also see no reason for state-machine.
> > Ben?
> 
> There may be outstanding I/O running at the time of the suspend. You
> want to keep everything nicely ordered. The state machine suspend code
> looks to me the right answer and is cleaner.

Outstanding I/Os won't be a problem - suspend will be done as one
request.  Anyway, state machine is not going away.
