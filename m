Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUEFQ3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUEFQ3u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 12:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUEFQ3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 12:29:50 -0400
Received: from adsl-216-102-214-42.dsl.snfc21.pacbell.net ([216.102.214.42]:29703
	"EHLO cynthia.pants.nu") by vger.kernel.org with ESMTP
	id S261169AbUEFQ3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 12:29:45 -0400
Date: Thu, 6 May 2004 09:29:43 -0700
From: Brad Boyer <flar@allandria.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
       Zhenmin Li <zli4@cs.uiuc.edu>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [OPERA] Potential bugs detected by static analysis tool in 2.6.4
Message-ID: <20040506162943.GA1205@pants.nu>
References: <002701c4331c$092a3b40$76f6ae80@Turandot> <Pine.GSO.4.58.0405061141290.12096@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0405061141290.12096@waterleaf.sonytel.be>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 11:43:45AM +0200, Geert Uytterhoeven wrote:
> On Wed, 5 May 2004, Zhenmin Li wrote:
> > 8. /arch/m68k/mac/iop.c, Line 164:
> 
> Should be line 264?

Perhaps they cut out the comments before counting lines? There are
around 100 lines of comments at the top explaining the whole mess.

In any case, line 264 sounds right. It's shortly after

if(macintosh_config->adb_type == MAC_ADB_IOP) {

> > iop_base[IOP_NUM_SCC]->status_ctrl = 0;
> >
> > Maybe change to:
> > iop_base[IOP_NUM_ISM]->status_ctrl = 0;
> 
> Mac guys, is this correct?

Actually, I think it is. It looks like this is a bug that crept in
during the last IOP rewrite (back in 2.2). It's not the same line
number in 2.2 and 2.4, but there is a similar situation. I'll see
if I can find some time to get my Mac IIfx running again and try
out a fix. I did get a 2.6 kernel running on it once before.

And as a note to the person who reported this, please include at
least a line or two of context around the change. If you use
diff -u, that's even better.

	Brad Boyer
	flar@allandria.com

