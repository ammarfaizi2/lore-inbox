Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266774AbUGUXrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266774AbUGUXrg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 19:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266778AbUGUXrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 19:47:35 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:39851 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266774AbUGUXr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 19:47:29 -0400
Date: Wed, 21 Jul 2004 19:47:12 -0400
From: "George G. Davis" <davis_g@comcast.net>
To: Lei Yang <leiyang@nec-labs.com>
Cc: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>,
       "Kernelnewbies (E-mail)" <kernelnewbies@nl.linux.org>
Subject: Re: Jffs2 file system
Message-ID: <20040721234712.GD32271@mvista.com>
References: <951A499AA688EF47A898B45F25BD8EE80126D4D3@mailer.nec-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <951A499AA688EF47A898B45F25BD8EE80126D4D3@mailer.nec-labs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2004 at 03:48:35PM -0400, Lei Yang wrote:
> Hello,
> 
> Can I use jffs2 on a ramdisk? Is jffs2 only designed to be used on flash memory devices rather than RAM devices?

Your jffs2 question was already answered.

But this one wasn't answered:

> What about cramfs?

You can in fact use cramfs "on a ramdisk", e.g.:

cat image.cramfs > /dev/ram1
mkdir /mnt/cramfs
mount -oro /dev/ram1 /mnt/cramfs
mount | grep ram1
/dev/ram1 on /mnt/cramfs type cramfs (ro)

Of course cramfs also works on other block devices as well, e.g. mtdblock.

--
Regards,
George
