Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbUCBAdK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 19:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbUCBAdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 19:33:10 -0500
Received: from hera.kernel.org ([63.209.29.2]:26347 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261253AbUCBAdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 19:33:07 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [2.6.3] Sysfs breakage - tun.ko
Date: Tue, 2 Mar 2004 00:32:59 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c20knr$35r$1@terminus.zytor.com>
References: <4043938C.9090504@lbsd.net> <40439B03.4000505@backtobasicsmgmt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1078187579 3260 63.209.29.3 (2 Mar 2004 00:32:59 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 2 Mar 2004 00:32:59 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <40439B03.4000505@backtobasicsmgmt.com>
By author:    "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
In newsgroup: linux.dev.kernel
>
> Nigel Kukard wrote:
> 
> > --- drivers/net/tun.c.old   2004-02-27 18:18:55.000000000 +0200
> > +++ drivers/net/tun.c       2004-02-27 18:19:02.000000000 +0200
> > @@ -605,7 +605,7 @@
> > 
> >  static struct miscdevice tun_miscdev = {
> >         .minor = TUN_MINOR,
> > -       .name = "net/tun",
> > +       .name = "tun",
> >         .fops = &tun_fops
> >  };
> 
> This changed back and forth since the tun driver was added to the 
> kernel; making this change will cause the devfs path to the tun node to 
> change, and userspace applications expect it to be at /dev/misc/net/tun, 
> whether that's right or wrong.
> 

Bullsh*t.

User-space apps expect it to be /dev/net/tun, which is the documented
path for this device node.  Anything else is a devfs bug (/dev/misc is
a devfs bug from beginning to end.)

	-hpa
