Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263996AbTFDToX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 15:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263997AbTFDToX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 15:44:23 -0400
Received: from chaos.analogic.com ([204.178.40.224]:7312 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263996AbTFDToV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 15:44:21 -0400
Date: Wed, 4 Jun 2003 16:00:55 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Samuel Flory <sflory@rackable.com>
cc: Daniel.A.Christian@NASA.gov, John Appleby <john@dnsworld.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc7 SMP module unresolved symbols
In-Reply-To: <3EDE4A38.3050405@rackable.com>
Message-ID: <Pine.LNX.4.53.0306041554130.1943@chaos>
References: <434747C01D5AC443809D5FC5405011314BEC@bobcat.unickz.com>
 <200306041106.01316.Daniel.A.Christian@NASA.gov> <3EDE4A38.3050405@rackable.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jun 2003, Samuel Flory wrote:

> Dan Christian wrote:
>
> >
> >"make mrproper" fixes it.
> >
> >For the record, I think this stinks!
> >
> >"make mrproper" should  be an expert only utility because it does blow
> >away valuable configuration information (a painfull lesson that can
> >only be learned "the hard way", since the README neglicts to mention
> >this).  For that matter, the README makes it look like creating a
> >config from scratch (all 1500+ options) is no big deal!
> >
> >
>
>   Most developers have a std config file that they simply copy over, and
> run "make oldconfig".  This is why menuconfig, and xconfig get broken
> every few patches.

Yes. I was expecting somebody to be a bit more 'direct'.

$ cd /usr/src/linux-whatever
$ cp .config ..
$ make mrproper
$ cp ../.config .
$ make oldconfig
$ make dep ; make bzImage ; make modules ; make modules_install

...trivial...

FYI, a <not recommended by many who have gotten burned> easy way to
make quick changes in the .config is to edit .config directly, then
execute `make oldconfig`. This usually works so you don't have to
answer a thousand questions.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

