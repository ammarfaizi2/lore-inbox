Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbVDEJN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVDEJN0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 05:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbVDEJN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 05:13:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:19934 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261641AbVDEJNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 05:13:20 -0400
Date: Tue, 5 Apr 2005 10:12:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@linux.ie>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
Message-ID: <20050405091255.GA28343@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
	Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
References: <20050405000524.592fc125.akpm@osdl.org> <20050405074405.GE26208@infradead.org> <16978.22078.532831.667378@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16978.22078.532831.667378@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 07:11:26PM +1000, Paul Mackerras wrote:
> Christoph Hellwig writes:
> 
> > Those DRI callers aren't in mainline but introduced in bk-drm.patch,
> > looks like the DRI folks need beating with a big stick..
> 
> Settle down Christoph, the compat_ioctl method is less than 3 months
> old, has only been in one official 2.6.x release, and isn't documented
> at all in the Documentation directory AFAICS.  Don't be so impatient.

It's documented where the other filesystem entry points are documented.
This is not about beeing impatient but about adding APIs that at the same
time are actively removed all over the tree.

> Anyway, I did the 32-bit ioctl conversion stuff for the DRM.  I'll
> look at changing it to use compat_ioctl.  The big question of course
> is whether the DRM code will work correctly without the BKL held.

You can of course take the BKL inside your ->compat_ioctl method.

