Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263439AbTKQR0B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 12:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263598AbTKQR0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 12:26:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14989 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263439AbTKQRZ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 12:25:59 -0500
Date: Mon, 17 Nov 2003 17:25:57 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Andrey Borzenkov <arvidjaar@mail.ru>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is initramfs freed after kernel is booted?
Message-ID: <20031117172557.GX24159@parcelfarce.linux.theplanet.co.uk>
References: <E1ALlQs-000769-00.arvidjaar-mail-ru@f7.mail.ru> <3FB8EBC2.1080800@nortelnetworks.com> <3FB8ED91.3050305@backtobasicsmgmt.com> <3FB8F218.30601@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FB8F218.30601@nortelnetworks.com>
User-Agent: Mutt/1.4.1i
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

Because amount of extra code you lose that way takes more memory than
empty roots takes.

Remove whatever files you don't need and be done with that.
