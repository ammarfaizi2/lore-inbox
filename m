Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263267AbTCNHxi>; Fri, 14 Mar 2003 02:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263268AbTCNHxh>; Fri, 14 Mar 2003 02:53:37 -0500
Received: from angband.namesys.com ([212.16.7.85]:9866 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S263267AbTCNHxh>; Fri, 14 Mar 2003 02:53:37 -0500
Date: Fri, 14 Mar 2003 11:04:21 +0300
From: Oleg Drokin <green@namesys.com>
To: Jens Axboe <axboe@suse.de>
Cc: Oleg Drokin <green@linuxhacker.ru>, alan@redhat.com,
       linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: [2.4] init/do_mounts.c::rd_load_image() memleak
Message-ID: <20030314110421.A28273@namesys.com>
References: <20030313210144.GA3542@linuxhacker.ru> <20030313220308.A28040@flint.arm.linux.org.uk> <20030314105032.A17568@namesys.com> <20030314075957.GX836@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030314075957.GX836@suse.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Mar 14, 2003 at 08:59:57AM +0100, Jens Axboe wrote:

> > > > +	if (buf)
> > > > +		kfree(buf);
> > > kfree(NULL); is valid - you don't need this check.
> > Almost every place I can think of does just this, so I do not see why this
> > particular piece of code should be different.
> Since when has that been a valid argument? :)

Well, my argument is code uniformness which was always valid as long as it does not
introduce any bugs, I think.
Do you propose somebody should go and fix all
if ( something )
	kfree(something);
pieces of code to read just
kfree(something); ?

Bye,
    Oleg
