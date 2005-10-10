Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbVJJUDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbVJJUDS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 16:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbVJJUDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 16:03:18 -0400
Received: from mx1.rowland.org ([192.131.102.7]:11282 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1751190AbVJJUDR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 16:03:17 -0400
Date: Mon, 10 Oct 2005 16:03:13 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Harald Welte <laforge@gnumonks.org>
cc: Linus Torvalds <torvalds@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Sergey Vlasov <vsu@altlinux.ru>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
       <security@linux.kernel.org>, <vendor-sec@lst.de>
Subject: Re: [linux-usb-devel] Re: [BUG/PATCH/RFC] Oops while completing
 async USB via usbdevio
In-Reply-To: <20051010174429.GH5627@rama>
Message-ID: <Pine.LNX.4.44L0.0510101559330.10768-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2005, Harald Welte wrote:

> +	if ((!info || ((unsigned long)info != 1 &&
> +			(unsigned long)info != 2 && SI_FROMUSER(info)))
> +	    && (euid ^ p->suid) && (euid ^ p->uid)
> +	    && (uid ^ p->suid) && (uid ^ p->uid)) {

No doubt this was copied from somewhere else.  But why do people go to the
effort of confusing readers by using "^" instead of "!="?  These aren't 
bit-oriented values.

Alan Stern

