Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262729AbVAQJIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbVAQJIi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 04:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262735AbVAQJIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 04:08:37 -0500
Received: from mail.suse.de ([195.135.220.2]:45446 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262729AbVAQJHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 04:07:51 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16875.32871.47983.655764@xf14.local>
Date: Mon, 17 Jan 2005 10:07:51 +0100
From: Egbert Eich <eich@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Egbert Eich <eich@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: vgacon fixes to help font restauration in X11
In-Reply-To: alan@lxorguk.ukuu.org.uk wrote on Saturday, 15 January 2005 at 00:33:44 +0000 
References: <16867.58009.828782.164427@xf14.fra.suse.de>
	<1105745463.9839.55.camel@localhost.localdomain>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please leave me in Cc: as I'm not subscribed to this list]

Alan Cox writes:
 > On Maw, 2005-01-11 at 14:28, Egbert Eich wrote:
 > > I'm fully aware that in the long run we will need to look into a new 
 > > driver model for graphics where no two instances fight over who gets
 > > register access. However such a model won't be created nor will we get 
 > > the majority of the drivers ported over night.
 > > Therefore we need to find an interim solution for the most pressing 
 > > problems.
 > 
 > This doesn't appear to work as a solution because the functionality
 > changes won't be in all the existing kernel, and also because the kernel
 > font save has a couple of bugs reported against it with regards to
 > saving the right data that might need looking at anyway.

Can you point me to these reports?
I tested with a couple chipsets here and didn't find any problems.

Maybe we can compare the code in X with the code in the kernel
for the amount of data to save.
However we don't know if the X font code is completely without
problems. I remeber fixing a problem in X years ago - a case
where the kernel got it right ;-)
X VGA font code involves a lot of magic. Also things might differ
slightly form HW vendor to vendor and it will be extremely hard
to get it right for all chipset models therefore I would not even 
talk about 'bugs' ;-)

 > 
 > It seems it would be neccessary for X to have a way to know whether the
 > feature is present.
 > 

We could check for the kernel version. This could be done during build
time - assuming we don't ship generic binaries or during run time if we
want to provide binaries that work everywhere.
In reality the former would be sufficient for a lot of cases - especially
for vendor supplied binaries.
Once X.Org starts shipping binaries it should definitely provide a version
that fits everywhere.
But maybe you have a better suggestion.

Anyway, would my patch be acceptable for the kernel?

Cheers,
	Egbert.
