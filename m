Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262269AbRENJaf>; Mon, 14 May 2001 05:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262274AbRENJaZ>; Mon, 14 May 2001 05:30:25 -0400
Received: from t2.redhat.com ([199.183.24.243]:10223 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262269AbRENJaS>; Mon, 14 May 2001 05:30:18 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <m1y9s1jbml.fsf@frodo.biederman.org> 
In-Reply-To: <m1y9s1jbml.fsf@frodo.biederman.org>  <20010511162412.A11896@lucon.org> <15100.30085.5209.499946@pizda.ninka.net> <20010511165339.A12289@lucon.org> <m13da9ky7s.fsf@frodo.biederman.org> <20010513110707.A11055@lucon.org> 
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: "H . J . Lu" <hjl@lucon.org>, "David S. Miller" <davem@redhat.com>,
        alan@lxorguk.ukuu.org.uk, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Enable IP PNP for 2.4.4-ac8 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 14 May 2001 10:29:47 +0100
Message-ID: <16874.989832587@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ebiederm@xmission.com said:
>  Since you have to set the command line anyway ip=dhcp is no extra
> burden and it lets you use the same kernel to boot of the harddrive
> etc.

You don't have to set the command line anyway. At least you _didn't_.


ebiederm@xmission.com said:
>  I boot diskless all of time and supporting a ramdisk is trivial.  You
> just a have a program that slaps a kernel a ramdisk, and some command
> line arguments into a single image, along with a touch of adapter code
> to set the kernel parameters correctly and then boot that.

It's a PITA. Downloading a kernel by TFTP each time you make a one-line 
change is painful enough, without having to download a ramdisk to go with 
it.

And once those kernels are being built with CONFIG_BLK_DEV=n, the ramdisk 
is going to be an even more unattractive solution.

--
dwmw2


