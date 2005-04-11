Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVDKEbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVDKEbe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 00:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbVDKEbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 00:31:34 -0400
Received: from orb.pobox.com ([207.8.226.5]:50382 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261696AbVDKEbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 00:31:32 -0400
Date: Sun, 10 Apr 2005 21:31:24 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Pavel Machek <pavel@suse.cz>
Cc: "Barry K. Nathan" <barryn@pobox.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, hare@suse.de
Subject: Re: 2.6.12-rc2-mm1
Message-ID: <20050411043124.GA24626@ip68-4-98-123.oc.oc.cox.net>
References: <20050405141445.GA5170@ip68-4-98-123.oc.oc.cox.net> <20050405175600.644e2453.akpm@osdl.org> <20050406125958.GA8150@ip68-4-98-123.oc.oc.cox.net> <20050406142749.6065b836.akpm@osdl.org> <20050407030614.GA7583@ip68-4-98-123.oc.oc.cox.net> <20050408103327.GD1392@elf.ucw.cz> <20050410211808.GA12118@ip68-4-98-123.oc.oc.cox.net> <20050410212747.GB26316@elf.ucw.cz> <20050410225708.GB12118@ip68-4-98-123.oc.oc.cox.net> <20050410230053.GD12794@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050410230053.GD12794@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 01:00:53AM +0200, Pavel Machek wrote:
> > No, XFS is my root filesystem. :( (Now that I think about it, would
> > modularizing XFS and using an initrd be OK?)
> 
> Yes, loading xfs from initrd should help. [At least it did during
> suse9.3 testing.]

Once I modularized xfs and switched to using an initrd, the problem
disappeared.

I just noticed a difference between the kernel messages with XFS
built-in and with it modularized. I'm having trouble putting my finger
on it; it seems like the screen gets cleared at some point during
resume, and with XFS built-in, it starts reading the data from swap
*after* the screen gets cleared. In contrast, if the enable-initrd patch
is removed or XFS is modularized, it reads in from swap *before* the
screen gets cleared. Or something like that.

I'll see if I can get anything more detailed & useful with a serial
console... Failing that, I'll try a camcorder or digital camera and
transcribe from that.

-Barry K. Nathan <barryn@pobox.com>

