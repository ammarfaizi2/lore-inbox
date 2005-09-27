Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965082AbVI0VRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbVI0VRc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 17:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbVI0VRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 17:17:32 -0400
Received: from mother.openwall.net ([195.42.179.200]:39642 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S965082AbVI0VRc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 17:17:32 -0400
Date: Wed, 28 Sep 2005 01:16:24 +0400
From: Solar Designer <solar@openwall.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergey Vlasov <vsu@altlinux.ru>,
       vendor-sec@lst.de, linux-kernel@vger.kernel.org,
       security@linux.kernel.org
Subject: Re: PID reuse safety for userspace apps (Re: [linux-usb-devel] Re: [Security] [vendor-sec] [BUG/PATCH/RFC] Oops while completing async USB via usbdevio)
Message-ID: <20050927211624.GA4947@openwall.com>
References: <20050925151330.GL731@sunbeam.de.gnumonks.org> <Pine.LNX.4.58.0509270746200.3308@g5.osdl.org> <20050927160029.GA20466@master.mivlgu.local> <Pine.LNX.4.58.0509270904140.3308@g5.osdl.org> <20050927165206.GB20466@master.mivlgu.local> <20050927172048.GA3423@openwall.com> <1127853252.10674.9.camel@localhost.localdomain> <Pine.LNX.4.58.0509271335530.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509271335530.3308@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 01:42:44PM -0700, Linus Torvalds wrote:
> Note that for at least signal sending, the security aspect is _not_ about 
> whether the pid has been re-used, but about whether the _user_ matches.

That's true.  And, changing topic to userspace apps, killall(1)
currently has no race-free way to check whether the user still matches.

There's also the reliability aspect: killing one's own process, but
other than the intended one, is a reliability issue.

What I have proposed is a way to deal with both of these.

killall is just an example.  A GUI point-and-click task manager would
have the same problem and the same solution would work for it.

-- 
Alexander
