Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289301AbSAIJhm>; Wed, 9 Jan 2002 04:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289311AbSAIJhd>; Wed, 9 Jan 2002 04:37:33 -0500
Received: from mail.merconic.com ([62.96.220.180]:44700 "HELO
	mail.merconic.com") by vger.kernel.org with SMTP id <S289313AbSAIJh1>;
	Wed, 9 Jan 2002 04:37:27 -0500
Date: Wed, 9 Jan 2002 10:37:06 +0100
From: "marc. h." <heckmann@hbe.ca>
To: Andrew Morton <akpm@zip.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [problem captured] Re: cerberus on 2.4.17-rc2 UP
Message-ID: <20020109103659.C5453@hbe.ca>
In-Reply-To: <20020108164816.A5453@hbe.ca> <E16Nysp-0006tn-00@the-village.bc.nu> <3C3B579D.7B8E534F@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C3B579D.7B8E534F@zip.com.au>; from akpm@zip.com.au on Tue, Jan 08, 2002 at 12:33:33PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 12:33:33PM -0800, Andrew Morton wrote:
> Alan Cox wrote:
> > 
> > > end_request: buffer-list destroyed
> > > hda1: bad access: block=12440, count=-8
> > > end_request: I/O error, dev 03:01 (hda), sector 12440
> > > hda1: bad access: block=12448, count=-16
> > 
> > That looks like a race in the IDE/block layer (or somewhere above it maybe)
> > Someone trashed a request in progress.
> > 
> > Other people have reported it too. Its clearly a kernel race
> 
> Yes, I can generate it at will on two quite different IDE machines
> with the run-bash-shared-mapping script from
> http://www.zip.com.au/~akpm/ext3-tools.tar.gz

does this mean it's an ext3 bug? (haven't tried to reproduce it using ext2)

> It's on my list of things-to-do, filed under "hard".  It even happens
> on uniprocessor, with unmask_irq=0.

yes. my machine is UP and unmask_irq is 0.

> Interestingly, I _think_ it only ever occurs against the
> swap device.  But I need to confirm this.  Marc, do you
> have swap on /dev/hda1?

nope. hda1 is /.

-m

-- 
	C3C5 9226 3C03 CDF7 2EF1  029F 4CAD FBA4 F5ED 68EB
	key: http://people.hbesoftware.com/~heckmann/
