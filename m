Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbUK1KTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbUK1KTB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 05:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbUK1KTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 05:19:01 -0500
Received: from rev.193.226.233.139.euroweb.hu ([193.226.233.139]:4322 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261423AbUK1KS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 05:18:59 -0500
To: jengelh@linux01.gwdg.de
CC: viro@parcelfarce.linux.theplanet.co.uk, oebilgen@uekae.tubitak.gov.tr,
       linux-kernel@vger.kernel.org
In-reply-to: <Pine.LNX.4.53.0411281104100.20168@yvahk01.tjqt.qr> (message from
	Jan Engelhardt on Sun, 28 Nov 2004 11:08:38 +0100 (MET))
Subject: Re: Problem with ioctl command TCGETS
References: <20041128002044.CE13839877@uekae.uekae.gov.tr>
 <20041128003901.GS26051@parcelfarce.linux.theplanet.co.uk>
 <E1CYLpf-0001VQ-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.53.0411281104100.20168@yvahk01.tjqt.qr>
Message-Id: <E1CYM8e-0001Y7-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 28 Nov 2004 11:18:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The idea is nice, yet the "dir" and "size" parameters in the original _IO*
> macros are only there (IMO) to protect against using the wrong value for the
> wrong operation on the wrong fd/file/device/socket/etc.

Size and dir are there to make the memory passed to the syscall easily
verifiable (like read/write/getsockopt/setsockopt/etc)

> What is the point in making "param" a char*? You would need to parse it down
> again.

'char *' namespace is easier to manage than 'int' namespace.

> Oh yeah and call it ioctl2(), sounds more cryptical :)

Is that an advantage?

Thanks,
Miklos
