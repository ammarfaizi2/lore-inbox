Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271691AbRHUOU0>; Tue, 21 Aug 2001 10:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271692AbRHUOUQ>; Tue, 21 Aug 2001 10:20:16 -0400
Received: from dialin-212-144-150-099.arcor-ip.net ([212.144.150.99]:48112
	"EHLO merv") by vger.kernel.org with ESMTP id <S271691AbRHUOUF>;
	Tue, 21 Aug 2001 10:20:05 -0400
Date: Tue, 21 Aug 2001 16:19:01 +0200
From: Andreas Bombe <andreas.bombe@munich.netsurf.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ext2 not NULLing deleted files?
Message-ID: <20010821161901.B1158@bombe.modem.informatik.tu-muenchen.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010817020241.C32617@turbolinux.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2001 at 02:02:41AM -0600, Andreas Dilger wrote:
> 3) This is easily implemented in user-space, either by aliasing "rm" to
>    a new function, or actually putting in your own "rm" binary which
>    checks for the "S" attribute on ext2 files, and overwrites properly
>    it if it a file only has a single link.  Then people can implement a
>    level of security they are comfortable with for their particular needs.

Bad, the file may still be open and in use.  So this rm would 1) destroy
work data and 2) leave the data in clear that are written after the
sweep.

-- 
Andreas E. Bombe <andreas.bombe@munich.netsurf.de>    DSA key 0x04880A44
