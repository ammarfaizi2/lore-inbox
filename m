Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbWGIRIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbWGIRIP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 13:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWGIRIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 13:08:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:20420 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964877AbWGIRIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 13:08:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JvKP1NUCWYMsbPPEflG/NWtGxq6mMV4pD/ooCZTtvclxqbewTzRoSbYv49KG05iefWXT/whLEvdBYe7F7Fp4fvklCpH3MrFmR1qJdtJqftPZpvatLlmTpkC/IyCn4bwqoQ6T8Pt2t8dGrUm+4g3gujPdJ7KVE0+cJ9h1gQ2fRX8=
Message-ID: <2c0942db0607091008x420d9b4end7a014617217e146@mail.gmail.com>
Date: Sun, 9 Jul 2006 10:08:12 -0700
From: "Ray Lee" <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: "Albert Cahalan" <acahalan@gmail.com>
Subject: Re: Opinions on removing /proc/tty?
Cc: "Jon Smirl" <jonsmirl@gmail.com>, "Greg KH" <greg@kroah.com>,
       rmk+lkml@arm.linux.org.uk, alan@lxorguk.ukuu.org.uk, efault@gmx.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <2c0942db0607091000m259c1ed5m960821eb5237c4b0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920607082230w676ddc62u57962f1fc08cf009@mail.gmail.com>
	 <9e4733910607090704r68602194h3d2a1a91a4909984@mail.gmail.com>
	 <787b0d920607090923p65c417f2v71c8e72bf786f995@mail.gmail.com>
	 <2c0942db0607091000m259c1ed5m960821eb5237c4b0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/06, Ray Lee <madrabbit@gmail.com> wrote:
> A simple solution would be for udev to just maintain a list in a flat
> file (e.g., /dev/.mappings) that could be read (very quickly) by ps
> upon startup.

And this could/should probably be an append-only file cleared out at
boot, so that the overhead of continually re-reading/re-writing the
file per device node on boot is removed. That'd slow things down for
sure.

Any reader just needs to know to read the whole file in, and either
construct a final lookup table in memory or scan backwards.

~r.
