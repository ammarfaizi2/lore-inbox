Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267499AbSLLUup>; Thu, 12 Dec 2002 15:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267502AbSLLUuo>; Thu, 12 Dec 2002 15:50:44 -0500
Received: from attila.bofh.it ([213.92.8.2]:51157 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id <S267499AbSLLUuT>;
	Thu, 12 Dec 2002 15:50:19 -0500
Date: Thu, 12 Dec 2002 21:57:30 +0100
From: "Marco d'Itri" <md@Linux.IT>
To: Jim Houston <jim.houston@attbi.com>, julie.n.fleischer@intel.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.51 nanosleep fails
Message-ID: <20021212205730.GA4564@wonderland.linux.it>
References: <3DF7A890.A688AF54@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF7A890.A688AF54@attbi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 11, Jim Houston <jim.houston@attbi.com> wrote:

 >I was able to reproduce this issue.  It happens on all the
 >kernels I tried including a stock Redhat kernel.  This is just 
 >an idiosyncrasy of strace. In this case both the strace and
No, it is not. It does not happen with 2.4.x kernel and probably did not
happen with 2.5.50.
It *does* happen with 2.5.51 even when strace is not used:

md@wonderland:~$LANG= tail -f /var/log/uucp/Log
[...]
uucico bofh - (2002-12-12 21:50:27.54 4484) Call complete (4 seconds 2336 bytes 584 bps)

[2]+  Stopped                 LANG= tail -f /var/log/uucp/Log
md@wonderland:~$ fg
LANG= tail -f /var/log/uucp/Log
tail: cannot read realtime clock: Bad address
[Exit 1]
md@wonderland:~$

-- 
ciao,
Marco
