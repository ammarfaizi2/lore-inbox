Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312379AbSD1Rmd>; Sun, 28 Apr 2002 13:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313578AbSD1Rmc>; Sun, 28 Apr 2002 13:42:32 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:54981 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S312379AbSD1Rma>; Sun, 28 Apr 2002 13:42:30 -0400
Date: Sun, 28 Apr 2002 13:42:30 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: How far has initramfs got ?
Message-ID: <20020428174230.GE18102@ravel.coda.cs.cmu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <171nLP-1WyTImC@fwd09.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2002 at 04:00:16PM +0200, Christian Koenig wrote:
> How far have the initramfs stuff got ? Is there any code yet ?
> I have implementet some very very simple cpio image extraction in 
> init/do_mounts.c and want to know if this could be usefull to somebody. 
> 
> Should it be possible to use initramfs without the ramdisk driver compiled in?

I would like to add that perhaps using tmpfs instead of ramfs would be
a nice touch. As the initial ramfs would get overmounted instead of
unmounted, this allows the contents of the initial fs to get swapped
out instead of either taking up memory indefinitely.

Also isn't tmpfs already compiled into the kernel by default to support
shared memory and such?

Jan

