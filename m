Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291267AbSBGUZO>; Thu, 7 Feb 2002 15:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291274AbSBGUZE>; Thu, 7 Feb 2002 15:25:04 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:37552 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S291267AbSBGUYy>;
	Thu, 7 Feb 2002 15:24:54 -0500
Date: Thu, 7 Feb 2002 21:24:52 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix floppy io ports reservation
Message-ID: <20020207202452.GA1527@win.tue.nl>
In-Reply-To: <E16Yevs-00054g-00@libra.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16Yevs-00054g-00@libra.cus.cam.ac.uk>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 03:09:08AM +0000, Anton Altaparmakov wrote:

> Below is a patch that fixes the io ports reservation of the floppy driver
> as the one in the driver is actually incorrect and this clashes with the
> (correct) reservation by the PNPBIOS driver.
> 
> I asked a friend to check and on his Windows 2000 system the port
> reservation was 0x3f2-0x3f5 + 0x3f7, i.e. it just excludes ports
> 0x3f0-0x3f1, which are NOT used anywhere in the driver anyway.

ports 0x3f0 and 0x3f1 are used on certain PS/2 systems
and on some very old AT clones
