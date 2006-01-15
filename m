Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWAOWOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWAOWOT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 17:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbWAOWOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 17:14:19 -0500
Received: from 213-140-2-71.ip.fastwebnet.it ([213.140.2.71]:44498 "EHLO
	aa004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1750925AbWAOWOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 17:14:19 -0500
Date: Sun, 15 Jan 2006 23:14:58 +0100
From: Mattia Dongili <malattia@linux.it>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       linux-xfs@oss.sgi.com
Subject: 2.6.15-mm3 bisection: git-xfs.patch makes reiserfs oops
Message-ID: <20060115221458.GA3521@inferi.kami.home>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
	linux-xfs@oss.sgi.com
References: <20060110235554.GA3527@inferi.kami.home> <20060110170037.4a614245.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110170037.4a614245.akpm@osdl.org>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.15-rc5-mm3-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[CC-in relevant people/ML]

Hello!

second bisection result!

On Tue, Jan 10, 2006 at 05:00:37PM -0800, Andrew Morton wrote:
> Mattia Dongili <malattia@linux.it> wrote:
[...]
> > 1- reiser3 oopsed[1] twice while suspending to ram. It seems
> >    reproducible (have some activity on the fs and suspend)
> 
> No significant reiser3 changes in there, so I'd be suspecting something
> else has gone haywire.

you're right: git-xfs.patch is the bad guy.

Unfortunately netconsole isn't helpful in capturing the oops (no serial
ports here) but I have two more shots (more readable):
http://oioio.altervista.org/linux/dsc03148.jpg
http://oioio.altervista.org/linux/dsc03149.jpg

BTW: I'm building -mm4 right now, will report tomorrow if the oops
persists.
-- 
mattia
:wq!
