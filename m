Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbTIYE4g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 00:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbTIYE4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 00:56:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:6873 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261699AbTIYE4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 00:56:35 -0400
Date: Wed, 24 Sep 2003 21:56:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: rfc: test whether a device has a partition table
In-Reply-To: <Pine.LNX.4.44.0309242137090.1729-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0309242153100.1729-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Sep 2003, Linus Torvalds wrote:
> 
> And your random byte checks for power-of-2 make no sense. What are they
> based on?

Oh, I found the regular DOS bootsector layout. 

The thing is, that's FAT-specific. The BIOS doesn't care, and the old 
Linux boot-sector stuff never had that, for example. It has the 0xAA55 
flag, and that makes it bootable.

I bet the same is true of other bootsectors too, that either didn't know 
about the FAT version, or just needed the space for better things and knew 
the BIOS didn't care. And some of them might easily have powers-of-two 
values in those magic bytes.

		Linus

