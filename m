Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWJQHhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWJQHhA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 03:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWJQHhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 03:37:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42195 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932212AbWJQHg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 03:36:59 -0400
Date: Tue, 17 Oct 2006 00:36:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Miles Lane" <miles.lane@gmail.com>
Cc: dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.19-rc2-mm1
Message-Id: <20061017003649.dee35867.akpm@osdl.org>
In-Reply-To: <a44ae5cd0610170003r77595cc0p8ed66badde952859@mail.gmail.com>
References: <20061016230645.fed53c5b.akpm@osdl.org>
	<a44ae5cd0610170003r77595cc0p8ed66badde952859@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2006 00:03:56 -0700
"Miles Lane" <miles.lane@gmail.com> wrote:

>   CC [M]  drivers/usb/gadget/net2280.o
> drivers/usb/gadget/net2280.c: In function 'usb_gadget_register_driver':
> drivers/usb/gadget/net2280.c:2047: error: expected expression before 'do'
> drivers/usb/gadget/net2280.c:2049: error: expected expression before 'do'
> drivers/usb/gadget/net2280.c: In function 'net2280_probe':
> drivers/usb/gadget/net2280.c:2989: error: expected expression before 'do'
> drivers/usb/gadget/net2280.c:2972: warning: ignoring return value of

This, I guess:

--- a/drivers/usb/gadget/net2280.c~usb-gadget-net2280-handle-sysfs-errors-fix
+++ a/drivers/usb/gadget/net2280.c
@@ -1774,7 +1774,7 @@ static DEVICE_ATTR (queues, S_IRUGO, sho
 
 #else
 
-#define device_create_file(a,b)	do {} while (0)
+#define device_create_file(a,b)	(0)
 #define device_remove_file	device_create_file
 
 #endif
_

