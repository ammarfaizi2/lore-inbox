Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbUANQwP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 11:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbUANQvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 11:51:08 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:27384 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S261928AbUANQvB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 11:51:01 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: John Lash <jkl@sarvega.com>, Michael Lothian <s0095670@sms.ed.ac.uk>
Subject: Re: Catch 22
Date: Wed, 14 Jan 2004 10:50:32 -0600
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
References: <400554C3.4060600@sms.ed.ac.uk> <20040114090137.5586a08c.jkl@sarvega.com>
In-Reply-To: <20040114090137.5586a08c.jkl@sarvega.com>
MIME-Version: 1.0
Message-Id: <04011410503200.32256@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 January 2004 09:01, John Lash wrote:
> On Wed, 14 Jan 2004 14:40:03 +0000
>
> Michael Lothian <s0095670@sms.ed.ac.uk> wrote:
> > Just thaought I'd let you know about my experiences with Mandrake using
> > the 2.4 and 2.6 kernels on my new hardware which is primaraly a Asus
> > A7V600 (KT600) Motherboard and Radeon 9600XT
> >
> > Under 2.4 my ATA hard drak is mounted under /dev/hda where as under 2.6
> > is /dev/hde so there is no wasy way to switch between them with lilo and
> > /etc/fstab needing to be changed
>
> At least in this case, you should be able to use volume labels for the
> filesystems instead of the actual device names. Check out tune2fs -L. You
> then reference the volume label in your fstab.
>
> With lilo, you can specify that boot disk and root disk on the command
> line. Also you can point lilo to a different config file using lilo -C. Not
> seamless but should allow you to bounce back and forth w/o editing
> files....
>
> Sorry, I'm not familiar with the rest.....

Also you can use a MBR lilo that only boots one or more partitions, then
have Lilo installed on each partition to select a specific kernel related
to that particular partition. This way you no longer have to update a
single point of failure - only update the lilo configuration on a specific
partition when changes are needed.

You avoid altering the MBR and the other partition.
