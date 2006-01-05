Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWAEKkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWAEKkQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 05:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWAEKkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 05:40:16 -0500
Received: from canuck.infradead.org ([205.233.218.70]:63396 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1750769AbWAEKkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 05:40:15 -0500
Subject: Re: [PATCH] Debug shared irqs.
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060105021929.498f45ef.akpm@osdl.org>
References: <1135251766.3557.13.camel@pmac.infradead.org>
	 <20060105021929.498f45ef.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Jan 2006 10:39:58 +0000
Message-Id: <1136457598.4158.175.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-05 at 02:19 -0800, Andrew Morton wrote:
> This is going to cause me a ton of grief.  How's about you put it in
> Fedora for a few weeks, get all the drivers debugged first ;)

I'd do that normally, but it's the wrong point in the cycle -- we're
getting ready for Fedora Core 5 at the moment; it's not the time to be
doing such things. We can apply the patch... but we'd have to turn the
config option off :)

What you're seeing is the whole point of the patch, surely? And it _is_
a config option -- people aren't forced to turn it on.

Would it help if we added a printk to make it more obvious what's
happening, which gives the naïve user the opportunity to turn off the
config option just to get things working again? Somethign along the
lines of "Faking irq %d due to CONFIG_DEBUG_SHIRQ. If your machine
crashes now, don't blame akpm"?

Out of interest, does your i810 patch fix the problem which was reported
in November by Eyal Lebedinsky ("2.6.14.2: repeated oops in i810 init")?

-- 
dwmw2

