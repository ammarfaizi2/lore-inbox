Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131758AbRCVE6g>; Wed, 21 Mar 2001 23:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131799AbRCVE61>; Wed, 21 Mar 2001 23:58:27 -0500
Received: from samar.sasken.com ([164.164.56.2]:52105 "EHLO samar.sasi.com")
	by vger.kernel.org with ESMTP id <S131758AbRCVE6L>;
	Wed, 21 Mar 2001 23:58:11 -0500
Date: Thu, 22 Mar 2001 14:59:31 +0530 (IST)
From: Manoj Sontakke <manojs@sasken.com>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: initialisation code 
In-Reply-To: <24505.985174674@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.21.0103221453140.1382-100000@pcc65.sasi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
	Thanks for all the help.

On Wed, 21 Mar 2001, Keith Owens wrote:

> On Wed, 21 Mar 2001 22:00:51 +0530 (IST), 
> Manoj Sontakke <manojs@sasken.com> wrote:
> >	I have a initlisation function (just like pktsched_init in
> >TC). Can anyone tell me, where in the kernel boot sequence should I make a
> >call to my initialisation function.
> 
> Welcome to the wonderful world of magic initialisation.
> 
> (1) Declare your initialisation function as int __init foo_init(void).
> 
> (2) Decide when your function needs to be called, e.g. after initialisers
>     for A, B, C but before initialisers for X, Y, Z.

where do i find this ABC abs XYZ ?
What if I have to make it as an insertable/removable module?

> 
> (3) Edit the Makefile to insert obj-$(CONFIG_FOO) after the objects
>     that contain initialisers A, B, C and before the objects for
>     initialisers X, Y, Z.

Do I need to edit the .config file to add CONFIG_FOO=y ?

> 
> (4) Document why the order of this routine is required!  Without docs
>     in the Makefile we have no idea if object order is correct or not.
> 
of course

manojs

