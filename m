Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266303AbUFZQcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266303AbUFZQcs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 12:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266304AbUFZQcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 12:32:48 -0400
Received: from diane.island.net ([199.60.19.9]:42176 "EHLO diane.island.net")
	by vger.kernel.org with ESMTP id S266303AbUFZQcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 12:32:45 -0400
Message-ID: <1088267564.40dda52cc629a@webmail.island.net>
Date: Sat, 26 Jun 2004 09:32:44 -0700
From: andyb@island.net
To: linux-kernel@vger.kernel.org
Cc: aebr@win.tue.nl
Subject: Re: [BUG 2.6.7] : Partition table display bogus...
References: <1088216934.40dcdf66edd1d@webmail.island.net> <20040626104455.GC5526@pclin040.win.tue.nl>
In-Reply-To: <20040626104455.GC5526@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 207.81.95.65
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Using
fdisk v2.11u

displays the partition table for the drive that the kernel claims has an unknown
partition table.  The bootable flag indicator is neither blank nor an *;  instead it
was the ? character.  Toggling the bootable flag in fdisk (bringing up the * ) and
writing the changed partition table allowed the booting kernel to then read
the partition table.   This partition table has not been touched for many a kernel
version and has been identified by all the previous kernels, through 2.6.6.
Would the change that stopped the kernel from "guessing" the disk geometry have
brought out the sensitivity to whatever was not correct with the PT?


Quoting Andries Brouwer :

> Check whether you can read that disk using dd.
> Check that fdisk still can read the table on that disk.
> Go back to 2.6.6 and check that the pt table is still OK.
> Check what type it is, and that your 2.6.7 kernel still has
> configured that type.
> 


