Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264919AbUHDMlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUHDMlu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 08:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbUHDMlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 08:41:49 -0400
Received: from users.linvision.com ([62.58.92.114]:22464 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262356AbUHDMko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 08:40:44 -0400
Date: Wed, 4 Aug 2004 14:40:42 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Jan De Luyck <lkml@kcore.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.8-rc3
Message-ID: <20040804124042.GA25969@harddisk-recovery.com>
References: <Pine.LNX.4.58.0408031505470.24588@ppc970.osdl.org> <200408041407.39871.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408041407.39871.lkml@kcore.org>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 02:07:20PM +0200, Jan De Luyck wrote:
> On Wednesday 04 August 2004 00:09, Linus Torvalds wrote:
> > It would be good if people only sent serious stuff for a while, and we can
> > do a real 2.6.8, ok?
> 
> Works like a charm, only one comment:
> 
> Mounting my vfat partitions gave me this error:
> 
> FAT: codepage or iocharset option didn't specified
>      File name can not access proper (mounted as read-only)
> 
> which was easily fixed by supplying a iocharset= mount option. But according 
> to the man page of mount:
> 
>        iocharset=value
>               Character set to use for converting between 8 bit characters and
>               16 bit Unicode characters. The default is iso8859-1.  Long file-
>               names are stored on disk in Unicode format.
> 
> the default is iso8859-1. Has this default gone haywire somewhere?

Yes, it's in the hidden in the ChangeLog. You can find it if you know
iocharset is the same as nls:

  Hirofumi Ogawa:
    o FAT: kill nls default


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
