Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292248AbSBBIGj>; Sat, 2 Feb 2002 03:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292247AbSBBIG3>; Sat, 2 Feb 2002 03:06:29 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:63665 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S292248AbSBBIGW>;
	Sat, 2 Feb 2002 03:06:22 -0500
Date: Sat, 2 Feb 2002 03:06:20 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: Andrew Morton <akpm@zip.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "David S. Miller" <davem@redhat.com>, vandrove@vc.cvut.cz,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org, paulus@samba.org,
        davidm@hpl.hp.com, ralf@gnu.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
Message-ID: <20020202030620.C20865@havoc.gtf.org>
In-Reply-To: <20020131.145904.41634460.davem@redhat.com> <E16WQYs-0003Ux-00@the-village.bc.nu> <20020202021242.GA6770@tapu.f00f.org> <3C5B56A4.B762948F@zip.com.au> <20020202073020.GA7014@tapu.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020202073020.GA7014@tapu.f00f.org>; from cw@f00f.org on Fri, Feb 01, 2002 at 11:30:20PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 11:30:20PM -0800, Chris Wedgwood wrote:
> A really smart linker (if given enough compiler help) could build a
> directional graph and still remove this code even if blem called foo.

Agreed and this has been my objection to the function-sections patch.
There is no need for it if you make the toolchain smarter.

For example I would love to see a !CONFIG_MODULES build rip out all the
code that was not actively referenced, such as EXPORT_SYMBOL functions
which are never called.

	Jeff



