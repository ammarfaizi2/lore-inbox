Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262361AbVG2FfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbVG2FfJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 01:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVG2FfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 01:35:09 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:2756 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262361AbVG2FfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 01:35:07 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Rafael =?utf-8?q?Esp=C3=ADndola?= <rafael.espindola@gmail.com>,
       gentoo-dev@gentoo.org, gentoo-catalyst@gentoo.org,
       linux-kernel@vger.kernel.org
Subject: Re: unmounting a filesystem mounted by /init (initramfs)
Date: Fri, 29 Jul 2005 08:34:35 +0300
User-Agent: KMail/1.5.4
References: <564d96fb050728154923ba8663@mail.gmail.com>
In-Reply-To: <564d96fb050728154923ba8663@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507290834.35504.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 July 2005 01:49, you wrote:
> I am trying to build a system that uses a unionfs as root. The init
> script is based on the one used by gentoo and uses initramfs. The
> problem is how to remount the unionfs constituents read only during
> halt.
> 
> cat /proc/mounts displays /dev/hda1 (ext2) mounted rw in /memory. The
> problem is that /memory is no longer visible after the init script did
> a chroot and a

"A chroot"? Better provide exact sequence of mounts, chroots which you
execute. Otherwise people need to guess.
 
> mount -o remount,ro /dev/hda1
> 
> says that /dev/hda1 is not mounted!
> 
> does any anyone has an idea?

Use lazy umount (umount -l) while fs is still visible
--
vda

