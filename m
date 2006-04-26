Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbWDZQMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbWDZQMS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 12:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWDZQMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 12:12:18 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:65166 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S932468AbWDZQMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 12:12:16 -0400
Date: Wed, 26 Apr 2006 18:12:14 +0200
From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
To: linux-kernel@vger.kernel.org
Subject: Re: kswapd oops reproduced with 2.6.17-rc2 (was Oops with 2.6.15.3 on amd64)
Message-ID: <20060426161214.GA13689@uio.no>
References: <20060422221232.GA6269@uio.no> <20060426151535.GA13203@uio.no> <200604261740.47107.Rafal.Wysocki@fuw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200604261740.47107.Rafal.Wysocki@fuw.edu.pl>
X-Operating-System: Linux 2.6.14.3 on a x86_64
X-Message-Flag: Outlook? --> http://www.mozilla.org/products/thunderbird/
User-Agent: Mutt/1.5.11+cvs20060403
X-Spam-Score: -0.0 (/)
X-Spam-Report: Status=No hits=-0.0 required=5.0 tests=NO_RELAYS version=3.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 05:40:46PM +0200, R. J. Wysocki wrote:
>> I reproduced this with 2.6.17-rc2 on the same machine:
>> 
>> [261604.531829] Unable to handle kernel paging request at ffff8000020369d8 RIP: 
>> [261604.536538] <ffffffff802509e6>{isolate_lru_pages+74}
> If your kernel is compiled with the debug info, could you please do
> "gdb vmlinux"  in the kernel sorces directory and then (in gdb)
> "l *(isolate_lru_pages+74)" to see which source line it corresponds to?

It isn't, but I hadn't changed the sources, .config or build environment
since I built it, so I did a straight recompile with CONFIG_DEBUG_INFO set,
and got:

  (gdb) l *(isolate_lru_pages+74)
  0xffffffff80250c2a is in isolate_lru_pages (list.h:154).

(I had to run gdb on a machine with 64-bit userspace, but I guess just
copying the vmlinux file should suffice.)

/* Steinar */
-- 
Homepage: http://www.sesse.net/
