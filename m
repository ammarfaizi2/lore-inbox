Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286411AbSBCH0s>; Sun, 3 Feb 2002 02:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286413AbSBCH0j>; Sun, 3 Feb 2002 02:26:39 -0500
Received: from ns.suse.de ([213.95.15.193]:53509 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S286411AbSBCH03>;
	Sun, 3 Feb 2002 02:26:29 -0500
To: Jeff Garzik <garzik@havoc.gtf.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT fails in some kernel and FS
In-Reply-To: <E16WkQj-0005By-00@antoli.uib.es.suse.lists.linux.kernel> <3C5AFE2D.95A3C02E@zip.com.au.suse.lists.linux.kernel> <1012597538.26363.443.camel@jen.americas.sgi.com.suse.lists.linux.kernel> <20020202093554.GA7207@tapu.f00f.org.suse.lists.linux.kernel> <234710000.1012674008@tiny.suse.lists.linux.kernel> <20020202205438.D3807@athlon.random.suse.lists.linux.kernel> <242700000.1012680610@tiny.suse.lists.linux.kernel> <3C5C4929.5080403@sgi.com.suse.lists.linux.kernel> <20020202155028.B26147@havoc.gtf.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 03 Feb 2002 08:26:28 +0100
In-Reply-To: Jeff Garzik's message of "2 Feb 2002 21:54:34 +0100"
Message-ID: <p737kpvauvv.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <garzik@havoc.gtf.org> writes:

> On Sat, Feb 02, 2002 at 02:16:41PM -0600, Stephen Lord wrote:
> > Can't you fall back to buffered I/O for the tail? OK it complicates the
> > code, probably a lot, but it keeps things sane from the user's point of
> > view.
> 
> For O_DIRECT, IMHO you should fail not fallback.  You're simply lying
> to the underlying program otherwise.

It's just impossible to write a tail which is smaller than a disk block
without another buffer. 

-Andi
