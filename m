Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbTKQQZI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 11:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTKQQZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 11:25:07 -0500
Received: from users.linvision.com ([62.58.92.114]:56463 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S263587AbTKQQZF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 11:25:05 -0500
Date: Mon, 17 Nov 2003 17:25:03 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Andrey Borzenkov <arvidjaar@mail.ru>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is initramfs freed after kernel is booted?
Message-ID: <20031117162503.GE32106@bitwizard.nl>
References: <E1ALlQs-000769-00.arvidjaar-mail-ru@f7.mail.ru> <3FB8EBC2.1080800@nortelnetworks.com> <3FB8ED91.3050305@backtobasicsmgmt.com> <3FB8F218.30601@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FB8F218.30601@nortelnetworks.com>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 17, 2003 at 11:06:48AM -0500, Chris Friesen wrote:
> Kevin P. Fleming wrote:
> 
> >There is no pivot_root happening here; the kernel creates a ramfs and 
> >mounts it on / (as rootfs), then unpacks the initramfs cpio archive into 
> >it. After doing a few more steps, it overmounts the real root onto /, 
> >making the rootfs filesystem invisible. It is not freed in the current 
> >kernels.
> 
> Anyone know why it overmounts rather than pivots?

IIRC Al Viro did it on purpose, cause in this way he could get rid of
the special casing for the root filesystem in the VFS.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
| Data lost? Stay calm and contact Harddisk-recovery.com
