Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262922AbREaAWe>; Wed, 30 May 2001 20:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262923AbREaAWY>; Wed, 30 May 2001 20:22:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54796 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262922AbREaAWM>;
	Wed, 30 May 2001 20:22:12 -0400
Date: Thu, 31 May 2001 01:22:10 +0100
From: Joel Becker <jlbec@evilplan.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to know HZ from userspace?
Message-ID: <20010531012210.I16761@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010530203725.H27719@corellia.laforge.distro.conectiva> <9f41vq$our$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9f41vq$our$1@cesium.transmeta.com>; from hpa@zytor.com on Wed, May 30, 2001 at 05:07:22PM -0700
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2001 at 05:07:22PM -0700, H. Peter Anvin wrote:
> Followup to:  <20010530203725.H27719@corellia.laforge.distro.conectiva>
> By author:    Harald Welte <laforge@gnumonks.org>
> In newsgroup: linux.dev.kernel
> > Is there any way to read out the compile-time HZ value of the kernel?
> 
> Yes, but that's because the interfaces are broken.  The decision has
> been that these values should be exported using the default HZ for the
> architecture, and that it is the kernel's responsibility to scale them
> when HZ != USER_HZ.  I don't know if any work has been done in this
> area.

	Pardon, but that still seems broken to me.  USER_HZ shouldn't
matter to the architecture either.  I would think that if
'echo 10 > /proc/foo/icmp_foo' sets a timeout of 10ms on alpha, it
should also do so on x86, sparc, and mips.  Why should the userspace
implementation *ever* have to know the 'architecture HZ', the 'real HZ'
or anything of the kind?

Joel

-- 

"I'm drifting and drifting
 Just like a ship out on the sea.
 Cause I ain't got nobody, baby,
 In this world to care for me."

			http://www.jlbec.org/
			jlbec@evilplan.org
