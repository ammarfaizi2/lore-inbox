Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbUK1KIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUK1KIz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 05:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbUK1KIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 05:08:55 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:26246 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261422AbUK1KIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 05:08:53 -0500
Date: Sun, 28 Nov 2004 11:08:38 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Miklos Szeredi <miklos@szeredi.hu>
cc: viro@parcelfarce.linux.theplanet.co.uk, oebilgen@uekae.tubitak.gov.tr,
       linux-kernel@vger.kernel.org
Subject: Re: Problem with ioctl command TCGETS
In-Reply-To: <E1CYLpf-0001VQ-00@dorka.pomaz.szeredi.hu>
Message-ID: <Pine.LNX.4.53.0411281104100.20168@yvahk01.tjqt.qr>
References: <20041128002044.CE13839877@uekae.uekae.gov.tr>
 <20041128003901.GS26051@parcelfarce.linux.theplanet.co.uk>
 <E1CYLpf-0001VQ-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On the subject of ioctls:  what about a replacement syscall:
>
> /**
>  * Getting and setting file parameters safely (ioctl done right)
>  *
>  * @fd     file descriptor
>  * @param  name of the parameter to get/set
>  * @dir    direction flag indicating either get, set, or set-get
>  * @value  value to set parameter to (set) or store current value into (get)
>  * @size   size of value
>  */
> int fparam(int fd, const char *param, int dir, void *value, size_t size);
>
>I know it's been talked about in the past.  Is anyone interested?

The idea is nice, yet the "dir" and "size" parameters in the original _IO*
macros are only there (IMO) to protect against using the wrong value for the
wrong operation on the wrong fd/file/device/socket/etc.

What is the point in making "param" a char*? You would need to parse it down
again.

Oh yeah and call it ioctl2(), sounds more cryptical :)



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
