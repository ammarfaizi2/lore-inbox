Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964984AbVI0Qb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbVI0Qb1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 12:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbVI0Qb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 12:31:27 -0400
Received: from [81.2.110.250] ([81.2.110.250]:5324 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S964985AbVI0Qb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 12:31:27 -0400
Subject: Re: [linux-usb-devel] Re: [Security] [vendor-sec] [BUG/PATCH/RFC]
	Oops while completing async USB via usbdevio
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Sergey Vlasov <vsu@altlinux.ru>, Harald Welte <laforge@gnumonks.org>,
       linux-usb-devel@lists.sourceforge.net, vendor-sec@lst.de,
       linux-kernel@vger.kernel.org, greg@kroah.com, security@linux.kernel.org
In-Reply-To: <Pine.LNX.4.58.0509270904140.3308@g5.osdl.org>
References: <20050925151330.GL731@sunbeam.de.gnumonks.org>
	 <Pine.LNX.4.58.0509270746200.3308@g5.osdl.org>
	 <20050927160029.GA20466@master.mivlgu.local>
	 <Pine.LNX.4.58.0509270904140.3308@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 27 Sep 2005 17:58:00 +0100
Message-Id: <1127840281.10674.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-09-27 at 09:09 -0700, Linus Torvalds wrote:
> > root-owned), then the urb completes, and kill_proc_info() sends the
> > signal to the unsuspecting process.
> 
> Ehh.. pid's don't get re-used until they wrap.

Which doesn't take very long to arrange. Relying on pids is definitely a
security problem we don't want to make worse than it already is. 

> If you look it up by pid, it won't be stale, now will it?

Just potentially wrong, but if it uses the SIGIO code and the SIGIO code
is fixed then it works out.

