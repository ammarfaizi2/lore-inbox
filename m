Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263953AbTFVXRA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 19:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263973AbTFVXQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 19:16:59 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:35624 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263953AbTFVXQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 19:16:59 -0400
Date: Sun, 22 Jun 2003 16:31:32 -0700
From: Andrew Morton <akpm@digeo.com>
To: Greg KH <greg@kroah.com>
Cc: agoddard@purdue.edu, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.73
Message-Id: <20030622163132.2f7145b7.akpm@digeo.com>
In-Reply-To: <20030622225352.GA3319@kroah.com>
References: <Pine.LNX.4.44.0306221150440.17823-100000@old-penguin.transmeta.com>
	<Pine.LNX.4.56.0306221453010.1455@dust>
	<20030622131526.0dbb39d0.akpm@digeo.com>
	<20030622225352.GA3319@kroah.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jun 2003 23:31:04.0552 (UTC) FILETIME=[5939A680:01C33916]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> On Sun, Jun 22, 2003 at 01:15:26PM -0700, Andrew Morton wrote:
> > Alex Goddard <agoddard@purdue.edu> wrote:
> > >
> > > drivers/usb/host/ehci-hcd.c:977: error: pci_ids causes a section type 
> > > conflict
> > 
> > 
> > Yup.
> > 
> > __devinitdata declarations should not be marked const.
> 
> Did anyone ever figure out why this is true?
> 

The compiler seems to have decided that we're putting R/O data into an R/W
section.

