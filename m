Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271086AbTGQPuo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 11:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271108AbTGQPuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 11:50:44 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:34062 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S271086AbTGQPsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 11:48:35 -0400
Date: Thu, 17 Jul 2003 18:03:28 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Walt H <waltabbyh@comcast.net>,
       arjanv@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davzaffiro@tasking.nl
Subject: Re: [PATCH] pdcraid and weird IDE geometry
Message-ID: <20030717180328.A2467@pclin040.win.tue.nl>
References: <3F160965.7060403@comcast.net> <1058431742.5775.0.camel@laptop.fenrus.com> <3F16B49E.8070901@comcast.net> <1058453918.9055.12.camel@dhcp22.swansea.linux.org.uk> <3F16C1F3.40206@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F16C1F3.40206@pobox.com>; from jgarzik@pobox.com on Thu, Jul 17, 2003 at 11:34:11AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 11:34:11AM -0400, Jeff Garzik wrote:

> Can't you fix the geometry from fdisk expert mode?
> 
> I've done that several times before, when otherwise like-sized disks 
> appeared with vastly different geometry.

It is easiest to think that it is meaningless what you say
(in this case). A disk does not have a geometry, and
moreover you cannot change it with fdisk.

However, under some circumstances, some kernels will guess
a (translated) geometry from a DOS-type partition table,
so it is true that under some kernel versions you can use
fdisk to change the kernel's ideas about disk geometry.
A very fragile activity.

[Moreover, there are several kinds of geometry, and the present
authors of ide-disk.c conveniently confused them all.
Concerning pdcraid, I don't know for which of the possible
ideas of geometry it is true that one needs the first sector
of the last cylinder.]

Andries

