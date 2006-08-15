Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030349AbWHOPbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbWHOPbp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 11:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030350AbWHOPbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 11:31:45 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:50708 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030349AbWHOPbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 11:31:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Kp3wB6LqI3cVZ2bpkyUIrADzA0UtW+rU8C8J4rBAW2l4vCY2Kq+TXUbOJXqhGwZ8EiNtPk/OidEGRKk1LxCYKlialp8RMa6Y4zaCkF09l6S4LpwVWpmpMM78DZtNLZU3wPx5jE0AibGq95v2+ovNUy4Ug3UduUF8wz3vZDF4GHI=
Message-ID: <6bffcb0e0608150831q77c4fcdcw3a2a11ad85e337a4@mail.gmail.com>
Date: Tue, 15 Aug 2006 17:31:42 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Zeidler, Mike" <mike.zeidler@windriver.com>
Subject: Re: Unable to boot kernel after compiling source for 2.6.17-1.2157
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <238E9E8D08550342B3642CB0631EFFD42F8D9D@ala-mail04.corp.ad.wrs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <238E9E8D08550342B3642CB0631EFFD42F8D9D@ala-mail04.corp.ad.wrs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15/08/06, Zeidler, Mike <mike.zeidler@windriver.com> wrote:
> After building the kernel  and copying the arch/i386/boot/bzImage to
> /boot/vmlinuz-2.6.17-1.2157_FC5smp
> and doing a make modules_install
> and doing a mkinitrd

Try to use new-kernel-pkg instead of mkinitrd
sudo /sbin/new-kernel-pkg --make-default --mkinitrd --depmod
--kernel-args="crashkernel=64M@16M" --install $VER

You can also use
http://www.stardust.webpages.pl/files/crap/kgbi2.sh

> And modifying grub.conf to have the following lines
>
> default=0
> timeout=5
> splashimage=(hd0,0)/grub/splash.xpm.gz
> hiddenmenu
> title Fedora Core (2.6.17-1.2157_FC5smp)
>         root (hd0,0)
>         kernel /vmlinuz-2.6.17-1.2157_FC5smp ro
> root=/dev/VolGroup00/LogVol00 rhgb quiet
>         initrd /initrd-2.6.17-1.2157_FC5smp.img
>
> I am still getting the following errors:
>
>
> Insmod : error inserting '/lib/scsi_mod.ko' : -1 Operation not Permitted
> Insmod : error inserting '/lib/sd_mod.ko' : -1 Operation not Permitted
> Insmod : error inserting '/lib/libata.ko' : -1 Operation not Permitted
> Insmod : error inserting '/lib/satasil24.ko' : -1 Operation not
> Permitted
> Insmod : error inserting '/lib/ata_piix.ko' : -1 Operation not Permitted
> Insmod : error inserting '/lib/jbd.ko' : -1 Operation not Permitted
> Insmod : error inserting '/lib/ext3' : -1 Operation not Permitted
> Insmod : error inserting '/lib/dm_mod.ko' : -1 Operation not Permitted
> Insmod : error inserting '/lib/mirror.ko' : -1 Operation not Permitted
> Insmod : error inserting '/lib/zero.ko' : -1 Operation not Permitted
> Insmod : error inserting '/lib/snapshot.ko' : -1 Operation not Permitted
>
> Any advice?
>
> Mike

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
