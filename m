Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVBGWbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVBGWbl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 17:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVBGWbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 17:31:41 -0500
Received: from gprs215-244.eurotel.cz ([160.218.215.244]:1408 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261269AbVBGWbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 17:31:24 -0500
Date: Mon, 7 Feb 2005 23:11:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: 2.6.11-rc3: Kylix application no longer works?
Message-ID: <20050207221107.GA1369@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have some obscure Kylix application here... It started gets
misteriously killed in 2.6.11-rc3 and -rc3-mm1...

pavel@amd:~/slovnik/bin$ strace ./Slovnik
execve("./Slovnik", ["./Slovnik"], [/* 32 vars */]) = 0
+++ killed by SIGKILL +++
pavel@amd:~/slovnik/bin$ ldd ./Slovnik
/usr/bin/ldd: line 1:  8759 Killed
LD_TRACE_LOADED_OBJECTS=1 LD_WARN= LD_BIND_NOW=
LD_LIBRARY_VERSION=$verify_out LD_VERBOSE= "$file"
pavel@amd:~/slovnik/bin$

I get this in 2.6.10-rc3:

pavel@amd:~/slovnik/bin$ ./Slovnik
./Slovnik: relocation error: ./Slovnik: undefined symbol:
initPAnsiStrings
pavel@amd:~/slovnik/bin$ ldd ./Slovnik
                libz.so.1 => /usr/lib/libz.so.1 (0xb7fc2000)
        libX11.so.6 => /usr/X11/lib/libX11.so.6 (0xb7efa000)
        libpthread.so.0 => /lib/libpthread.so.0 (0xb7ea9000)
        libdl.so.2 => /lib/libdl.so.2 (0xb7ea6000)
        libc.so.6 => /lib/libc.so.6 (0xb7d73000)
        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0xb7fea000)
pavel@amd:~/slovnik/bin$

When I set LD_LIBRARY_PATH right, it will actually work. Any ideas?

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
