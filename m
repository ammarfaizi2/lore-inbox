Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932589AbVI3T11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbVI3T11 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 15:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbVI3T11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 15:27:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19078 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932592AbVI3T10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 15:27:26 -0400
Date: Fri, 30 Sep 2005 12:27:04 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Wright <chrisw@osdl.org>
cc: Harald Welte <laforge@gnumonks.org>, Sergey Vlasov <vsu@altlinux.ru>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       security@linux.kernel.org, vendor-sec@lst.de
Subject: Re: [linux-usb-devel] Re: [Security] [vendor-sec] [BUG/PATCH/RFC]
 Oops while completing async USB via usbdevio
In-Reply-To: <20050930184433.GF16352@shell0.pdx.osdl.net>
Message-ID: <Pine.LNX.4.64.0509301225190.3378@g5.osdl.org>
References: <20050925151330.GL731@sunbeam.de.gnumonks.org>
 <Pine.LNX.4.58.0509270746200.3308@g5.osdl.org> <20050927160029.GA20466@master.mivlgu.local>
 <Pine.LNX.4.58.0509270904140.3308@g5.osdl.org> <20050927165206.GB20466@master.mivlgu.local>
 <Pine.LNX.4.58.0509270959380.3308@g5.osdl.org> <20050930104749.GN4168@sunbeam.de.gnumonks.org>
 <Pine.LNX.4.64.0509300752530.3378@g5.osdl.org> <20050930184433.GF16352@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Sep 2005, Chris Wright wrote:
> 
> Sorry, I missed the thread up to this, but this looks fundamentally
> broken.  The kill_proc_info_as_uid() idea is not sufficient because more
> than uid/euid are needed for permission check.  There's capabilities and
> security labels.

Not for this particular USB use, there isn't. Since you can only send a 
signal to yourself anyway, the uid/euid check is just testing that you're 
still who you were.

		Linus
