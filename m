Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265851AbTAJRcI>; Fri, 10 Jan 2003 12:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265854AbTAJRcH>; Fri, 10 Jan 2003 12:32:07 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:28954 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S265851AbTAJRcH>;
	Fri, 10 Jan 2003 12:32:07 -0500
Date: Fri, 10 Jan 2003 18:40:51 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: John Bradford <john@grabjohn.com>, ludovic.drolez@freealter.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BLKBSZSET still not working on 2.4.18 ?
Message-ID: <20030110174051.GB19942@win.tue.nl>
References: <200301101708.h0AH8nUS013550@darkstar.example.net> <1042222490.32175.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042222490.32175.5.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 06:14:51PM +0000, Alan Cox wrote:

> On Fri, 2003-01-10 at 17:08, John Bradford wrote:
> > Didn't some really obscure IBM drives use it for something internally,
> > and shortly after everybody else had to stop using it incase they
> > overwrote the custom data at the end of an IBM disk, or am I thinking
> > of something else?

> Something else - EFI uses the last sector for partitioning as one example.
> Drives do have protected private areas but they are shielded from normal
> use for obvious reasons

There is also a much older matter. In the distant past IBM used the
last cylinder for testing. That means that many FDISK versions and many
BIOSes subtract one from the number of available cylinders.
There are several ways to ask the BIOS for the size of a disk,
and some of these calls may invoke others, and then subtract one.
I have seen disks that had lost three cylinders that way.

Andries
