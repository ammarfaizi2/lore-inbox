Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264117AbUESIoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264117AbUESIoa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 04:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264119AbUESIo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 04:44:29 -0400
Received: from anor.ics.muni.cz ([147.251.4.35]:58825 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S264117AbUESIo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 04:44:27 -0400
Date: Wed, 19 May 2004 10:44:14 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: sendfile -EOVERFLOW on AMD64
Message-ID: <20040519084414.GA18896@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

today (after the Fedora Core 2 release) I have discovered that my FTP
server (running AMD64) cannot correctly send the >2GB files using sendfile().
The server is ProFTPd, and the strace looks like this:

[...]
alarm(288)                              = 0
sendfile(14, 11, [139377240], 4231263656) = 2008106407
alarm(0)                                = 117
alarm(117)                              = 0
alarm(0)                                = 117
alarm(117)                              = 0
sendfile(14, 11, [2147483647], 2223157249) = -1 EOVERFLOW (Value too large for defined data type)

The image (FC2-i386-DVD.iso) has 4370640896 bytes. The FTP server is native
x86_64 binary, not a 32-bit one.

Thanks for any hints.

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
 Any compiler or language that likes to hide things like memory allocations
 behind your back just isn't a good choice for a kernel.   --Linus Torvalds
