Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285161AbSBBX6H>; Sat, 2 Feb 2002 18:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284732AbSBBX56>; Sat, 2 Feb 2002 18:57:58 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:35272 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S284970AbSBBX5q>;
	Sat, 2 Feb 2002 18:57:46 -0500
Date: Sat, 2 Feb 2002 18:57:44 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SIOCDEVICE ?
Message-ID: <20020202185744.B1740@havoc.gtf.org>
In-Reply-To: <200201311304.FAA00344@adam.yggdrasil.com> <20020131181241.A3524@fafner.intra.cogenit.fr> <m3665iqhqn.fsf@defiant.pm.waw.pl> <20020202154424.A5845@fafner.intra.cogenit.fr> <m3wuxvofvf.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m3wuxvofvf.fsf@defiant.pm.waw.pl>; from khc@pm.waw.pl on Sat, Feb 02, 2002 at 08:14:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2002 at 08:14:44PM +0100, Krzysztof Halasa wrote:
> Francois Romieu <romieu@cogenit.fr> writes:
> 
> > Your patch doesn't apply against 2.5.3. I did a quick update and noticed the
> > patch is the sole user of SIOCDEVICE (with dscc4) and SIOCDEVPRIVATE.
> 
> SIOCDEVICE, yes. That's my attempt to create an ioctl interface for
> controlling devices. It's defined by the hdlc patch, discussed about
> a year (?) ago here. Yes, I think I should post a note here.

This too seems way too generic for including in the kernel.


> A new patch which applies to 2.5.3 is in the usual place:
> ftp://ftp.pm.waw.pl/pub/linux/hdlc/
> This is what I want included in base kernel.

What data is passed through the following structure?

Untyped data has the same problems as I listed for SIOCDEVPRIVATE:

> struct if_settings
> {
>       unsigned int type;      /* Type of physical device or protocol */
>       unsigned int data_length; /* device/protocol data length */
>       void * data;            /* pointer to data, ignored if length = 0 */
> };

Regards,

	Jeff



