Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266619AbUHZJmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266619AbUHZJmy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 05:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268020AbUHZJkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 05:40:41 -0400
Received: from ee.oulu.fi ([130.231.61.23]:27367 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S266619AbUHZJWo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 05:22:44 -0400
Date: Thu, 26 Aug 2004 12:22:33 +0300 (EEST)
From: Tuukka Toivonen <tuukkat@ee.oulu.fi>
X-X-Sender: tuukkat@stekt37
To: Simon Oosthoek <simon@ti-wmc.nl>
cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       "Nemosoft Unv." <nemosoft@smcc.demon.nl>
Subject: Re: [linux-usb-devel] Re: kernel 2.6.8 pwc patches and counterpatches
In-Reply-To: <cgi65a$s76$1@sea.gmane.org>
Message-ID: <Pine.GSO.4.61.0408261201490.16780@stekt37>
References: <1092793392.17286.75.camel@localhost> <1092845135.8044.22.camel@localhost>
 <20040823221028.GB4694@kroah.com> <200408250058.24845@smcc.demon.nl>
 <cgi65a$s76$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2004, Simon Oosthoek wrote:

> I have one of those philips cams (bought it because I saw pwc in the kernel 
> source), but I found out that without pwcx is was next to useless. I haven't

Could you elaborate why it is next to useless? I think 95% of Linux
web camera drivers don't support all features of a camera, like 
compression. Reverse engineering USB traffic is easy, reverse engineering
compressed formats is _hard_.

> The fact that the NDA has expired already doesn't surprise me, but I would 
> have expected some (or a huge) effort to liberate the source with full 
> permission from Philips (they probably don't care anymore and could use the

I understood that Nemosoft has already asked Philips a permission and 
denied for that. It hardly helps asking again and again and again... he has 
to maintain the driver, too.

> The fact that this hasn't happened is to me a hint that Nemosoft likes the 
> power of "owning" it more that the chance of liberating it. But I could be

Why do you think that *most* of the pwc driver is already GPL'ed then, and 
even (was) in the kernel?

> I'd prefer that a clear choice is made on this, as Nemosoft suggests, because 
> it shouldn't be in the kernel without the full decoding algorithms.

Then you should remove most of the other drivers in the kernel too.

Besides, format conversions _are not allowed_ in the kernel. They belong 
into userspace.

Nemosoft: you should not have the power to demand removing the GPL'd code
from the kernel (I don't know about the law, but whatever it says, GPL'd 
license should not be revocable). You can ask, of course, but wouldn't it 
be simpler to just stop maintaining the in-kernel driver, if it already 
works?

From: Greg KH <greg@kroah.com>
>> We'll see. Greg, please remove all references to the PWC driver from the 2.6
>> kernel ASAP. This also includes Documentation/usb/philips.txt and a
>I'm very sorry it's come to this, I really am.
>
>I'd like to personally thank you for all the time you've spent in
>working on this driver over the years, and wish you the best in whatever
>you do in the future.  Come back anytime.

Too bad seeing this. Nemosoft, I hope you will continue maintaining
the driver which looks very nice (though I haven't been able to test it),
at least as an external module. That allows you free hands to add any nice
features that would never been accepted into kernel, anyway.

--
| Tuukka Toivonen <tuukkat@ee.oulu.fi>   [OpenPGP public key
| Homepage: http://www.ee.oulu.fi/~tuukkat/       available]
| M.Sc. Researcher, Dept of El & Inf Eng, University of Oulu
| "You will be shot if you try to do
|           format conversion in kernel" -Pavel Machek, 2001
+-----------------------------------------------------------
