Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266188AbUIOOLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266188AbUIOOLV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 10:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266173AbUIOOJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 10:09:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52127 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266236AbUIOOIB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 10:08:01 -0400
Date: Wed, 15 Sep 2004 09:44:50 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Marcin Ro?ek <marcin.rozek@ios.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at page_alloc.c
Message-ID: <20040915124449.GB2963@logos.cnet>
References: <414834AA.70602@ios.edu.pl> <20040915112102.GA1992@logos.cnet> <414844C5.6080802@ios.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414844C5.6080802@ios.edu.pl>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 03:33:57PM +0200, Marcin Ro?ek wrote:
> Marcelo Tosatti wrote:
> >Its the third or fourth report like this I see, all of them with the 
> >grsecurity patch applied.
> >
> >Have you tried a stock 2.4.27?
> No.
> Is that bug serious? Should i move to clean 2.4.27?

Yes it is quite serious... the VM is trying to free a page with ->mapping 
set (probably a pagecache page) which is not valid thing to happen (thus the BUG).

You can move to v2.4.27 to confirm you see or do not see the problem there.

> Strange is that previously i've been running (for quite long time) Mandrake 
> 9.1 on the same machine with 2.4.27-grsec (but with enabled 
> CONFIG_GRKERNSEC_PAX_MPROTECT) and i don't remember seeing such BUG...A

Search the archives for "grsecurity and 2.4.27" and take a look 
at the other reports.
