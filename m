Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265047AbUF1QBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265047AbUF1QBu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 12:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUF1QBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 12:01:50 -0400
Received: from ida.rowland.org ([192.131.102.52]:15876 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S265047AbUF1QBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 12:01:48 -0400
Date: Mon, 28 Jun 2004 12:01:48 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Pete Zaitcev <zaitcev@redhat.com>
cc: Oliver Neukum <oliver@neukum.org>, Andries Brouwer <aebr@win.tue.nl>,
       <greg@kroah.com>, <arjanv@redhat.com>, <jgarzik@redhat.com>,
       <tburke@redhat.com>, <linux-kernel@vger.kernel.org>,
       <mdharm-usb@one-eyed-alien.net>, <david-b@pacbell.net>
Subject: Re: drivers/block/ub.c
In-Reply-To: <20040627171044.052a67c6@lembas.zaitcev.lan>
Message-ID: <Pine.LNX.4.44L0.0406281156500.1598-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jun 2004, Pete Zaitcev wrote:

> This is very nice and would be a great help for Infiniband developers.
> However, parts of SCSI commands are not defined in terms of C structures
> or even 32 bit words with an endianness. They are streams of bytes, at
> least historically. Please kindly refer to the WRITE(6) command for
> the evidence. You'd need put_be20() to form that block address. :-)

About 13 years ago I wrote a data analysis program for an NMR spectrometer
that stored its output as 24-bit integers!  Yes, one does encounter weird
things from time to time.  Still, having the functions I mentioned would 
be very handy in the majority of cases.  They remove several 
possibilities for error (getting the bit shifts wrong, getting the array 
indexes wrong, associating the right bit shift with the wrong index).

> I write these byte marshalling sequences since 1985 and I'm a little
> used to them. I do not recall thinking twice about writing that element
> of ub. It probably doesn't deserve all the tempest Oliver raised over it.

Andries too.

Alan Stern

