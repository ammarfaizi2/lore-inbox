Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285229AbSBCADH>; Sat, 2 Feb 2002 19:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284732AbSBCAC6>; Sat, 2 Feb 2002 19:02:58 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:39880 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S285229AbSBCACo>;
	Sat, 2 Feb 2002 19:02:44 -0500
Date: Sat, 2 Feb 2002 19:02:42 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        davem@redhat.com
Subject: Re: [PATCH] Generic HDLC patch for 2.5.3
Message-ID: <20020202190242.C1740@havoc.gtf.org>
In-Reply-To: <m3adurpifs.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m3adurpifs.fsf@defiant.pm.waw.pl>; from khc@pm.waw.pl on Sun, Feb 03, 2002 at 12:33:59AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 03, 2002 at 12:33:59AM +0100, Krzysztof Halasa wrote:
> Hi,
> 
> The attached file updates Linux 2.5.3 generic HDLC, please apply.
> 
> The patch includes:
> - new SIOCDEVICE ioctl for setting all protocol and hardware parameters
>   of (HDLC) network devices, instead of using PRIVATE netdev ioctls
>   (details in hdlc.h and respective hdlc_*.c and/or N2 + C101 drivers)
> - the HDLC code is now split into hdlc_generic.c, hdlc_fr.c,
>   hdlc_cisco.c etc. files,
> - all protocol parameters (timeouts etc.) are (should/aim) now configurable
>   via SIOCDEVICE ioctl,



Linus,

Please revert, or do not apply, this patch.

ftp://ftp.pm.waw.pl/pub/linux/hdlc/experimental/hdlc-2.5.3.patch.gz

It adds undiscussed networking changed which I very much doubt DaveM
would approve of, and I do not approve of:  SIOCDEVICE is far too
generic for inclusion, and it adds a structure for passing untyped
data which is very definitely non-portable.

	Jeff



