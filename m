Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269112AbUJQNRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269112AbUJQNRM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 09:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269116AbUJQNRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 09:17:12 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:59273 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S269112AbUJQNRG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 09:17:06 -0400
From: Glenn Burkhardt <gbburkhardt@verizon.net>
Reply-To: glenn@aoi-industries.com
To: Matt Porter <mporter@kernel.crashing.org>
Subject: Re: remap_page_range64() for PPC
Date: Sun, 17 Oct 2004 09:17:04 -0400
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <20041016034642.F1DD0C60D@aoi-industries.com> <20041015233226.B1500@home.com>
In-Reply-To: <20041015233226.B1500@home.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410170917.04673.gbburkhardt@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [68.163.131.2] at Sun, 17 Oct 2004 08:17:05 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 October 2004 02:32 am, Matt Porter wrote:
> On Fri, Oct 15, 2004 at 11:46:42PM -0400, Glenn Burkhardt wrote:
> > I'm writing an application to run on a PowerPC with a 2.4 embedded
> > Linux kernel, and I want to make device registers for our custom
> > hardware accessable from user space with mmap().  The physical address
> > of the device is above the 4gb boundary (we attach to the 440's
> > external peripheral bus), so a standard 'remap_page_range()' call
> > won't work.
>
> <snip>
>
> This has come up several times on the ppc lists (but since we still
> don't have archives back, nobody can search anyway). I dropped
                                                                                             ^^^^^^
> 2.4 and 2.5 patches in source.mvista.com:/pub/linuxppc/ a long
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> time ago.  You just need to update your board-specific fixup routine
> in that version or just make a copy or remap_page_range() into your
> driver and use u64 for the phys address.

Do you mean that you applied a patch, or had one and decided not to 
use it?  I just looked at mm/memory.c didn't notice anything 
substantially different in remap_page_range().  To which module was 
the patch applied?

Thanks for verifying that the approach I took was correct, which was
to use u64 for the phys address for remap_page_range().

