Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266366AbUGUALZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266366AbUGUALZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 20:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266370AbUGUALZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 20:11:25 -0400
Received: from berrymount.xs4all.nl ([82.92.47.16]:29279 "EHLO
	verdi.et.tudelft.nl") by vger.kernel.org with ESMTP id S266366AbUGUALY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 20:11:24 -0400
Date: Wed, 21 Jul 2004 02:10:57 +0200
From: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
To: bert hubert <ahu@ds9a.nl>
Cc: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>, shesha@inostor.com,
       linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: O_DIRECT
Message-Id: <20040721021057.76e98bf1.robn@verdi.et.tudelft.nl>
In-Reply-To: <20040720184824.GA30090@outpost.ds9a.nl>
References: <40FD561D.1010404@inostor.com>
	<20040720184824.GA30090@outpost.ds9a.nl>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jul 2004 20:48:24 +0200
bert hubert <ahu@ds9a.nl> wrote:

Hi Bert,

> On Tue, Jul 20, 2004 at 10:27:57AM -0700, Shesha Sreenivasamurthy wrote:
> > I am having trouble with O_DIRECT. Trying to read or write from a block 
> > device partition.
> > 
> > 1. Can O_DIRECT be used on a plain block device partition say 
> > "/dev/sda11" without having a filesystem on it.
> 
> As fas as I know, yes, but be aware that O_DIRECT requires page aligned
> addresses! (an integral of 4096 on most systems).

"soft block size" aligned.  The soft block size can be smaller than
a page (but not bigger).  There's a requirement for:

	- r/w offset
	- r/w size

	greetings,
	Rob van Nieuwkerk
