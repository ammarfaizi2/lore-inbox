Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271622AbSKECOo>; Mon, 4 Nov 2002 21:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271630AbSKECOo>; Mon, 4 Nov 2002 21:14:44 -0500
Received: from dhcp024-209-039-058.neo.rr.com ([24.209.39.58]:12418 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S271622AbSKECOl>;
	Mon, 4 Nov 2002 21:14:41 -0500
Date: Mon, 4 Nov 2002 21:24:44 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: CaT <cat@zip.com.au>
Cc: greg@kroah.com, linux@brodo.de, Tamagucci@libero.it,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.5.45 / boottime oops (pnp bios I think)
Message-ID: <20021104212444.GH316@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, CaT <cat@zip.com.au>,
	greg@kroah.com, linux@brodo.de, Tamagucci@libero.it,
	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
References: <20021104025458.GA3088@zip.com.au> <20021104161504.GA316@neo.rr.com> <20021104235408.GA627@zip.com.au> <20021104202800.GD316@neo.rr.com> <20021105020630.GA644@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021105020630.GA644@zip.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 01:06:30PM +1100, CaT wrote:
> On Mon, Nov 04, 2002 at 08:28:00PM +0000, Adam Belay wrote:
> > occured when the pnp bios protocol reached node 0x13.  This node, pnp id
> > PNP0f13, is of course a standard mouse port.  If you look at the output of 
> > lspnp for my system, the following can be seen.
> > 
> > 12 PNP0f13 input device: mouse
> >     flags: [no disable] [no config] [static]
> >     allocated resources:
> > 	irq 12 [high edge]
>
> Mine is #13 (ie the first line reads 13 PNP0f13...)
>
> > Please feel free to send any questions or comments.  The patch is below.
>
> The patch lets me boot just fine. (Woo) One hassle though, doing
> lspci -v 13 or cat /proc/bus/pnp/13 causes an oops. I presume it's the
> same deal as what you were talking about?
>

Oops, I forgot to fix the pnpbios proc interface for this problem.  I have
to look into it some more.  None the less this is not a big problem.  If
it boots you're in good shape.

Could you, however send me the output of lspnp for /proc/bus/pnp/boot/13.
This will not fault.  Also could you try lspnp on /proc/bus/pnp/14.  If
all is well this one should not fault.

by the way

/proc/bus/pnp/*.* = current
/proc/bus/pnp/boot/*.* = boot

current config has the problem but boot does not.  I'll work on a patch to
fix this.

Thanks,
Adam
