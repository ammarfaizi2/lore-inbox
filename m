Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315253AbSEDXea>; Sat, 4 May 2002 19:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315255AbSEDXe3>; Sat, 4 May 2002 19:34:29 -0400
Received: from CPE-203-51-25-114.nsw.bigpond.net.au ([203.51.25.114]:23543
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S315253AbSEDXe2>; Sat, 4 May 2002 19:34:28 -0400
Message-ID: <3CD47001.4DF960D2@eyal.emu.id.au>
Date: Sun, 05 May 2002 09:34:25 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa2
In-Reply-To: <20020504165440.C1260@dualathlon.random> <20020504160235.A14926@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> On Sat, May 04, 2002 at 04:54:40PM +0200, Andrea Arcangeli wrote:
> > Only in 2.4.19pre8aa2: 00_comx-driver-compile-1
> >
> >       Export proc_get_inode for kernel/drivers/net/wan/comx.o so
> >       it can link as a module, noticed by Eyal Lebedinsky.
> 
> Don't do this - proc_get_inode is static for a reason and doing this
> export in the SuSE tree for ages doesn't make it any better.
> 
> The driver needs serious fixing instead.

I agree with this. However, since this driver cannot be built, and
since the latest modutils will exit badly for unresolved, I strongly
believe that the comx driver should not be offered (disable it in
the Config.in) until it is fixed - 2.4 being a stable kernel.

I had to wrap 'depmod' with a script to ignore failures in order
to get through a full build (which includes the kernel plus a few
extra modules like NVdriver, dc395, lm_sensors).

We have already been through this argument before, it is now up to
Marcelo to decide on the policy here.


--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
