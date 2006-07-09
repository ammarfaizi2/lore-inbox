Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161098AbWGIT5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161098AbWGIT5S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 15:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161095AbWGIT5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 15:57:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:26221 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161098AbWGIT5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 15:57:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YH35SOIOOZxW1zFDZT4E/y3kZjUPai4V0QuDQ5oVyCHnbIN6Y9pQJh3QHhH3ex57Qhrctmju3Mi0lM55Fm05laRBR6BoTTKMR3o6FXaQ6KatsJTSK25nzugPzIlwJGi6EK2IDI8q9Aeq3V1Q2Kq4RIB1Nd4dNgyoyh9mL/ITX7c=
Message-ID: <787b0d920607091257u52198c55sb8973a39bff3fcc8@mail.gmail.com>
Date: Sun, 9 Jul 2006 15:57:15 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Albert Cahalan" <acahalan@gmail.com>, ray-gmail@madrabbit.org,
       "Jon Smirl" <jonsmirl@gmail.com>, "Greg KH" <greg@kroah.com>,
       alan@lxorguk.ukuu.org.uk, efault@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: Opinions on removing /proc/tty?
In-Reply-To: <20060709193133.GA32457@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920607082230w676ddc62u57962f1fc08cf009@mail.gmail.com>
	 <9e4733910607090704r68602194h3d2a1a91a4909984@mail.gmail.com>
	 <787b0d920607090923p65c417f2v71c8e72bf786f995@mail.gmail.com>
	 <2c0942db0607091000m259c1ed5m960821eb5237c4b0@mail.gmail.com>
	 <787b0d920607091226sb1db56dg9c0267f6ae8e2dc7@mail.gmail.com>
	 <20060709193133.GA32457@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/06, Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> So it basically breaks on 2.x kernels because (eg) you don't include major
> 204 as a tty major.  Plus, if you insist that there are only N tty major
> numbers, you break as soon as another tty major gets added.
>
> Try again.

I'm kidding of course. Putting the names in a file is crap.
This is what procps-1.x.xx did long ago. Everybody hated it.
You'll never handle chroot correctly.

Just do /proc/*/tty links and all will be good. This even
handles the case of two different names for the same dev_t.

If people seriously want to bring back the crap, then I can
design something tolerable. It would support mmap MAP_SHARED,
allowing live updates so that "top" can work nicely.
