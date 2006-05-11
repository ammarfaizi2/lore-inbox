Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751554AbWEKQ0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbWEKQ0J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 12:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbWEKQ0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 12:26:09 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:23962 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751554AbWEKQ0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 12:26:08 -0400
Date: Thu, 11 May 2006 12:26:06 -0400
To: Carlos Ojea Castro <nuudoo.fb@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: geode sc1200 2D graphics acceleration
Message-ID: <20060511162606.GB2837@csclub.uwaterloo.ca>
References: <bae323a50605110626v196bf76cj5fa3d63fe7d789a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bae323a50605110626v196bf76cj5fa3d63fe7d789a0@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2006 at 03:26:14PM +0200, Carlos Ojea Castro wrote:
> I am drawing some graphics (a group of lines) using DirectFb in a
> geode sc1200 (kernel 2.4).
> I discovered that when I disable 2D hardware acceleration (by changing
> '/root/.directfbrc' and '/etc/directfbrc') it is FASTER than drawing
> with 2D hardware acceleration enabled.
> 
> Can't figure why. Any ideas?

Could it be related to the video on the sc1200 being emulated by SMI (at
least as far as I understand things)?  Perhaps the acceleration simply
makes the BIOS/SMI stuff go do all the work, while with no acceleration,
the kernel writes all the bits directly, which is more efficient than
the BIOS/SMI emulation?  I think that is how the VSA stuff works on
those systems at least.  I have VGA disabled on the boards I use here,
so all I know is that the video is very slow on these systems when I
tried it once, and since I don't have a use for it, I disabled it.

Len Sorensen
