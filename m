Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289606AbSAOOOK>; Tue, 15 Jan 2002 09:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289585AbSAOOOA>; Tue, 15 Jan 2002 09:14:00 -0500
Received: from pc-80-195-34-66-ed.blueyonder.co.uk ([80.195.34.66]:55170 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S289606AbSAOONs>; Tue, 15 Jan 2002 09:13:48 -0500
Date: Tue, 15 Jan 2002 14:13:18 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Stephen Kitchener <stephen@g6dzj.demon.co.uk>
Cc: linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: Error message after lilo on 2.4.17
Message-ID: <20020115141318.A5172@redhat.com>
In-Reply-To: <E16OQOR-00072j-0B@finch-post-11.mail.demon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16OQOR-00072j-0B@finch-post-11.mail.demon.net>; from stephen@g6dzj.demon.co.uk on Wed, Jan 09, 2002 at 09:36:06PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 09, 2002 at 09:36:06PM +0000, Stephen Kitchener wrote:
 
> I have built a 2.4.17 kernel from source on a machine here, via make 
> mrproper, make xconfig, make bZimage, make mdules, make modules_install, 
> ,make install. Im just repeating them here so that you can see what I have 
> done :-).

Actually, you need an initrd too:

> image=/boot/vmlinuz-2.4.17
>         label=2417
>         root=/dev/sda1
>         read-only
>         optional
>         vga=normal
>         append=" devfs=mount quiet"
>         initrd=/boot/initrd-2.4.17.img

Is your initrd set up to mount root as ext3?  Under Red Hat, that
happens automatically if you have ext3 as the root fstype in
/etc/fstab when you run mkinitrd; I've no idea whether or not Mandrake
has the same magic.

Cheers,
 Stephen
