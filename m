Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263278AbTCNHjt>; Fri, 14 Mar 2003 02:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263277AbTCNHjs>; Fri, 14 Mar 2003 02:39:48 -0500
Received: from angband.namesys.com ([212.16.7.85]:5002 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S263273AbTCNHjs>; Fri, 14 Mar 2003 02:39:48 -0500
Date: Fri, 14 Mar 2003 10:50:32 +0300
From: Oleg Drokin <green@namesys.com>
To: Oleg Drokin <green@linuxhacker.ru>, alan@redhat.com,
       linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: [2.4] init/do_mounts.c::rd_load_image() memleak
Message-ID: <20030314105032.A17568@namesys.com>
References: <20030313210144.GA3542@linuxhacker.ru> <20030313220308.A28040@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030313220308.A28040@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Mar 13, 2003 at 10:03:08PM +0000, Russell King wrote:

> > +	if (buf)
> > +		kfree(buf);
> kfree(NULL); is valid - you don't need this check.

Almost every place I can think of does just this, so I do not see why this
particular piece of code should be different.

Bye,
    Oleg
