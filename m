Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263977AbTKJQM2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 11:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263978AbTKJQM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 11:12:28 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:13487 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263977AbTKJQM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 11:12:27 -0500
Date: Mon, 10 Nov 2003 16:11:14 +0000
From: Dave Jones <davej@redhat.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: EFAULT reading /dev/mem... - broken x86info
Message-ID: <20031110161114.GM10144@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org,
	manfred@colorfullife.com
References: <20031108162737.GB26350@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031108162737.GB26350@vana.vc.cvut.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 08, 2003 at 05:27:37PM +0100, Petr Vandrovec wrote:

 > After some tweaking around I found that I cannot read some pages from /dev/mem -
 > - I get -EFAULT on them. x86info run to the 0x86000 and 0x87000 pages, as it
 > scans 0x80000-0x8FFFF range for mptable.
 > 
 > After some thinking I believe that CONFIG_DEBUG_PAGEALLOC
 > is responsible for this problem. Should x86info (and other programs which
 > attempt to scan physical memory) cope with this inability to read /dev/mem, or
 > should be kernel fixed so /dev/mem really accesses physical memory and not kernel's
 > view of it? Or should I simple stop using CONFIG_DEBUG_PAGEALLOC?

I don't really have much insight into the behind the scenes going on's of
DEBUG_PAGEALLOC, so I don't know if your suggestion has merit or not.
Maybe Manfred can shed some insight?  This does seem to be a regression IMO
(Though I am somewhat biased as this breaks my app 8-)

		Dave

