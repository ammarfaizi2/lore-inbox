Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272143AbSKECXb>; Mon, 4 Nov 2002 21:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266159AbSKECXb>; Mon, 4 Nov 2002 21:23:31 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:21632 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S272137AbSKECX3>; Mon, 4 Nov 2002 21:23:29 -0500
Date: Tue, 5 Nov 2002 13:29:24 +1100
From: CaT <cat@zip.com.au>
To: Adam Belay <ambx1@neo.rr.com>, greg@kroah.com, linux@brodo.de,
       Tamagucci@libero.it, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.45 / boottime oops (pnp bios I think)
Message-ID: <20021105022924.GB644@zip.com.au>
References: <20021104025458.GA3088@zip.com.au> <20021104161504.GA316@neo.rr.com> <20021104235408.GA627@zip.com.au> <20021104202800.GD316@neo.rr.com> <20021105020630.GA644@zip.com.au> <20021104212444.GH316@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021104212444.GH316@neo.rr.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 09:24:44PM +0000, Adam Belay wrote:
> On Tue, Nov 05, 2002 at 01:06:30PM +1100, CaT wrote:
> > The patch lets me boot just fine. (Woo) One hassle though, doing
> > lspci -v 13 or cat /proc/bus/pnp/13 causes an oops. I presume it's the
> > same deal as what you were talking about?
> 
> Oops, I forgot to fix the pnpbios proc interface for this problem.  I have
> to look into it some more.  None the less this is not a big problem.  If
> it boots you're in good shape.

Cool, thanks. :)

> Could you, however send me the output of lspnp for /proc/bus/pnp/boot/13.

1 [13:28:05] hogarth@theirongiant:/proc/bus/pnp>> lspnp -bvv 13
13 PNP0f13 input device: mouse
    flags: [input] [dynamic]
    allocated resources:
        irq 12 [high edge]
    possible resources:
        irq 12 [high edge]

> This will not fault.  Also could you try lspnp on /proc/bus/pnp/14.  If

1 [13:27:59] hogarth@theirongiant:/proc/bus/pnp>> lspnp -vv 14
14 PNP0501 communications device: RS-232
    flags: [dynamic]
    allocated resources:
        io 0x03f8-0x03ff [16-bit decode]
        irq 4 [high edge]
    possible resources:
        [start dep fn]
        io 0x03f8-0x03ff [16-bit decode]
        irq 4 [high edge]
        [start dep fn]
        io 0x02f8-0x02ff [16-bit decode]
        irq 3 [high edge]
        [start dep fn]
        io 0x03e8-0x03ef [16-bit decode]
        irq 4 [high edge]
        [start dep fn]
        io 0x02e8-0x02ef [16-bit decode]
        irq 3 [high edge]
        [end dep fn]


> all is well this one should not fault.

Neither faulted.

> by the way
> 
> /proc/bus/pnp/*.* = current
> /proc/bus/pnp/boot/*.* = boot
> 
> current config has the problem but boot does not.  I'll work on a patch to
> fix this.

Sweet. Thanks. :)

-- 
        All people are equal,
        But some are more equal then others.
            - George W. Bush Jr, President of the United States
              September 21, 2002 (Abridged version of security speech)
