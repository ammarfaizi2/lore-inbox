Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbULVEfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbULVEfH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 23:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbULVEfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 23:35:07 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:34540 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261240AbULVEe7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 23:34:59 -0500
Date: Wed, 22 Dec 2004 15:34:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, mochel@digitalimplant.org,
       axboe@suse.de
Subject: Re: /sys/block vs. /sys/class/block
Message-Id: <20041222153449.46da0671.sfr@canb.auug.org.au>
In-Reply-To: <1103612870.21771.22.camel@gaston>
References: <1103526532.5320.33.camel@gaston>
	<20041220224950.GA21317@kroah.com>
	<1103612870.21771.22.camel@gaston>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__22_Dec_2004_15_34_49_+1100_ZY3hITnIDMcG8X5p"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__22_Dec_2004_15_34_49_+1100_ZY3hITnIDMcG8X5p
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 21 Dec 2004 08:07:50 +0100 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> > Because /sys/block happened before /sys/class did.  Al Viro converted
> > the block layer before I got the struct class stuff working properly
> > during 2.5.
> > 
> > And yes, I would like to convert the block layer to use the class stuff,
> > but for right now, I can't as class devices don't allow
> > sub-classes-devices, and getting to that work is _way_ down on my list
> > of things to do.
> 
> but can't we at least artificially move it down to /sys/class anyway for
> the sake of a sane userland API ?

Can I then make the obvious suggestion: add a symlink in /sys/class
linking to /sys/block and then reverse the symink once the above work has
been done and /sys/class/block has been created?

Or is that too gross? :-)
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__22_Dec_2004_15_34_49_+1100_ZY3hITnIDMcG8X5p
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFByPlu4CJfqux9a+8RAhNvAJ4skR9d0vo2dXywA2Ekglajyy/4sgCbB5RK
O7PfhUI9w0ZhMp4sMADSoYU=
=TbGn
-----END PGP SIGNATURE-----

--Signature=_Wed__22_Dec_2004_15_34_49_+1100_ZY3hITnIDMcG8X5p--
