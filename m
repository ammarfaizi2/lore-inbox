Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271362AbTG2Jgw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 05:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271367AbTG2Jgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 05:36:31 -0400
Received: from dsl-217-155-102-250.zen.co.uk ([217.155.102.250]:51948 "EHLO
	smithers.xal") by vger.kernel.org with ESMTP id S271362AbTG2JeP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 05:34:15 -0400
Date: Tue, 29 Jul 2003 10:34:09 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS 2.6.0-test2, modprobe i810fb
Message-ID: <20030729093409.GA779@xal.co.uk>
References: <20030728171806.GA1860@xal.co.uk> <20030728201954.A16103@xmission.xmission.com> <20030728202600.18338fa9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030728202600.18338fa9.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
From: Pavel Rabel <pavel@xal.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Applied the patch, no OOPSing now, thanks.

Pavel

On Mon, Jul 28, 2003 at 08:26:00PM -0700, Andrew Morton wrote:
> "S. Anderson" <sa@xmission.com> wrote:
> >
> > On Mon, Jul 28, 2003 at 06:18:07PM +0100, Pavel Rabel wrote:
> > > Got this OOPS when trying "modprobe i810fb",
> > > kernel 2.6.0-test2
> > > 
> > 
> > I am also getting this oops, or somthing very simmillar.
> 
> yay!  I finally fixed a bug! (sheesh, bad day).
> 
> The device table is not null-terminated so we run off the end during
> matching and go oops.
> 
> I also moved all the statics out of i810_main.h and into i810_main.c. 
> There is not a lot of point putting them in a header file: if any other .c
> file includes the header we get multiple private instantiatiations of
> all that stuff.

