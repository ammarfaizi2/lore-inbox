Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277629AbRJRJJ3>; Thu, 18 Oct 2001 05:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277633AbRJRJJK>; Thu, 18 Oct 2001 05:09:10 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:62307 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277629AbRJRJJE>; Thu, 18 Oct 2001 05:09:04 -0400
Date: Thu, 18 Oct 2001 11:09:14 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "3.5GB user address space" option.
Message-ID: <20011018110914.J12055@athlon.random>
In-Reply-To: <1981072193242.20011018021819@spylog.com> <9qlmcb$4h4$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <9qlmcb$4h4$1@cesium.transmeta.com>; from hpa@zytor.com on Wed, Oct 17, 2001 at 09:38:35PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2001 at 09:38:35PM -0700, H. Peter Anvin wrote:
> Followup to:  <1981072193242.20011018021819@spylog.com>
> By author:    "Oleg A. Yurlov" <kris@spylog.com>
> In newsgroup: linux.dev.kernel
> >
> > 
> >         Hi, folks,
> > 
> >         How  I  can  use  3.5GB  in my apps ? I try malloc() and get error on 2G
> > bounce... :-(
> > 
> >         Hardware - SMP server, 2Gb RAM, 8Gb swap, kernel 2.4.12aa1.
> > 
> 
> Get a 64-bit CPU.  You're running into a fundamental limit of 32-bit
> architectures.

Actually 3.5G per-process is theoretically possible using a careful
userspace as Rik suggested with -aa after enabling the proper
compile time configuration option. So for apps that needs say 3G
per-process it should work just fine. But of course for anything that
needs more than that 64bit is the right way to go :)

Andrea
