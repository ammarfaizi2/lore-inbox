Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWAIP7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWAIP7g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 10:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWAIP7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 10:59:36 -0500
Received: from [81.2.110.250] ([81.2.110.250]:15066 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751209AbWAIP7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 10:59:35 -0500
Subject: Re: kernel BUG at drivers/ide/ide.c:1384!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0601091025480.17766@chaos.analogic.com>
References: <20060109095159.GE4535@charite.de>
	 <1136816352.6659.10.camel@localhost.localdomain>
	 <20060109141958.GM2767@charite.de>
	 <Pine.LNX.4.61.0601091025480.17766@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 09 Jan 2006 16:02:22 +0000
Message-Id: <1136822543.6659.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-01-09 at 10:30 -0500, linux-os (Dick Johnson) wrote:
> He might be able to do the same thing with `cat /dev/urandom > /dev/hda`.

Or by taking the lid off and painting it purple with pink spots, but
neither are relevant to the problem at hand.

> There are not a lot of file-system checks against bad data in file-systems.

Nothing to do with the file system

> The '-w' reset will guarantee bad data, which may propagate to the
> file-system(s) in use, causing all kinds of problems. So, the OOPS under
> these conditions is expected.

No. If the locking in the drivers is correct then -w is totally boringly
safe. But the locking isn't. Follow ups should probably go to the
linux-ide list. 

Alan

