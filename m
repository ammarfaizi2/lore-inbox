Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311841AbSCXTAo>; Sun, 24 Mar 2002 14:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311858AbSCXTAf>; Sun, 24 Mar 2002 14:00:35 -0500
Received: from NEVYN.RES.CMU.EDU ([128.2.145.6]:48534 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id <S311848AbSCXTAY>;
	Sun, 24 Mar 2002 14:00:24 -0500
Date: Sun, 24 Mar 2002 13:59:41 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Dave Jones <davej@suse.de>, Boris Bezlaj <boris@kista.gajba.net>,
        kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: mdacon.c minor cleanups
Message-ID: <20020324135941.A967@nevyn.them.org>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Boris Bezlaj <boris@kista.gajba.net>,
	kernel-janitor-discuss <kernel-janitor-discuss@lists.sourceforge.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020323164220.742414d2.boris@kista.gajba.net> <20020324194254.A14465@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2002 at 07:42:54PM +0100, Dave Jones wrote:
> On Sat, Mar 23, 2002 at 04:42:20PM +0100, Boris Bezlaj wrote:
> 
>  >  	if (! mda_detect()) {
>  > -		printk("mdacon: MDA card not detected.\n");
>  > +		printk(KERN_WARNING __FILE__ ": MDA card not detected.\n");
>  >  		return NULL;
> 
> Does __FILE__ suffer the same 'deprecated' warning that newer gcc 3's
> spit out for __FUNCTION__  ? If so, it'd be better to do this properly
> than to add more bits that will just create another janitor item for
> someone else later..

No, it shouldn't.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
