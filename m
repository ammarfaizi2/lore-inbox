Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269324AbTGJPZY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 11:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268836AbTGJPZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 11:25:24 -0400
Received: from imap.gmx.net ([213.165.64.20]:61412 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269324AbTGJPZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 11:25:18 -0400
Message-ID: <3F0D88CB.3090303@gmx.net>
Date: Thu, 10 Jul 2003 17:39:55 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: de, en
MIME-Version: 1.0
To: Anders Karlsson <anders@trudheim.com>
CC: Stephan von Krawczynski <skraw@ithnet.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Oleg Drokin <green@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22-pre3 and reiserfs boot problem
References: <3F0D761E.2050702@gmx.net> <1057851052.7753.6.camel@tor.trudheim.com>
In-Reply-To: <1057851052.7753.6.camel@tor.trudheim.com>
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anders Karlsson wrote:
> Hi,
> 
> Apologies for chipping in, but I saw something similar to what was
> described in the thread. I'm running 2.4.22-pre3-ac1 with the FreeS/WAN
> 2.0.1 patches and noticed last night that when booting this kernel, if
> an ext3 filesystem had exceeded its mount count and required checking,
> the e2fsck process would hang sometime during the fsck and the system
> would become unresponsive, but SysRq would still work. Alt-SysRq-P would

Was there any disk activity after it became unresponsive? If not, please
provide a (partially) decoded SysRq-T. I'm only interested in the decoded
stack trace of the hung process (it should have a "D" after the process name).

> show e2fsck and some register details. I did not note them down, but
> booting 2.4.21-rc7-ac1 and letting that kernel check the filesystem
> would work. Booting back into 2.4.22-pre3-ac1 would then also work.
> 
> This might or might not be related to the original problem. I do use
> nmi_watchdog=1, NMI count is 1 presently, so I guess that works. The ram
> is memtested, so that is not an issue, heavy filesystem usage works
> normally, it was just e2fsck that would not work. I have not tried -pre2
> or -pre4 yet, but that is on the cards.
> 
> If there is anything I can try, let me know.


Carl-Daniel
-- 
http://www.hailfinger.org/

