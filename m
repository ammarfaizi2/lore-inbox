Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030273AbWADUY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbWADUY5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 15:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965279AbWADUY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 15:24:57 -0500
Received: from xenotime.net ([66.160.160.81]:18845 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965252AbWADUY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 15:24:57 -0500
Date: Wed, 4 Jan 2006 12:24:54 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: andyliebman@aol.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Atapi CDROM, SATA OS drive, and 2.6.14+ kernel
In-Reply-To: <8C7DF7FCD8430A9-C8C-4BB2@MBLK-M38.sysops.aol.com>
Message-ID: <Pine.LNX.4.58.0601041224180.19134@shark.he.net>
References: <8C7DF7FCD8430A9-C8C-4BB2@MBLK-M38.sysops.aol.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2006 andyliebman@aol.com wrote:

> Can somebody tell me what changed in the 2.6.14 kernel that doesn't
> allow me to access my CDROM drive when my OS drive is SATA?
>
> I have an image of a working 2.6.14 system that was installed on an IDE
> drive. I restored the image to a SATA drive, changed a few lines in
> /etc/fstab and /etc/lilo.conf so that they refer to /dev/sd* devices
> instead of /dev/hd* devices.
>
> I also modified /etc/modprobe.conf so that it is identical to the file
> that Mandriva 2006 produces when installed directly to a SATA drive
> (but Mandriva 2006 has the 2.6.12.x kernel).
>
> I can't mount my CDROM when running 2.6.14.x
>
> I have googled this for several days. I have seen posts about passing
> options to the kernel and including extra lines in modprobe.conf like:
>
> libata atapi_enabled=1

should be:
  libata.atapi_enabled=1
if libata is built into the kernel image.

> Can't find the magic formula. Help would be appreciated.

-- 
~Randy
