Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292250AbSBBIJJ>; Sat, 2 Feb 2002 03:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292249AbSBBIJB>; Sat, 2 Feb 2002 03:09:01 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:3506 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S292247AbSBBIIt>;
	Sat, 2 Feb 2002 03:08:49 -0500
Date: Sat, 2 Feb 2002 03:08:47 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@zip.com.au>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "David S. Miller" <davem@redhat.com>, vandrove@vc.cvut.cz,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org, paulus@samba.org,
        davidm@hpl.hp.com, ralf@gnu.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
Message-ID: <20020202030847.D20865@havoc.gtf.org>
In-Reply-To: <20020131.145904.41634460.davem@redhat.com> <E16WQYs-0003Ux-00@the-village.bc.nu> <20020202021242.GA6770@tapu.f00f.org> <3C5B56A4.B762948F@zip.com.au> <20020202073020.GA7014@tapu.f00f.org> <20020202024236.B17031@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020202024236.B17031@nevyn.them.org>; from dan@debian.org on Sat, Feb 02, 2002 at 02:42:36AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2002 at 02:42:36AM -0500, Daniel Jacobowitz wrote:
> One piece of the necessary compiler help would be -ffunction-sections. 
> If they are in the same section in the same object file, they simply
> can not be removed safely.

Such as the patch that was mentioned earlier in this thread :)


> Relocation information for calls to local
> functions is not reliably available at link time.

With a smarter toolchain it could be.

One will need a smarter toolchain in order to re-order functions
anyway, which is an area where benchmarks on other compilers are
showing benefits.  (ie. moving "cold" functions to the end of the
module, given profiling feedback)

	Jeff



