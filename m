Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVARP3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVARP3r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 10:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVARP3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 10:29:47 -0500
Received: from piggy.rz.tu-ilmenau.de ([141.24.4.8]:7303 "EHLO
	piggy.rz.tu-ilmenau.de") by vger.kernel.org with ESMTP
	id S261312AbVARP3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 10:29:45 -0500
Date: Tue, 18 Jan 2005 16:29:42 +0100
From: Mario Holbe <Mario.Holbe@TU-Ilmenau.DE>
To: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4: "access beyond end of device" after ext2 mount
Message-ID: <20050118152942.GK2839@darkside.22.kls.lan>
Mail-Followup-To: Mario Holbe <Mario.Holbe@TU-Ilmenau.DE>,
	"Piszcz, Justin Michael" <justin.piszcz@mitretek.org>,
	linux-kernel@vger.kernel.org
References: <2E314DE03538984BA5634F12115B3A4E01BC42B3@email1.mitretek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E314DE03538984BA5634F12115B3A4E01BC42B3@email1.mitretek.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 09:24:03AM -0500, Piszcz, Justin Michael wrote:
> Is the problem with the drive on the promise board or the drive on the
> VIA chipset?

The problem is with each drive on each controller. The problem is even
with no drive on no controller - as I've shown to you with my loop
example, because it does have exactly nothing to do with drives or
controllers at all but just with block devices and their block size.

> the same problem you are having, the motherboard did not support drives
> over 32GB or it was because I had the 32GB clip (pins on the back of the

I'm quite sure my board supports drives bigger than 32G and also drives
biggern than 128G.

> hard drive) shorted.  Did you check your HDD manual to see if you have
> the 32GB clip enabled?  If so, you need to disable this.

And I'm horribly sure, that I don't have 32GB clipping enabled on
my 40, 80 or 160G drives :)

However - it has nothing to do with drives at all. Just with block
devices and block sizes. It's no physical problem but a logical one
and you can reproduce it on any drive you like just by creating
partitions big enough to force mke2fs to allocate (2048|4096) blocks
(or by creating small ones and force mke2fs manually) and with an
absolute size being a multiple of 1024 but none of (2048|4096).


Mario
-- 
<jv> Oh well, config
<jv> one actually wonders what force in the universe is holding it
<jv> and makes it working
<Beeth> chances and accidents :)
