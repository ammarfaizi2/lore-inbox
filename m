Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWDZPlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWDZPlH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 11:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbWDZPlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 11:41:07 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:4511 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S964796AbWDZPlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 11:41:06 -0400
From: "R. J. Wysocki" <Rafal.Wysocki@fuw.edu.pl>
Organization: FUW
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: kswapd oops reproduced with 2.6.17-rc2 (was Oops with 2.6.15.3 on amd64)
Date: Wed, 26 Apr 2006 17:40:46 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060422221232.GA6269@uio.no> <20060426151535.GA13203@uio.no>
In-Reply-To: <20060426151535.GA13203@uio.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604261740.47107.Rafal.Wysocki@fuw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 April 2006 17:15, Steinar H. Gunderson wrote:
> On Sun, Apr 23, 2006 at 12:12:32AM +0200, Steinar H. Gunderson wrote:
> > My dual-core AMD64 machine (Athlon 64 X2 3800+) has been unstable (hanging
> > completely from the to time) since I ever got it, with various kernels (2.6.8
> > up to 2.6.17-rc1), even more so after the I/O load increased on it (earlier
> > it hung about once a month; now it's more once a day). This time, however, I
> > had a minicom logging everything on the serial console, so I have a
> > traceback:
> 
> I reproduced this with 2.6.17-rc2 on the same machine:
> 
> [261604.531829] Unable to handle kernel paging request at ffff8000020369d8 RIP: 
> [261604.536538] <ffffffff802509e6>{isolate_lru_pages+74}

If your kernel is compiled with the debug info, could you please do
"gdb vmlinux"  in the kernel sorces directory and then (in gdb)
"l *(isolate_lru_pages+74)" to see which source line it corresponds to?

Greetings,
Rafael
