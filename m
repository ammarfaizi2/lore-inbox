Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265429AbTFMQPt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 12:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265430AbTFMQPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 12:15:49 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:42506
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S265429AbTFMQPn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 12:15:43 -0400
Subject: Re: Cisco Aironet mini-PCI wireless card (MPI-350) [Was: Re: Intel
	PRO/Wireless 2100 vs. Broadcom BCM9430x]
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Jan Mynarik <mynarikj@phoenix.inf.upol.cz>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <1055501888.1452.13.camel@narsil>
References: <Pine.LNX.4.44.0306120813380.411-100000@twin.uoregon.edu>
	 <1055438410.930.15.camel@narsil>
	 <1055439997.10219.54.camel@ixodes.goop.org>
	 <1055501888.1452.13.camel@narsil>
Content-Type: text/plain
Message-Id: <1055521768.28464.12.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 13 Jun 2003 09:29:29 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-06-13 at 03:58, Jan Mynarik wrote:
> the patch worked well in the meaning of possible module insertion. But I
> wasn't able to configure the card with ACU well.
> 
> With older firmware it's possible to insert module and to configure it
> with ACU, but I'm not able to configure the card well. The whole
> password menu produces segmentation fault :-))
> 
> Is there any other way how to configure this card? Unfortunately it
> doesn't support wireless extensions.

I used ACU/bcard, but it was fairly fiddly.  I kept finding that
changing a setting would make the card go into a strange state which was
unrecoverable, even by unloading/reloading the module.  Only rebooting
would fix it.  Eventually I managed to get everything configured, and I
just get modprobe to run bcard after loading the module to configure the
card.  This seems to work reliably so long as I avoid doing any other
settings with acu (

I've been doing some work to extend airo.c to support the 350, based on
Ben Reed's start.  Unfortunately the card gets into state just keeps
misbehaving and reports errors, but without any documentation its hard
to work out what's going wrong.  I'm hoping Cisco will see fit to
release some documentation (or at least a new driver) - particularly
since it seems the number of mpi350 Linux users is increasing, driven
into Cisco's arm by Intel and Broadcom's complete documentation void.

	J

