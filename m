Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWD3NPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWD3NPU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 09:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWD3NPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 09:15:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:43480 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751114AbWD3NPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 09:15:19 -0400
Subject: Re: another kconfig target for building monolithic kernel (for
	security) ?
From: Arjan van de Ven <arjan@infradead.org>
To: devzero@web.de
Cc: Nix <nix@esperi.org.uk>, davej@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1094806367@web.de>
References: <1094806367@web.de>
Content-Type: text/plain
Date: Sun, 30 Apr 2006 15:15:14 +0200
Message-Id: <1146402915.20760.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-04-30 at 14:31 +0200, devzero@web.de wrote:
> hello !
> 
> "Unfortunately, disabling /dev/mem will break many things, including X and potentially many other user-space programs"
> (-> http://lwn.net/2001/0419/security.php3 )

not if you do it carefully like we did for Fedora...

> 
> "The /dev/mem and /dev/kmem character special files provide access to a pseudo device driver that allows read and write access to system memory or I/O address space. Typically, these special files are used by operating system utilities and commands (such as sar, iostat, and vmstat) to obtain status and statistical information about the system" (ok, this is for AIX, does this apply for linux, too? -> http://publib.boulder.ibm.com/infocenter/pseries/v5r3/index.jsp?topic=/com.ibm.aix.doc/files/aixfiles/mem.htm )


/dev/kmem isn't used by much of anything except debugging, so having
that a config option is reasonable. for /dev/mem it's enough to disable
all access to 'what the kernel sees as RAM' with the lower 1Mb as
exception..

