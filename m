Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262353AbVD2AXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbVD2AXp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 20:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbVD2AXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 20:23:45 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:14038 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262353AbVD2AXk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 20:23:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fNB0l+5dXFxbnbM2N6pVJu8bgTTrSHglJlaZRak0hv8uAtfGy7POHCKDFrXx2IsTFyuNSqeQ4whihcWLeEGA/l0ffzZGmgLgZ6Jz9lUKR95Aktnv53wbDH/unZFzQsSGzd2S2mVSwQ6paI5mQOS0Nbsk8+oliWRP8dyVIyYUUAg=
Message-ID: <58cb370e05042817232461fb09@mail.gmail.com>
Date: Fri, 29 Apr 2005 02:23:39 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Multiple functionality breakages in 2.6.12rc3 IDE layer
Cc: linux-ide@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1114731804.24687.259.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1114703284.18809.208.camel@localhost.localdomain>
	 <58cb370e05042813414af5bc1e@mail.gmail.com>
	 <1114727522.18355.242.camel@localhost.localdomain>
	 <58cb370e05042816003c2ca4be@mail.gmail.com>
	 <1114731804.24687.259.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Gwe, 2005-04-29 at 00:00, Bartlomiej Zolnierkiewicz wrote:
> > > why. You've disabled open() of a device with no bound driver.
> >
> > Guess what open() for ide-default was doing in 2.6?
> >
> > return -ENXIO;
> >
> > and no it wasn't my change - it was the effect of fixing
> > locking of the higher layers.
> 
> Yes so it needed fixing and without all the kref, kmalloc, unique object
> structure per ide driver code spew too.

IDE is similar to SCSI now in this respect.
Are you claiming that SCSI needs fixing too?

> > > The fact that the IDE layer appears to be getting worse not better,
> > > which given the starting point is a remarkable achievement.
> >
> > Personal insults are easy, get technical facts.
> 
> I consider that a technical fact. The last IDE code I maintained fully
> in 2.4 had mostly working locking, drive hotplug, open for unbound
> drivers, didnt oops on spurious irqs and wasn't losing all sorts of
> useful boot options. I had hoped that I wouldnt have to totally fork the
> 2.6 IDE code in order to get back to where 2.4-ac was and get the
> locking working so you can't oops it via /proc

Somehow you seem to forget that I took maintaince over
2.5.5x (or 2.5.6x) and there was a lot new stuff added when
you were away (i.e. driver-model and IDE code needs to conform
with it to get sane power management and sysfs support)
and that a lot of other things have changed (influencing IDE).

Feel free to fork so you'll be wasting yours time only and not mine.
