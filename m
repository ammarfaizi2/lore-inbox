Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbVJJSUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbVJJSUF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 14:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbVJJSUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 14:20:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18583 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751147AbVJJSUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 14:20:04 -0400
Date: Mon, 10 Oct 2005 11:19:43 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Harald Welte <laforge@gnumonks.org>
cc: Chris Wright <chrisw@osdl.org>, Sergey Vlasov <vsu@altlinux.ru>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       security@linux.kernel.org, vendor-sec@lst.de
Subject: Re: [BUG/PATCH/RFC] Oops while completing async USB via usbdevio
In-Reply-To: <20051010174429.GH5627@rama>
Message-ID: <Pine.LNX.4.64.0510101052520.14597@g5.osdl.org>
References: <20050927160029.GA20466@master.mivlgu.local>
 <Pine.LNX.4.58.0509270904140.3308@g5.osdl.org> <20050927165206.GB20466@master.mivlgu.local>
 <Pine.LNX.4.58.0509270959380.3308@g5.osdl.org> <20050930104749.GN4168@sunbeam.de.gnumonks.org>
 <Pine.LNX.4.64.0509300752530.3378@g5.osdl.org> <20050930184433.GF16352@shell0.pdx.osdl.net>
 <Pine.LNX.4.64.0509301225190.3378@g5.osdl.org> <20050930220808.GE4168@sunbeam.de.gnumonks.org>
 <Pine.LNX.4.64.0509301514190.3378@g5.osdl.org> <20051010174429.GH5627@rama>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Oct 2005, Harald Welte wrote:
> 
> Sorry, I've been busy, mostly with the annual netfilter developer
> workshop. What about the following proposed fix:

Yes, looks ok, apart from some small details. Like "uid" adn "euid" is of 
type "uid_t", not "pid_t", and I think that "kill_proc_info_as_uid()" 
needs exporting for modules (I assume usbdevio can be one).

Chris, others, comments?

		Linus
